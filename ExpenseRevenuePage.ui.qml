import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQml 2.2

Page {
    id: root

    width: 600
    height: 400
    property alias expRevListView: expRevListView

    property alias monthsGrid: monthsGrid
    property alias yearSel: yearSel
    property alias root: root
    property alias decBt: decBt
    property alias novBt: novBt
    property alias octBt: octBt
    property alias sepBt: sepBt
    property alias augBt: augBt
    property alias julBt: julBt
    property alias junBt: junBt
    property alias mayBt: mayBt
    property alias aprBt: aprBt
    property alias marBt: marBt
    property alias febBt: febBt
    property alias janBt: janBt
    property alias expRevHeader: expRevHeader
    property alias listOfExpRevs: listOfExpRevs
    spacing: -7

    signal monthButtonClickedSignal(string mth)

    header: Label {
        id: expRevHeader
        //width: parent.width - 250
        text: qsTr("Despesas e receitas")
        wrapMode: Text.WordWrap
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10

        Button {
            id: backBtn
            anchors.right: parent.right
            width: parent.width / 10
            height: parent.height
            text: qsTr("O")
            anchors.rightMargin: 5
            visible: false
            onClicked: root.state = ""
        }
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
            //onClicked: root.monthBtnClickedSignal("jan")
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
        id: yearSel
        x: 5
        y: 13
        to: 2100
        from: 1980
        //value: currentDate
    }

    ListView {
        id: expRevListView
        visible: false
        anchors.right: monthsGrid.right
        anchors.bottom: monthsGrid.bottom
        anchors.top: yearSel.top
        anchors.left: yearSel.left
        focus: true
        highlight: Rectangle {
            id: rectangle
            color: "grey"
        }
        highlightFollowsCurrentItem: true

        model: ListModel {
            id: listOfExpRevs
        }

        //delegate:
        ScrollBar.vertical: ScrollBar {
            id: expRevScrollBar
        }
    }

    states: [
        State {
            name: "MSEL"

            PropertyChanges {
                target: expRevListView
                visible: true
            }

            PropertyChanges {
                target: yearSel
                visible: false
            }

            PropertyChanges {
                target: monthsGrid
                visible: false
            }

            PropertyChanges {
                target: backBtn
                visible: true
            }
        }
    ]
}
