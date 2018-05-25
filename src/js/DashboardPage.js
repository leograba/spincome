.import "/src/js/dbDataHandling.js" as DataBase

/* Constants */

/* Variables*/

function refreshInfo(model, month){
    /* Get data from the current user DB and displays
        the consolidated information on the dashboard*/

    console.debug("DashboardPage.js: refreshInfo: Refreshing dashboard information")

    // Get data from current month only
    var cmonth = DataBase.genSqliteQuery(1, DataBase.getUsername(), add here year month string, "")

    DataBase.queryReadDb(queryStr, function(err, data){

    }

    // Get all available data
    var amonth = DataBase.genSqliteQuery(0, DataBase.getUsername(), "", "")

    model.append({  name: "4500.00",
                            colorCode: "yellow",
                            progress: 0.5
    })
}
