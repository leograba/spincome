//DataBase = require("/dbDataHandling.js")
         .import "/src/js/dbDataHandling.js" as DataBase

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

/* Constants */
var UNDEF_ROWID = -1

/* Variables*/
var lastYearMonth;

function setYearMonth(currentYearMonth){
    lastYearMonth = currentYearMonth
}

function getYearMonth(){
    return lastYearMonth
}

function monthSel(month, rootfrom, db) {
    /* Open the sheet for the corresponding month/year */

    console.debug("ExpenseRevenuePage.js: monthSel: user name is: TBD")
    rootfrom.header.text = qsTr(rootfrom[month].text + "/" + rootfrom.yearSel.value)
    rootfrom.state = "MSEL"

    // load data from current month and year, if not loaded yet
    var monthZeroPadded = (monthBt.indexOf(month)+1).toString()
    while (monthZeroPadded.length < 2) { monthZeroPadded = "0" + monthZeroPadded}
    setYearMonth(rootfrom.yearSel.value + "-" + monthZeroPadded)

    loadDataFromDb(getYearMonth())
}

function yearMonthSetup(rootfrom){
    //set current year
    var currentDate = new Date()
    rootfrom.yearSel.value = currentDate.getFullYear()

    // Highlight current month button
    rootfrom[month[currentDate.getMonth()]+"Bt"].highlighted = true
}

function newLineObject(){
    /* Return object to be appended to list of entries*/
    var currentDate = new Date()
    var cdateStr = currentDate.getDate().toString();
    while (cdateStr.length < 2) { cdateStr = "0" + cdateStr}
    //console.debug("ExpenseRevenuePage.js: newLineObject: date string is: " + cdateStr)
    var nl = {   "value": "",
        "exptype": 0,
        "image": "/images/button_expense.png",
        "category": "",
        "description": "",
        "datestring": cdateStr, //force a date
        "rowid": UNDEF_ROWID
    }
    return nl
}

function loadDataFromDb(yymmStr){
    /* Uses the DataBase module to load data from the curretly logged-in user */

    DataBase.queryReadDb(DataBase.genSqliteQuery(1, DataBase.getUsername(), yymmStr, ""), function(err, data){
        console.debug("ExpenseRevenuePage.js: loadDataFromDb: data is: " + JSON.stringify(data))
        if(!err) { // what to do if error happens?
            DataBase.query2string(data, function(err, strResult){
                if(!err){
                    //console.debug("ExpenseRevenuePage.js: loadDataFromDb:  Result of query2string: " + JSON.stringify(strResult))
                    listOfExpRevs.append(strResult)
                    listOfExpRevs.append(newLineObject())
                    //listOfExpRevs.sync() // no need here, but needed in worker
                    expRevListView.currentIndex = expRevListView.count - 1 //index is unset - jump to last index
                    expRevListView.positionViewAtEnd() // this line removes animation when going to last index
                    //console.debug("ExpenseRevenuePage.js: loadDataFromDb: " + JSON.stringify(listOfExpRevs))
                    //console.debug("ExpenseRevenuePage.js: loadDataFromDb: " + JSON.stringify(expRevListView.count))
                    //console.debug("ExpenseRevenuePage.js: loadDataFromDb: " + JSON.stringify(expRevListView.currentIndex))
                    //console.debug("ExpenseRevenuePage.js: loadDataFromDb: " + JSON.stringify(expRevListView.model.get(0)))
                }
            })
        }
    });
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
        expRevListView.model.get(index).image = "/images/button_revenue.png"
    }
    else if(expRevListView.model.get(index).exptype === 1){
        expRevListView.model.get(index).exptype = 2
        expRevListView.model.get(index).image = "/images/button_investment.png"
    }
    else if(expRevListView.model.get(index).exptype === 2){
        expRevListView.model.get(index).exptype = 3
        expRevListView.model.get(index).image = "/images/button_loan.png"
    }
    else{
        expRevListView.model.get(index).exptype = 0
        expRevListView.model.get(index).image = "/images/button_expense.png"
    }
    console.debug("ExpenseRevenuePage.js: revOrExpHandle: " + JSON.stringify(expRevListView.model.get(index)))
}

function createArrayFromInputLine(line){
    var d = [] //order matters here!
    //d.rowid = expRevListView.model.get(index).rowid //rowid is handled automatically
    d.push(line.value)
    d.push(line.exptype)
    d.push(line.category)
    d.push(line.description)
    if(line.datestring){ // this condition may be removed now that current date is being forced on new entry
        d.push(getYearMonth() + "-" + line.datestring)
    }
    else d.push(getYearMonth() + "-01") //Date is required when loading data from db
    return d
}

function typeToIndex(type){
    /*The type is ordered based on the DB table creation, return the corresponding value*/
    if(type === "value") return 0
    else if(type === "exptype") return 1
    else if(type === "category") return 2
    else if(type === "description") return 3
    else if(type === "datestring") return 4
    else return -1
}

function saveChanges(type, index, value){
    /* Update value and save only if the value have changed */
    var lastIndex = expRevListView.model.count - 1
    var currRowid = expRevListView.model.get(index).rowid
    if((expRevListView.model.get(index)[type] === value) && type !== "exptype")
        return //value did not change, no need to update
    else
        expRevListView.model.get(index)[type] = value
    //console.debug("ExpenseRevenuePage.js: saveChanges: " + JSON.stringify(expRevListView.model))
    //console.debug("ExpenseRevenuePage.js: saveChanges: " + JSON.stringify(expRevListView.model.get(index)))
    //just to make more readable, put the values in separate variables
    var d = createArrayFromInputLine(expRevListView.model.get(index))
    console.debug("ExpenseRevenuePage.js: saveChanges: Data to be saved:\n\t" + JSON.stringify(d))
    if((index === lastIndex) && currRowid === UNDEF_ROWID){ //if last index and entry have not been added yet, add entry
        // Not sure using last index is a good idea, or even needed at all
        console.debug("ExpenseRevenuePage.js: saveChanges: New entry: " + index)
        // hey must do some check before adding!
        DataBase.queryWriteAddToDb(DataBase.getUsername(), d, function(err){
            if(err !== false) console.debug("ExpenseRevenuePage.js: saveChanges: Unable to create new entry in the DB")
            else{
                //console.debug("ExpenseRevenuePage.js: saveChanges: last added row id is: " + DataBase.getLastAddedRow())
                expRevListView.model.setProperty(index, "rowid", Number(DataBase.getLastAddedRow()))
                //console.debug("ExpenseRevenuePage.js: saveChanges: last added row id is: " + JSON.stringify(expRevListView.model.get(index)))
                listOfExpRevs.append(newLineObject())
            }
        })
    }
    else{ // otherwise just update
        console.debug("ExpenseRevenuePage.js: saveChanges: Already placed entry: " + index)
        DataBase.queryUpdateDb(DataBase.getUsername(), currRowid, type, d[typeToIndex(type)])
    }
}
