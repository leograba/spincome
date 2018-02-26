/* Database related variables, constants, definitions */
var dbName = "leonardoTeste18"
//var dbName = "leonardo" //for release
//var dbName = dashboard.username
var dbDesc = "User based local expense and revenue database"
var dbVer = "1.0"
var dbEstSize = 1000000
var dbTableExprevStr =  "CREATE TABLE IF NOT EXISTS exprev(" +
                        "value DOUBLE(16,2) DEFAULT '0.00' NOT NULL, " +
                        "exptype INT(1) DEFAULT '0' NOT NULL, " +
                        "category CHAR(40), " +
                        "description CHAR(160), " +
                        "datestring DATE" +
                        ")"

var lastAddedRow;
var dbUserName;

/* Available tables */
var expRevTableName = "exprev"
var loginInfoTableName = "loginusers"

function createConfigureTable(db, tableString){
    /* Create a table into the DB
       Should only use the constants defined in this file "dbTable<table>Str" e.g. dbTableExprevStr */

    console.debug("dbDataHandling.js: createConfigureTable: database created: " + db);
    db.changeVersion("", dbVer) //this is for when the database is created, otherwise has no effect
    db.transaction(function(tx){
        // create db using tableString
        tx.executeSql(tableString)
    })
}

function setDbFromUsername(rootObject) {
    /* Set the name of the DB to be accessed
       Have to be called in every QML that imports this JS library */

    dbUserName = rootObject.userName
    console.debug("dbDataHandling.js: setDbFromUsername: dbUserName: " + dbUserName)
}

function getDbFromUsername(){
    /* Get the name of the DB to be accessed
       For internal usage whenever accessing the DB*/

    console.debug("dbDataHandling.js: getDbFromUsername: dbUserName: " + dbUserName)
    return dbUserName
}

function genSqliteQuery(mode, tableName, dateFilter, typeFilter){
    /* Create DB query string for this application use-cases
       Please always pass all arguments. Use empty string if need to pass empty argument */

    var strInit = "SELECT rowid, * FROM ";
    var strDatestrIni = " WHERE strftime('%Y-%m', datestring) = '";
    var strDatestrEnd = "' ORDER BY datestring";
    var strWhere = " WHERE exptype = '";
    var fullStr = "";

    if( typeof dateFilter === "undefined" || typeof typeFilter === "undefined"){
        throw "Error: no dateFilter and/or typeFilter passed!\n" + console.trace()
    }

    if(mode === 0){//get full db data
        fullStr = strInit + tableName;
        return fullStr;
    }
    else if(mode === 1 && dateFilter){//get data from month/year
        fullStr = strInit + tableName + strDatestrIni + dateFilter + strDatestrEnd;
        return fullStr;
    }
    else if(mode === 2){//get data from time window
        return fullStr;
    }
    else if(mode === 3){//get data from type
        fullStr = strInit + tableName + strWhere + typeFilter + strDatestrEnd;
        return fullStr;
    }
    else if(mode === 4 && dateFilter && typeFilter){//get data from month/year and type
        fullStr = strInit + tableName + strDatestrIni + dateFilter + "' AND exptype = '" + typeFilter + strDatestrEnd;
        return fullStr;
    }
    else if(mode === 5){//get data from time window and type
        return fullStr;
    }
    else throw "Error: mode/dateFilter/typeFilter condition does not match the available options!\n" + console.trace()
}

function queryReadDb(db, queryStr, callback){
    /* Pass the object result of a DB query to a callback function
       Should make use of genSqliteQuery() to safely generate the query */

    //console.debug("dbDataHandling: queryReadDb: query string is " + queryStr)
    //console.debug("dbDataHandling: queryReadDb: db is " + JSON.stringify(db))
    db.transaction(function(tx){
        try{
            var res = tx.executeSql(queryStr) //run the query
            //var res = tx.executeSql("SELECT * FROM exprev")
            console.debug("dbDataHandling.js: queryReadDb: passing DB read to callback")
            callback(false, res);
        }
        catch(err){
            callback(true, err);
        }
    })
}

function queryWriteAddToDb(db, tableName, dataToWrite){
    /* Write data to the specified DB
       must receive an array with ordered data to be saved, according to the DB table convention */

    var howManyProperties = "(?";
    for(var i = 1; i < dataToWrite.length; i++){//the first ? is already there
        howManyProperties += ", ?";
    }
    howManyProperties += ")"

    db.transaction(function(tx){
        // Insert entry - don't care about duplicates right now
        try{
            var res = tx.executeSql("INSERT INTO " + tableName + " VALUES" + howManyProperties,
                          //[d.value, d.exptype, d.category, d.description, d.datestring])
                                    dataToWrite)
            console.log("dbDataHandling: queryWriteAddToDb: Entry added")
            console.log("\t" + dataToWrite)
        }
        catch(err){
            console.error("dbDataHandling: queryWriteAddToDb: error inserting into table exprev: " + err)
        }

        try{
            var res = tx.executeSql("SELECT last_insert_rowid() FROM exprev")
            console.debug("dbDataHandling: queryWriteDb: last inserted rowid: " + JSON.stringify(res))
            lastAddedRow = Number(res.insertId)
            return Number(res.insertId) //using this may be trouble once start deleting entries!
        }
        catch(err){
            console.error("dbDataHandling: queryWriteDb: error getting last inserted rowid: " + err)
        }
    })
}

function queryUpdateDb(db, tableName, rowId, typeField, dataToWrite){
    /* Update data on the specified DB
       update a single table field (type) from a specified row ID */

    db.transaction(function(tx){
        // Update entry - don't care about duplicates right now
        try{
            var res = tx.executeSql("UPDATE " + tableName + " SET " + typeField + " = '" + dataToWrite + "' " +
                                    "WHERE rowid = " + rowId +";")
            console.debug("dbDataHandling: queryUpdateDb: entry updated: " + typeField + "(" + rowId + ")=" + dataToWrite)
        }
        catch(err){
            console.error("dbDataHandling: queryUpdateDb: Error updating table: " + err)
        }
    })
}

function query2string(queryInput, callback){
    /* Format the query result - all fields to strings
       The queryInput can be generated with queryReadDb() */

    //console.log("dbDataHandling.js: query2string: input length: " + queryInput.rows.length)
    var queryOutput = [];

    for(var i = 0; i < queryInput.rows.length; i++){
        var image;
        if(queryInput.rows.item(i).exptype === 0) image = "images/button_expense.png"
        else if(queryInput.rows.item(i).exptype === 1) image = "images/button_revenue.png"
        else if(queryInput.rows.item(i).exptype === 2) image ="images/button_investment.png"
        else image ="images/button_loan.png"
        queryOutput.push({  "value": queryInput.rows.item(i).value.toFixed(2),
                            //"exptype": queryInput.rows.item(i).exptype.toString(),
                            "exptype": queryInput.rows.item(i).exptype,
                            "image": image,
                            "category": queryInput.rows.item(i).category,
                            "description": queryInput.rows.item(i).description,
                            //"datestring": queryInput.rows.item(i).datestring.slice(8,10) + "/" + queryInput.rows.item(i).datestring.slice(5,7) + "/" + queryInput.rows.item(i).datestring.slice(2,4),
                            "datestring": queryInput.rows.item(i).datestring.slice(8,10),
                            "rowid": queryInput.rows.item(i).rowid
                          })
    }

    //console.log("dbDataHandling.js: query2string: output length: " + queryOutput.length)
    if(typeof callback === "undefined") return queryOutput; //if no callback was passed
    callback(false, queryOutput); return 0;
}
