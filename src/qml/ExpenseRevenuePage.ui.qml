import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQml 2.2

Page {
    id: expRevRoot

    width: 600
    height: 400
    property alias gotoLogin: gotoLogin
    property alias expRevRoot: expRevRoot
    property alias expRevListView: expRevListView

    property alias monthsGrid: monthsGrid
    property alias yearSel: yearSel
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
        text: qsTr("Expenses and revenues")
        wrapMode: Text.WordWrap
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10

        Button {
            id: backBtn
            anchors.right: parent.right
            width: parent.width / 10
            height: parent.height
            anchors.rightMargin: 5
            visible: false
            onClicked: expRevRoot.state = ""
            Image {
                anchors.rightMargin: 12
                anchors.leftMargin: 12
                anchors.bottomMargin: 12
                anchors.topMargin: 12
                anchors.fill: parent
                source: "/images/button_back.png"
                fillMode: Image.PreserveAspectFit
            }
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
            text: qsTr("January")
            //onClicked: expRevRoot.monthBtnClickedSignal("jan")
        }

        Button {
            id: febBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("February")
        }

        Button {
            id: marBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("March")
        }

        Button {
            id: aprBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("April")
        }

        Button {
            id: mayBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("May")
        }

        Button {
            id: junBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("June")
        }

        Button {
            id: julBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("July")
        }

        Button {
            id: augBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("August")
        }

        Button {
            id: sepBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("September")
        }

        Button {
            id: octBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("October")
        }

        Button {
            id: novBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("November")
        }

        Button {
            id: decBt
            width: (parent.width / 4 - parent.spacing)
            height: (parent.height / 3 - parent.spacing)
            text: qsTr("December")
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

        headerPositioning: ListView.PullBackHeader
        header: Row {
            id: rowHd
            spacing: 2
            anchors.right: parent.right
            anchors.left: parent.left
            z: 2

            TextField {
                id: howMuchHd
                width: 0.17 * parent.width - parent.spacing
                       - 33 //30 is to make up to the revOrExpBtn
                //: Value as in "how much"
                text: qsTr("Value")
                activeFocusOnPress: false
                activeFocusOnTab: false
            }

            TextField {
                id: revOrExpBtnHd
                width: 33
                //: Either expense, revenue, loan or investment
                text: qsTr("Type")
                activeFocusOnPress: false
                activeFocusOnTab: false
            }

            TextField {
                id: catgHd
                width: 0.18 * parent.width - parent.spacing
                //: The type of expense, revenue, etc such as "medical" or "salary"
                text: qsTr("Category")
                activeFocusOnPress: false
                activeFocusOnTab: false
            }

            TextField {
                id: descpHd
                width: 0.51 * parent.width - parent.spacing
                text: qsTr("Description")
                activeFocusOnPress: false
                activeFocusOnTab: false
            }

            TextField {
                id: dateHd
                width: 0.14 * parent.width - parent.spacing
                //: Not exactly "date" since month and year are predetermined
                text: qsTr("Day")
                activeFocusOnPress: false
                activeFocusOnTab: false
            }
        }
        model: ListModel {
            id: listOfExpRevs
        }

        //delegate:
        ScrollBar.vertical: ScrollBar {
            id: expRevScrollBar
        }
    }

    Button {
        id: gotoLogin
        text: qsTr("Go to login")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        visible: false
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

            PropertyChanges {
                target: gotoLogin
                visible: false
            }
        },
        State {
            name: "nologin"
            PropertyChanges {
                target: expRevListView
                visible: false
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
                target: gotoLogin
                opacity: 1
                visible: true
            }
        }
    ]
}
