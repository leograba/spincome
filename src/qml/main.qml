import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.LocalStorage 2.0

import "/src/js/main.js" as Main
import "/src/js/dbDataHandling.js" as DataBase

ApplicationWindow {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Tabs")
    onBeforeRendering: {
        Main.configureSwipe(swipeView);
        swipeView.currentIndex = tabBar.currentIndex //set in SwipeView after debug
    }

    Component.onCompleted: {
        // This is a way I found to pass the LocalStorage module to the JS dbDataHandling
        // Tried to .import QtQuick.LocalStorage 2.0 as LocalStorage but without success
        DataBase.createConfigureDb(LocalStorage) //Open DB - or create if does not exist yet
    }

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: 0 //start at tab 1 for debug

        Loader{
            id:dashboardLoader
            source: "DashboardPg.qml"
        }

/*
        DashboardPage {
        }
*/

        Loader{
            id:expRevLoader
            source: "ExpenseRevenuePg.qml"
        }


/*
        ExpenseRevenuePage {
        }
*/

        /*
        BudgetPage {
        }

        InvestmentPage {
        }

        StatisticsPage{
        }

        StrategyPage{
        }
        */
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: qsTr("Dashboard")
        }
        TabButton {
            text: qsTr("Despesas e receitas")
        }
        TabButton {
            text: qsTr("Orçamento")
        }
        TabButton {
            text: qsTr("Investimentos")
        }
        TabButton {
            text: qsTr("Estatísticas")
        }
        TabButton {
            text: qsTr("Estratégia")
        }
    }
}
