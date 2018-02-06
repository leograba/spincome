var dbName = "leonardoTeste18"
//var dbName = "leonardo" //for release
//var dbName = dashboard.username
var dbDesc = "User based local expense and revenue database"
var dbVer = "1.0"
var dbEstSize = 1000000

var dbUserName;

function setDbFromUsername(rootObject) {
    //console.log(rootObject.username.text)
    dbUserName = rootObject.username.text
}

function getDbFromUsername(){
    return dbUserName
}

function genSqliteQuery(mode, tableName, dateFilter, typeFilter){
    var strInit = "SELECT rowid, * FROM ";
    var strDatestrIni = "WHERE strftime('%Y-%m', datestring) = '";
    var strDatestrEnd = "' ORDER BY datestring";
    var strWhere = "WHERE exptype = '";
    if(mode === 0){//get full db data
        return strInit + tableName;
    }
    else if(mode === 1){//get data from month/year
        return strInit + tableName + strDatestrIni + dateFilter + strDatestrEnd;
    }
    else if(mode === 2){//get data from time window
        return ;
    }
    else if(mode === 3){//get data from type
        return strInit + tableName + strWhere + typeFilter + strDatestrEnd;
    }
    else if(mode === 4){//get data from month/year and type
        return strInit + tableName + strDatestrIni + dateFilter "' AND exptype = '" + typeFilter + strDatestrEnd;
    }
    else if(mode === 5){//get data from time window and type
        return ;
    }
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
