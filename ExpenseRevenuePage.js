//DataBase = require("/dbDataHandling.js")
         .import "/dbDataHandling.js" as DataBase

const month = new Array();
month[0] = "jan";
month[1] = "feb";
month[2] = "mar";
month[3] = "apr";
month[4] = "may";
month[5] = "jun";
month[6] = "jul";
month[7] = "aug";
month[8] = "sep";
month[9] = "oct";
month[10] = "nov";
month[11] = "dec";

const monthBt = new Array();
monthBt[0] = "janBt";
monthBt[1] = "febBt";
monthBt[2] = "marBt";
monthBt[3] = "aprBt";
monthBt[4] = "mayBt";
monthBt[5] = "junBt";
monthBt[6] = "julBt";
monthBt[7] = "augBt";
monthBt[8] = "sepBt";
monthBt[9] = "octBt";
monthBt[10] = "novBt";
monthBt[11] = "decBt";

var dbName = "leonardoTeste18"
//var dbName = "leonardo" //for release
//var dbName = dashboard.username
var dbDesc = "User based local expense and revenue database"
var dbVer = "1.0"
var dbEstSize = 1000000

function monthSel(month, rootfrom, db) {
    /* Open the sheet for the corresponding month/year */

    console.debug("ExpenseRevenuePage.js: monthSel: user name is: TBD")
    rootfrom.header.text = qsTr(rootfrom[month].text + "/" + rootfrom.yearSel.value)
    rootfrom.state = "MSEL"

    // load data from current month and year, if not loaded yet
    var monthZeroPadded = (monthBt.indexOf(month)+1).toString()
    while (monthZeroPadded.length < 2) { monthZeroPadded = "0" + monthZeroPadded}
    var yearMonthString = rootfrom.yearSel.value + "-" + monthZeroPadded
    if(lastYearMonth === yearMonthString){
        // do nothing
    }
    else{
        listOfExpRevs.clear() // clear data
        loadDataFromDb(db, yearMonthString)
    }

    // set selected month and year for comparison
    lastYearMonth = yearMonthString
}

function setup(rootfrom){
    //set current year
    var currentDate = new Date()
    rootfrom.yearSel.value = currentDate.getFullYear()

    // Highlight current month button
    rootfrom[month[currentDate.getMonth()]+"Bt"].highlighted = true

}

function createConfigureDb(db){
    console.debug("ExpenseRevenuePage.js: createConfigureDb: database created: " + db);
    db.changeVersion("", dbVer) //this is for when the database is created
    db.transaction(function(tx){
        // create db for expenses and revenues if not exist
        tx.executeSql("CREATE TABLE IF NOT EXISTS exprev(" +
                      "value DOUBLE(16,2) DEFAULT '0.00' NOT NULL, " +
                      "exptype INT(1) DEFAULT '0' NOT NULL, " +
                      "category CHAR(40), " +
                      "description CHAR(160), " +
                      "datestring DATE" +
                      ")")
    })
}

function loadDataFromDb(db, yearMonthString){
    //console.debug("ExpenseRevenuePage.js: loadDataFromDb: listOfExpRevs: \n\t" + JSON.stringify(listOfExpRevs))
    //console.debug("ExpenseRevenuePage.js: loadDataFromDb: number of ExpRevs: " + JSON.stringify(expRevListView.count))
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
                //console.debug("ExpenseRevenuePage.js: loadDataFromDb: datestring: " + res.rows.item(i).datestring)
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
            //console.debug("ExpenseRevenuePage.js: loadDataFromDb: " + JSON.stringify(listOfExpRevs))
            //console.debug("ExpenseRevenuePage.js: loadDataFromDb: " + JSON.stringify(expRevListView.count))
            console.debug("ExpenseRevenuePage.js: loadDataFromDb: " + JSON.stringify(expRevListView.currentIndex))
            console.debug("ExpenseRevenuePage.js: loadDataFromDb: " + JSON.stringify(expRevListView.model.get(0)))
        }
        catch(err){
            console.error("ExpenseRevenuePage.js: loadDataFromDb: Error reading from table: " + err)

        }
    })
}

function highlightOnClick(index){
    expRevListView.currentIndex = index
}

function highlightOnTab(index, isLastCol, reverse){
    if(isLastCol && !reverse)
        expRevListView.currentIndex = index + 1
    else if(isLastCol && reverse)
        expRevListView.currentIndex = index - 1
    else
        expRevListView.currentIndex = index
}

function revOrExpHandle(index){
    if(expRevListView.model.get(index).exptype === 0){
        expRevListView.model.get(index).exptype = 1
        expRevListView.model.get(index).image = "images/button_revenue.png"
    }
    else if(expRevListView.model.get(index).exptype === 1){
        expRevListView.model.get(index).exptype = 2
        expRevListView.model.get(index).image = "images/button_investment.png"
    }
    else if(expRevListView.model.get(index).exptype === 2){
        expRevListView.model.get(index).exptype = 3
        expRevListView.model.get(index).image = "images/button_loan.png"
    }
    else{
        expRevListView.model.get(index).exptype = 0
        expRevListView.model.get(index).image = "images/button_expense.png"
    }
    console.debug("ExpenseRevenuePage.js: revOrExpHandle: " + JSON.stringify(expRevListView.model.get(index)))
}

function saveChanges(db, type, index, value, rootfrom){
    //console.debug("ExpenseRevenuePage.js: saveChanges: Value to be updated: " + value)
    //update value and save only if the value have changed
    var lastIndex = expRevListView.model.count - 1
    var currRowid = expRevListView.model.get(index).rowid
    if((expRevListView.model.get(index)[type] === value) && type !== "exptype")
        return //value did not change, no need to update
    else
        expRevListView.model.get(index)[type] = value
    //console.debug(ExpenseRevenuePage.js: saveChanges: JSON.stringify(expRevListView.model))
    //console.debug(ExpenseRevenuePage.js: saveChanges: JSON.stringify(expRevListView.model.get(index)))
    //just to make more readable, put the values in separate variables
    var d = new Object()
    //d.rowid = expRevListView.model.get(index).rowid //rowid is handled automatically
    d.value = expRevListView.model.get(index).value
    d.exptype = expRevListView.model.get(index).exptype
    d.category = expRevListView.model.get(index).category
    d.description = expRevListView.model.get(index).description
    if(expRevListView.model.get(index).datestring){ // this condition may be removed now that current date is being forced on new entry
        /*d.datestring = "20" + expRevListView.model.get(index).datestring.slice(6,8) + "-" +
                expRevListView.model.get(index).datestring.slice(3,5) + "-" +
                expRevListView.model.get(index).datestring.slice(0,2)*/
        d.datestring = rootfrom.lastYearMonth + "-" + expRevListView.model.get(index).datestring
    }
    else d.datestring = rootfrom.lastYearMonth + "-01" //Date is required when loading data from db
    console.debug("ExpenseRevenuePage.js: saveChanges: Data to be saved:\n" + JSON.stringify(d))
    if((index === lastIndex) && !currRowid){ //if last index and entry have not been added yet, add entry
        console.debug("ExpenseRevenuePage.js: saveChanges: New entry: " + index)
        // hey must do some check before adding!
        db.transaction(function(tx){
            // Insert entry - don't care about duplicates right now
            try{
                var res = tx.executeSql("INSERT INTO exprev VALUES(?, ?, ?, ?, ?)",
                              [d.value, d.exptype, d.category, d.description, d.datestring])
                console.log("ExpenseRevenuePage.js: saveChanges: Entry added")

            }
            catch(err){
                console.error("ExpenseRevenuePage.js: saveChanges: Error inserting into table exprev: " + err)
            }
            try{
                var res = tx.executeSql("SELECT last_insert_rowid() FROM exprev")
                expRevListView.model.get(index).rowid = Number(res.insertId)
                console.debug("ExpenseRevenuePage.js: saveChanges: Last inserted rowid: " + JSON.stringify(res))
            }
            catch(err){
                console.error("ExpenseRevenuePage.js: saveChanges: Error getting last inserted rowid: " + err)
            }
            listOfExpRevs.append({   "value": "",
                                     "exptype": 0,
                                     "image": "images/button_expense.png",
                                     "category": "",
                                     "description": "",
                                     "datestring": "",
                                     "rowid": null
                              })
        })
    }
    else{ // otherwise just update
        console.debug("ExpenseRevenuePage.js: saveChanges: Already placed entry: " + index)
        db.transaction(function(tx){
            // Update entry - don't care about duplicates right now
            try{
                var res = tx.executeSql("UPDATE exprev SET " + type + " = '" + d[type] + "' " +
                                        "WHERE rowid = " + currRowid +";")
                console.log("ExpenseRevenuePage.js: saveChanges: Entry updated")
            }
            catch(err){
                console.error("ExpenseRevenuePage.js: saveChanges: Error inserting into table exprev: " + err)
            }
        })
    }

}
