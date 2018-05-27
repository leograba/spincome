.import "/src/js/dbDataHandling.js" as DataBase

// Act as library
.pragma library

/* Constants */

/* Variables*/
var dashboardModelData;
var yearMonth;

function yearMonthSetup(){
    /* Set year and month in a global variable to be used by other functions
        set as a string in the format YYYY-mm ready for DB consultation */
    var currentDate = new Date()
    var cmonthStr = (currentDate.getMonth() + 1).toString(); // month 0 is actually 1 to SQLite
    while (cmonthStr.length < 2) { cmonthStr = "0" + cmonthStr}
    var cyearStr = currentDate.getFullYear().toString()

    yearMonth = cyearStr + "-" + cmonthStr
}

function getFullYearMonthStr(){
    return yearMonth
}

function setDashModel(mdl){
    dashboardModelData = mdl
}

function getDashModel(){
    return dashboardModelData
}

function appendInfo(type, ratio, val, mdl){
    /* Append specific information to the dashboard, with predefined labels and colors
        order matters when appending, if needed to modify, use set instead */
    var d = {vlue: String(val), progress: ratio};
    switch(type){
    case 0:
        d.name = qsTr("Receita")
        d.colorCode = "green"
        break
    case 1:
        d.name = qsTr("Despesa")
        d.colorCode = "red"
        break
    case 2:
        d.name = qsTr("Investimento")
        d.colorCode = "blue"
        break
    case 3:
        d.name = qsTr("Empréstimo")
        d.colorCode = "orange"
        break
    case 4:
        d.name = qsTr("Saldo Total")
        if(val >= 0)
            d.colorCode = "green"
        else
            d.colorCode = "red"
        break
    case 5:
        d.name = qsTr("Investimento Total")
        d.colorCode = "blue"
        break
    case 6:
        d.name = qsTr("Retorno de Investimento")
        if(val >= 0)
            d.colorCode = "green"
        else
            d.colorCode = "red"
        break
    case 7:
        d.name = qsTr("Despesa/Orçamento")
        if(val >= 0)
            d.colorCode = "green"
        else
            d.colorCode = "red"
        break
    default:
        console.error("DashboardPage.js: appendInfo: type not defined")
        return
    }
    mdl.append(d)
}

function refreshInfo(mdl, month){
    /* Get data from the current user DB and displays
        the consolidated information on the dashboard*/

    console.debug("DashboardPage.js: refreshInfo: Refreshing dashboard information")

    var revenue = 0, expenses = 0, investments = 0, loans = 0;
    var balance = 0, interestRate = 0, budget = 0;
    var totalMonth = 0, totalInvested = 0, totalEver = 0;

    mdl.clear()
    // Get data from current month only
    var cmonth = DataBase.genSqliteQuery(1, DataBase.getExprevTableName(), getFullYearMonthStr(), "")
    //console.debug("DashboardPage.js: refreshInfo: the string is: \n\t" + cmonth)
    DataBase.queryReadDb(cmonth, function(err, data){
        if(!err){
            for(var i = 0; i < data.rows.length; i++){
                if(data.rows.item(i).exptype === 0){ //expense
                    expenses += data.rows.item(i).value
                }
                else if(data.rows.item(i).exptype === 1){ //revenue
                    revenue += data.rows.item(i).value
                }
                else if(data.rows.item(i).exptype === 2){ //investment
                    investments += data.rows.item(i).value
                }
                else if(data.rows.item(i).exptype === 3){ //loan
                    loans += data.rows.item(i).value
                }
            }
            // Negative values are being disregarded
            totalMonth = revenue + expenses + investments + loans
            appendInfo(0, revenue / totalMonth, revenue, mdl)
            appendInfo(1, expenses / totalMonth, expenses, mdl)
            appendInfo(2, investments / totalMonth, investments, mdl)
            appendInfo(3, loans / totalMonth, loans, mdl)
        }
    })

    // Get all available data
    //var amonth = DataBase.genSqliteQuery(0, DataBase.getExprevTableName(), "", "")
    //appendInfo(0, 0.4, 7000.00, mdl)
    //appendInfo(4, 0.6, -10000.00, mdl)
}



























