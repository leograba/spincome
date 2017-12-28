import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQml 2.2

Page {
    property date currentDate: new Date()

    width: 600
    height: 400
    spacing: -7

    header: Label {
        text: qsTr("Despesas e receitas")
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    Grid {
        id: monthsGrid
        rows: 3
        columns: 4
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.bottomMargin: 5
        anchors.topMargin: 63
        anchors.fill: parent
        spacing: 8

        Button {
            id: janBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("Janeiro")
            checkable: false
            //onClicked: loadExpensesTab("jan", spinBox.value)
        }

        Button {
            id: febBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("Fevereiro")
            //onClicked: loadExpensesTab("feb", spinBox.value)
        }

        Button {
            id: marBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("Março")
            //onClicked: loadExpensesTab("mar", spinBox.value)
        }

        Button {
            id: aprBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("Abril")
            //onClicked: loadExpensesTab("apr", spinBox.value)
        }

        Button {
            id: mayBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("Maio")
            //onClicked: loadExpensesTab("may", spinBox.value)
        }

        Button {
            id: junBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("Junho")
            //onClicked: loadExpensesTab("jun", spinBox.value)
        }

        Button {
            id: julBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("Julho")
            //onClicked: loadExpensesTab("jul", spinBox.value)
        }

        Button {
            id: augBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("Agosto")
            //onClicked: loadExpensesTab("aug", spinBox.value)
        }

        Button {
            id: sepBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("Setembro")
            //onClicked: loadExpensesTab("sep", spinBox.value)
        }

        Button {
            id: octBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("Outubro")
            //onClicked: loadExpensesTab("oct", spinBox.value)
        }

        Button {
            id: novBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("Novembro")
            //onClicked: loadExpensesTab("nov", spinBox.value)
        }

        Button {
            id: decBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("Dezembro")
            //onClicked: loadExpensesTab("dez", spinBox.value)
        }
    }

    SpinBox {
        id: spinBox
        x: 54
        y: 13
        to: 2100
        from: 1980
        value: 2017
    }
}
