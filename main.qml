import QtQuick 2.10
import QtQuick.Controls 2.3
//import "/ExpenseRevenuePage.js" as ExpRev

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Tabs")
    onBeforeRendering: swipeView.currentIndex = tabBar.currentIndex //set in SwipeView after debug

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: 1 //start at tab 2 for debug

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

        BudgetPage {
        }

        InvestmentPage {
        }

        StatisticsPage{
        }

        StrategyPage{
        }
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
