.import "/src/js/dbDataHandling.js" as DataBase

// Act as library
.pragma library

/* Constants */

/* Variables*/
var dashboardModelData;

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

    mdl.clear()
    // Get data from current month only
    //var cmonth = DataBase.genSqliteQuery(1, DataBase.getUsername(), add here year month string, "")

    /*DataBase.queryReadDb(queryStr, function(err, data){

    })*/

    // Get all available data
    //var amonth = DataBase.genSqliteQuery(0, DataBase.getUsername(), "", "")
    appendInfo(0, 0.4, 7000.00, mdl)
    appendInfo(4, 0.6, -10000.00, mdl)
}
