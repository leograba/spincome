import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.LocalStorage 2.0
import QtQml 2.2
import "/ExpenseRevenuePage.js" as ExpRev

ExpenseRevenuePage {
    property var db: new Object()
    signal finishEditingSomeText(string cType, int cIndex)

    Component.onCompleted: {
        ExpRev.setup(root)
        db = LocalStorage.openDatabaseSync(ExpRev.dbName, ExpRev.dbVer,
                                               ExpRev.dbDesc, ExpRev.dbEstSize,
                                               ExpRev.createConfigureDb)
    }

    janBt.onClicked: root.monthButtonClickedSignal("janBt")
    febBt.onClicked: root.monthButtonClickedSignal("febBt")
    marBt.onClicked: root.monthButtonClickedSignal("marBt")
    aprBt.onClicked: root.monthButtonClickedSignal("aprBt")
    mayBt.onClicked: root.monthButtonClickedSignal("mayBt")
    junBt.onClicked: root.monthButtonClickedSignal("junBt")
    julBt.onClicked: root.monthButtonClickedSignal("julBt")
    augBt.onClicked: root.monthButtonClickedSignal("augBt")
    sepBt.onClicked: root.monthButtonClickedSignal("sepBt")
    octBt.onClicked: root.monthButtonClickedSignal("octBt")
    novBt.onClicked: root.monthButtonClickedSignal("novBt")
    decBt.onClicked: root.monthButtonClickedSignal("decBt")

    onMonthButtonClickedSignal: ExpRev.monthSel(mth, root, db)

    onFinishEditingSomeText: console.log("Type is: " + cType + "; Index is: " + cIndex)

    expRevListView.delegate: Item {
        anchors.right: parent.right
        anchors.left: parent.left
        height: 35

        Row {
            id: row1
            spacing: 2
            anchors.right: parent.right
            anchors.left: parent.left

            TextField {
                id: howMuch
                width: parent.width / 5 - parent.spacing
                placeholderText: qsTr("valor")
                text: value
                onEditingFinished: root.finishEditingSomeText("value", index)
                Keys.onTabPressed: { ExpRev.highlightOnTab(index, 0, 0); event.accepted = false }
                Keys.onBacktabPressed: { ExpRev.highlightOnTab(index, 1, 1); event.accepted = false }
            }

            TextField {
                id: revOrExp
                width: parent.width / 5 - parent.spacing
                placeholderText: qsTr("D/R/I/E")
                text: exptype
                onEditingFinished: root.finishEditingSomeText("exptype", index)
                Keys.onTabPressed: { ExpRev.highlightOnTab(index, 0, 0); event.accepted = false }
                Keys.onBacktabPressed: { ExpRev.highlightOnTab(index, 0, 0); event.accepted = false }
            }

            TextField {
                id: catg
                width: parent.width / 5 - parent.spacing
                placeholderText: qsTr("categoria")
                text: category
                onEditingFinished: root.finishEditingSomeText("category", index)
                Keys.onTabPressed: { ExpRev.highlightOnTab(index, 0, 0); ; event.accepted = false }
                Keys.onBacktabPressed: { ExpRev.highlightOnTab(index, 0, 0); event.accepted = false }
            }

            TextField {
                id: descp
                width: parent.width / 5 - parent.spacing
                placeholderText: qsTr("descrição")
                text: description
                onEditingFinished: root.finishEditingSomeText("description", index)
                Keys.onTabPressed: { ExpRev.highlightOnTab(index, 0, 0); event.accepted = false }
                Keys.onBacktabPressed: { ExpRev.highlightOnTab(index, 0, 0); event.accepted = false }
            }

            TextField {
                id: date
                width: parent.width / 5 - parent.spacing
                placeholderText: qsTr("DD/MM/AA")
                text: datestring
                inputMask: "99/99/99"
                inputMethodHints: Qt.ImhDate //only a hint!
                onEditingFinished: root.finishEditingSomeText("datestring", index)
                Keys.onTabPressed: { ExpRev.highlightOnTab(index, 1, 0); event.accepted = false }
                Keys.onBacktabPressed: { ExpRev.highlightOnTab(index, 0, 0); event.accepted = false }
            }
        }

        MouseArea {
            anchors.fill: parent
            propagateComposedEvents: true
            onClicked: { mouse.accepted = false; ExpRev.highlightOnClick(index) }
            onPressed: { mouse.accepted = false; ExpRev.highlightOnClick(index) }
            onReleased: { mouse.accepted = false; ExpRev.highlightOnClick(index) }
            onDoubleClicked: mouse.accepted = false
            onPositionChanged: mouse.accepted = false
            onPressAndHold: mouse.accepted = false
        }

        //todo - this makes it go to the first entry. Should not accept and focus the right entry by index
        //or do nothing maybe for now? Well I will leave as it is
        Keys.onTabPressed: { ExpRev.highlightOnTab(index, 0, 0); event.accepted = false }
    }

    //entryMouseArea.onClicked: expRevListView.currentIndex = index

    //expRevListView.Keys.onUpPressed: expRevScrollBar.decrease()
    //expRevListView.Keys.onDownPressed: expRevScrollBar.increase()
    //expRevKeys.onUpPressed: console.log("Up pressed!")
}
