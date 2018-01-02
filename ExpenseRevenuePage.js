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

var dbName = "leonardoTeste15"
var dbDesc = "User based local expense and revenue database"
var dbVer = "1.0"
var dbEstSize = 1000000

function monthSel(month, root, db) {
    root.header.text = qsTr(root[month].text + "/" + root.yearSel.value)
    root.state = "MSEL"

    // load data from current month and year
    var monthZeroPadded = (monthBt.indexOf(month)+1).toString()
    while (monthZeroPadded.length < 2) { monthZeroPadded = "0" + monthZeroPadded}
    var yearMonthString = root.yearSel.value + "-" + monthZeroPadded
    loadDataFromDb(db, yearMonthString)
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
            var res = tx.executeSql("SELECT * FROM exprev WHERE strftime('%Y-%m', date) = '" + yearMonthString + "' ORDER BY date")
            for(var i = 0; i < res.rows.length; i++){
                listOfExpRevs.append({   "value": res.rows.item(i).value.toFixed(2),
                                      "exptype": res.rows.item(i).exptype.toString(),
                                      "category": res.rows.item(i).category,
                                      "description": res.rows.item(i).description,
                                      "datestring": res.rows.item(i).date
                                  })
            }
            listOfExpRevs.sync() // no need here, but just to remember if ever needed
            expRevListView.currentIndex = expRevListView.count - 1 //index is unset - jump to last index
            //expRevListView.positionViewAtEnd() // this line would remove animation when going to last index
            //console.log(JSON.stringify(listOfExpRevs))
            //console.log(JSON.stringify(expRevListView.count))
            console.log(JSON.stringify(expRevListView.currentIndex))
            console.log(JSON.stringify(expRevListView.model.get(0).datestring))
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
