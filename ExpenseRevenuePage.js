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

var dbName = "leonardoTeste16"
var dbDesc = "User based local expense and revenue database"
var dbVer = "1.0"
var dbEstSize = 1000000

function monthSel(month, root, db) {
    root.header.text = qsTr(root[month].text + "/" + root.yearSel.value)
    root.state = "MSEL"

    // load data from current month and year, if not loaded yet
    var monthZeroPadded = (monthBt.indexOf(month)+1).toString()
    while (monthZeroPadded.length < 2) { monthZeroPadded = "0" + monthZeroPadded}
    var yearMonthString = root.yearSel.value + "-" + monthZeroPadded
    if(lastYearMonth === yearMonthString){
        // do nothing
    }
    else{
        listOfExpRevs.clear()
        loadDataFromDb(db, yearMonthString)
    }

    // set selected month and year for comparison
    lastYearMonth = yearMonthString
}

function setup(root){
    //set current year
    var currentDate = new Date()
    root.yearSel.value = currentDate.getFullYear()

    // Highlight current month button
    root[month[currentDate.getMonth()]+"Bt"].highlighted = true

}

function createConfigureDb(db){
    console.log("Database created: " + db);
    db.changeVersion("", dbVer) //this is for when the database is created
    db.transaction(function(tx){
        // create db for expenses and revenues if not exist
        tx.executeSql("CREATE TABLE IF NOT EXISTS exprev(" +
                      "value DOUBLE(16,2) DEFAULT '0.00' NOT NULL, " +
                      "exptype INT(1) DEFAULT '0' NOT NULL, " +
                      "category CHAR(40), " +
                      "description CHAR(160), " +
                      "date DATE" +
                      ")")
    })
    db.transaction(function(tx){
        // Create dummy initial values for testing
        try{
            var res = tx.executeSql("INSERT INTO exprev VALUES(?, ?, ?, ?, ?)",
                          ['150.00', '0', 'alimentacao', 'ida ao mercado para ceia', '2018-01-22'])
            var res = tx.executeSql("INSERT INTO exprev VALUES(?, ?, ?, ?, ?)",
                          ['250.00', '1', 'alimentacao', 'ida ao mercado de novo', '2018-01-30'])
            var res = tx.executeSql("INSERT INTO exprev VALUES(?, ?, ?, ?, ?)",
                          ['200.00', '0', 'alimentacao', 'ida ao mercado de novo', '2018-01-12'])
            var res = tx.executeSql("INSERT INTO exprev VALUES(?, ?, ?, ?, ?)",
                          ['250.00', '2', 'alimentacao', 'caetano de novo', '2018-01-13'])
            var res = tx.executeSql("INSERT INTO exprev VALUES(?, ?, ?, ?, ?)",
                          ['30.00', '1', 'lazer', 'festa de fim de ano', '2018-01-01'])
            var res = tx.executeSql("INSERT INTO exprev VALUES(?, ?, ?, ?, ?)",
                          ['2.50', '1', 'alimentacao', 'coxinha', '2018-01-30'])
            var res = tx.executeSql("INSERT INTO exprev VALUES(?, ?, ?, ?, ?)",
                          ['1000.00', '0', 'aluguel', 'aluguel', '2018-01-10'])
            var res = tx.executeSql("INSERT INTO exprev VALUES(?, ?, ?, ?, ?)",
                          ['271.21', '0', 'condomínio', 'condomínio', '2018-01-13'])
            var res = tx.executeSql("INSERT INTO exprev VALUES(?, ?, ?, ?, ?)",
                          ['20.00', '3', 'lazer', 'ida ao shopping', '2018-01-30'])
            var res = tx.executeSql("INSERT INTO exprev VALUES(?, ?, ?, ?, ?)",
                          ['350.00', '0', 'alimentacao', 'muitas despesas', '2017-07-30'])
            var res = tx.executeSql("INSERT INTO exprev VALUES(?, ?, ?, ?, ?)",
                          ['150.00', '0', 'alimentacao', 'ida ao mercado para ceia', '2018-01-22'])
            var res = tx.executeSql("INSERT INTO exprev VALUES(?, ?, ?, ?, ?)",
                          ['250.00', '0', 'alimentacao', 'ida ao mercado de novo', '2018-01-30'])
            var res = tx.executeSql("INSERT INTO exprev VALUES(?, ?, ?, ?, ?)",
                          ['200.00', '0', 'alimentacao', 'ida ao mercado de novo', '2018-01-12'])
            var res = tx.executeSql("INSERT INTO exprev VALUES(?, ?, ?, ?, ?)",
                          ['250.00', '0', 'alimentacao', 'caetano de novo', '2018-01-13'])
            var res = tx.executeSql("INSERT INTO exprev VALUES(?, ?, ?, ?, ?)",
                          ['30.00', '0', 'lazer', 'festa de fim de ano', '2018-01-01'])
            var res = tx.executeSql("INSERT INTO exprev VALUES(?, ?, ?, ?, ?)",
                          ['2.50', '0', 'alimentacao', 'coxinha', '2018-01-30'])
            var res = tx.executeSql("INSERT INTO exprev VALUES(?, ?, ?, ?, ?)",
                          ['1000.00', '0', 'aluguel', 'aluguel', '2018-01-10'])
            var res = tx.executeSql("INSERT INTO exprev VALUES(?, ?, ?, ?, ?)",
                          ['271.21', '0', 'condomínio', 'condomínio', '2018-01-13'])
            var res = tx.executeSql("INSERT INTO exprev VALUES(?, ?, ?, ?, ?)",
                          ['20.00', '0', 'lazer', 'ida ao shopping', '2018-01-30'])
            var res = tx.executeSql("INSERT INTO exprev VALUES(?, ?, ?, ?, ?)",
                          ['350.00', '0', 'alimentacao', 'muitas despesas', '2017-07-30'])
            console.log("Dummy added")
        }
        catch(err){
            console.log("Error inserting into table exprev: " + err)
        }
    })
}

function loadDataFromDb(db, yearMonthString){
    //console.log(JSON.stringify(listOfExpRevs))
    //console.log(JSON.stringify(expRevListView.count))
    db.transaction(function(tx){
        // Read whole db - not very good idea. Should filter for month and year!
        try{
            //var res = tx.executeSql("SELECT * FROM exprev WHERE strftime('%Y-%m-%d', date) BETWEEN '2017-12-01' AND '2017-12-31'")
            var res = tx.executeSql("SELECT * FROM exprev " +
                                    "WHERE strftime('%Y-%m', date) = '" + yearMonthString + "' " +
                                    "ORDER BY date")
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
                                         "datestring": res.rows.item(i).date.slice(8,10) + "/" + res.rows.item(i).date.slice(5,7) + "/" + res.rows.item(i).date.slice(2,4)
                                  })
            }
            listOfExpRevs.append({   "value": "",
                                     "exptype": 0,
                                     "image": "images/button_expense.png",
                                     "category": "",
                                     "description": "",
                                     "datestring": ""
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
    console.log(JSON.stringify(expRevListView.model.get(index)))
}

function saveChanges(db, type, index, value){
    //console.log("Value to be updated: " + value)
    //update value and save only if the value have changed
    if((expRevListView.model.get(index)[type] === value) && type !== "exptype")
        return
    else
        expRevListView.model.get(index)[type] = value
    //console.log(JSON.stringify(expRevListView.model))
    //console.log(JSON.stringify(expRevListView.model.get(index)))
    //just to make more readable, put the values in separate variables
    var d = new Object()
    d.value = expRevListView.model.get(index).value
    d.exptype = expRevListView.model.get(index).exptype
    d.category = expRevListView.model.get(index).category
    d.description = expRevListView.model.get(index).description
    d.datestring = "20" + expRevListView.model.get(index).datestring.slice(6,8) + "-" +
            expRevListView.model.get(index).datestring.slice(3,5) + "-" +
            expRevListView.model.get(index).datestring.slice(0,2)
    console.log("Data to be saved:\n" + JSON.stringify(d))
    if(index === (expRevListView.model.count - 1)){ //if last index, add entry
        console.log("Last index: " + index)
        // hey must do some check before adding!
        db.transaction(function(tx){
            // Insert entry - does not care about duplicates right now
            try{
                var res = tx.executeSql("INSERT INTO exprev VALUES(?, ?, ?, ?, ?)",
                              [d.value, d.exptype, d.category, d.description, d.datestring])
                console.log("Entry added")
            }
            catch(err){
                console.log("Error inserting into table exprev: " + err)
            }
        })
    }
    else{ // otherwise just update
        console.log("Some index: " + index)
        //updateEntry
    }

}
