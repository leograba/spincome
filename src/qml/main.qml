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

        Loader{
            id:expRevLoader
            source: "ExpenseRevenuePg.qml"
        }

        Loader{
            id:budgetLoader
            source: "BudgetPage.ui.qml"
        }

        Loader{
            id:investmentLoader
            source: "InvestmentPage.ui.qml"
        }

        Loader{
            id:statisticsLoader
            source: "StatisticsPage.ui.qml"
        }

        Loader{
            id:strategyLoader
            source: "StrategyPage.ui.qml"
        }

        Loader{
            id:configLoader
            source: "ConfigPg.qml"
        }
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            //: The dashboard tab
            text: qsTr("Dashboard")
        }
        TabButton {
            //: Tab to manage money incomes and spending
            text: qsTr("Revenues and Expenses")
        }
        TabButton {
            //: Expected revenues and expenses
            text: qsTr("Budget")
        }
        TabButton {
            //: Any invesments such as stock exchange, treasury, etc
            text: qsTr("Investments")
        }
        TabButton {
            //: Statistics about past revenues, expenses and investments, and others
            text: qsTr("Statistics")
        }
        TabButton {
            //: Investment strategy, it is similar to bugdet
            text: qsTr("Strategy")
        }
        TabButton {
            //: System settings, account settings, etc
            text: qsTr("Settings")
        }
    }
}
