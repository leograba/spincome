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

    mdl.append({  name: qsTr("Receita"),
                   colorCode: "green",
                   progress: 0.5,
                   vlue: "5000.00"
    })

    mdl.append({  name: "Despesa",
                   colorCode: "red",
                   progress: 0.3,
                   vlue: "3000.00"
    })

    mdl.append({  name: "Investimento",
                   colorCode: "blue",
                   progress: 0.7,
                   vlue: "7000.00"
    })

    mdl.append({  name: "Empréstimo",
                   colorCode: "orange",
                   progress: 1.0,
                   vlue: "10000.00"
    })

    mdl.append({  name: "Saldo Total",
                   colorCode: "green",
                   progress: 0.5,
                   vlue: "-1000.00"
    })

    mdl.append({  name: "Investimento Total",
                   colorCode: "blue",
                   progress: 0.5,
                   vlue: "7000.00"
    })

    mdl.append({  name: "Retorno de Investimento",
                   colorCode: "green",
                   progress: 0.8,
                   vlue: "32.1%"
    })

    mdl.append({  name: "Despesa/Orçamento",
                   colorCode: "green",
                   progress: 0.64,
                   vlue: "3000.00/4700.00"
    })
}
