// Act as library
.pragma library

// On Linux, DB file at
// ~/.local/share/qt-quick-first-try/QML/OfflineStorage/Databases/

var LocStorage;

/* Database related variables, constants, definitions */
var dbObj;
var dbName = "fgenDatabase"
//var dbName = "leonardoTeste18"
//var dbName = "leonardo" //for release
//var dbName = dashboard.username
var dbDesc = "User based local expense and revenue database"
var dbVer = "1.0"
var dbEstSize = 1000000

var lastAddedRow;
var dbUserName;

/* Available tables */
var expRevTableName = "exprev"
var loginInfoTableName = "loginusers"

function createConfigureDb(lcModule){
    LocStorage = lcModule
    //console.debug("dbDataHandling.js: createConfigureDb: Opening DB");
    dbObj = LocStorage.openDatabaseSync(dbName, dbVer, dbDesc, dbEstSize, function(db){
        db.changeVersion("", dbVer) //this is for when the database is created
        db.transaction(function(tx){
            // create table for user accounts
            tx.executeSql("CREATE TABLE IF NOT EXISTS users(" +
                          "username CHAR(40) UNIQUE NOT NULL, " +
                          "firstname CHAR(40), " +
                          "lastname CHAR(40), " +
                          "email CHAR(40) NOT NULL, " +
                          "password CHAR(160) NOT NULL" +
                          ")")
        })
        console.log("dbDataHandling.js: createConfigureDb: database created");
    })
}

function createUserTable(user, callback){
    /* Create a user table into the DB only if it doesn exist yet */

    dbObj.transaction(function(tx){
        // create table using tableString
        try{
            tx.executeSql("CREATE TABLE " + user + "(" +
                          "value DOUBLE(16,2) DEFAULT '0.00' NOT NULL, " +
                          "exptype INT(1) DEFAULT '0' NOT NULL, " +
                          "category CHAR(40), " +
                          "description CHAR(160), " +
                          "datestring DATE" +
                          ")")
            console.log("Created table for user: " + user)
            callback(false); return 0
        }
        catch(err){
            console.error("Error creating table for user: " + user)
            callback(err); return err
        }
    })
}

function setUsername(usrname) {
    /* Set the username, which is also the table with user data
     */

    dbUserName = usrname
    console.count("qml: dbDataHandling.js: setUsername: dbUserName:" + dbUserName + " - called times")
}

function getUsername(){
    /* Get the username assigned
       For internal usage whenever accessing the DB*/

    console.debug("dbDataHandling.js: getUsername: dbUserName: " + dbUserName)
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

function queryReadDb(queryStr, callback){
    /* Pass the object result of a DB query to a callback function
       Should make use of genSqliteQuery() to safely generate the query */

    //console.debug("dbDataHandling: queryReadDb: query string is " + queryStr)
    //console.debug("dbDataHandling: queryReadDb: db is " + JSON.stringify(db))
    dbObj.transaction(function(tx){
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

function queryWriteAddToDb(tableName, dataToWrite, callback){
    /* Write data to the specified DB
       must receive an array with ordered data to be saved, according to the DB table convention */

    var howManyProperties = "(?";
    for(var i = 1; i < dataToWrite.length; i++){//the first ? is already there
        howManyProperties += ", ?";
    }
    howManyProperties += ")"

    dbObj.transaction(function(tx){
        // Insert entry - don't care about duplicates right now
        try{
            var res = tx.executeSql("INSERT INTO " + tableName + " VALUES" + howManyProperties,
                          //[d.value, d.exptype, d.category, d.description, d.datestring])
                                    dataToWrite)
            console.log("dbDataHandling: queryWriteAddToDb: Entry added")
            console.log("\t" + dataToWrite)
        }
        catch(err){
            console.error("dbDataHandling: queryWriteAddToDb: error inserting into table " + tableName + ": " + err)
            if(typeof callback === "undefined") return err; //if no callback was passed
            callback(err); return err;
        }

        try{
            var res = tx.executeSql("SELECT last_insert_rowid() FROM " + tableName)
            console.debug("dbDataHandling: queryWriteAddToDb: last inserted rowid: " + JSON.stringify(res))
            lastAddedRow = Number(res.insertId)
            if(typeof callback === "undefined") return Number(res.insertId); //if no callback was passed
            callback(false)
            return Number(res.insertId) //using this may be trouble once start deleting entries!
        }
        catch(err){
            console.error("dbDataHandling: queryWriteAddToDb: error getting last inserted rowid: " + err)
            if(typeof callback === "undefined") return err; //if no callback was passed
            callback(err); return err;
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
