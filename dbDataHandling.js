/* Database variables */
var dbName = "leonardoTeste18"
//var dbName = "leonardo" //for release
//var dbName = dashboard.username
var dbDesc = "User based local expense and revenue database"
var dbVer = "1.0"
var dbEstSize = 1000000

var dbUserName;

/* Available tables */
var expRevTableName = "exprev"
var loginInfoTableName = "loginusers"

function setDbFromUsername(rootObject) {
    /* Set the name of the DB to be accessed
       Have to be called in every QML that imports this JS library*/

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
            callback(false ,JSON.stringify(res.rows.length));
        }
        catch(err){
            callback(true, err);
        }
    })
}

function queryWriteDb(db, dataToWrite){
    /* Write data to the specified DB
       It does all the job for now */
}

function query2string(queryInput){
    /* Format the query result - all fields to strings
       The queryInput can be generated with queryReadDb() */
}

function string2query(queryInput){
    /* Format strings from user input to be saved to db
       The queryInput can be generated with queryDb() */
}

function loadDataFromDb(db, yearMonthString){
    //console.log(JSON.stringify(listOfExpRevs))
    //console.log(JSON.stringify(expRevListView.count))
    var currentDate = new Date()
    var cdateStr = currentDate.getDate().toString();
    while (cdateStr.length < 2) { cdateStr = "0" + cdateStr}
    db.transaction(function(tx){
        try{
            //var res = tx.executeSql("SELECT * FROM exprev WHERE strftime('%Y-%m-%d', datestring) BETWEEN '2017-12-01' AND '2017-12-31'")
            var res = tx.executeSql("SELECT rowid, * FROM exprev " +
                                    "WHERE strftime('%Y-%m', datestring) = '" + yearMonthString + "' " +
                                    "ORDER BY datestring")
            for(var i = 0; i < res.rows.length; i++){
                var image;
                if(res.rows.item(i).exptype === 0) image = "images/button_expense.png"
                else if(res.rows.item(i).exptype === 1) image = "images/button_revenue.png"
                else if(res.rows.item(i).exptype === 2) image ="images/button_investment.png"
                else image ="images/button_loan.png"
                listOfExpRevs.append({   "value": res.rows.item(i).value.toFixed(2),
                                         //"exptype": res.rows.item(i).exptype.toString(),
                                         "exptype": res.rows.item(i).exptype,
                                         "image": image,
                                         "category": res.rows.item(i).category,
                                         "description": res.rows.item(i).description,
                                         //"datestring": res.rows.item(i).datestring.slice(8,10) + "/" + res.rows.item(i).datestring.slice(5,7) + "/" + res.rows.item(i).datestring.slice(2,4),
                                         "datestring": res.rows.item(i).datestring.slice(8,10),
                                         "rowid": res.rows.item(i).rowid
                                  })
                console.log("Date: " + res.rows.item(i).datestring)
            }
            listOfExpRevs.append({   "value": "",
                                     "exptype": 0,
                                     "image": "images/button_expense.png",
                                     "category": "",
                                     "description": "",
                                     "datestring": cdateStr,//force a date
                                     "rowid": null
                              })
            //listOfExpRevs.sync() // no need here, but needed in worker
            expRevListView.currentIndex = expRevListView.count - 1 //index is unset - jump to last index
            expRevListView.positionViewAtEnd() // this line removes animation when going to last index
            //console.log(JSON.stringify(listOfExpRevs))
            //console.log(JSON.stringify(expRevListView.count))
            console.log(JSON.stringify(expRevListView.currentIndex))
            console.log(JSON.stringify(expRevListView.model.get(0)))
        }
        catch(err){
            console.log("Error reading from table exprev: " + err)

        }
    })
}
