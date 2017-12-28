import QtQuick 2.10
import QtQuick.Controls 2.3

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Tabs")

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        DashboardPage {
        }

        ExpenseRevenuePage {
            visible: true
            ExpenseRevenueTab{
                visible: false
            }
        }

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
