import QtQuick 2.10
import QtQuick.Controls 2.3

Page {
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
        }

        Button {
            id: febBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("Fevereiro")
        }

        Button {
            id: marBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("Março")
        }

        Button {
            id: aprBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("Abril")
        }

        Button {
            id: mayBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("Maio")
        }

        Button {
            id: junBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("Junho")
        }

        Button {
            id: julBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("Julho")
        }

        Button {
            id: augBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("Agosto")
        }

        Button {
            id: sepBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("Setembro")
        }

        Button {
            id: octBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("Outubro")
        }

        Button {
            id: novBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("Novembro")
        }

        Button {
            id: decBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("Dezembro")
        }
    }

    SpinBox {
        id: spinBox
        x: 47
        y: 14
        wheelEnabled: false
        to: 2100
        from: 1980
        value: 2017
    }

    Text {
        id: text1
        x: 5
        y: 25
        width: 43
        height: 27
        color: "#ffffff"
        text: qsTr("Ano:")
        font.family: "Verdana"
        font.pointSize: 14
    }
}
