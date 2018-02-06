import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.LocalStorage 2.0
import QtQml 2.2
import "/ExpenseRevenuePage.js" as ExpRev
import "/dbDataHandling.js" as DataBase

ExpenseRevenuePage {
    property var db: new Object()
    property string lastYearMonth
    signal finishEditingSomeText(string cType, int cIndex, string cVal)

    Component.onCompleted: {
        ExpRev.setup(expRevRoot)
        console.log("Username at expense revenue page: " + root.userName)
        db = LocalStorage.openDatabaseSync(ExpRev.dbName, ExpRev.dbVer,
                                               ExpRev.dbDesc, ExpRev.dbEstSize,
                                               ExpRev.createConfigureDb)
    }

    // selection buttons
    janBt.onClicked: expRevRoot.monthButtonClickedSignal("janBt")
    febBt.onClicked: expRevRoot.monthButtonClickedSignal("febBt")
    marBt.onClicked: expRevRoot.monthButtonClickedSignal("marBt")
    aprBt.onClicked: expRevRoot.monthButtonClickedSignal("aprBt")
    mayBt.onClicked: expRevRoot.monthButtonClickedSignal("mayBt")
    junBt.onClicked: expRevRoot.monthButtonClickedSignal("junBt")
    julBt.onClicked: expRevRoot.monthButtonClickedSignal("julBt")
    augBt.onClicked: expRevRoot.monthButtonClickedSignal("augBt")
    sepBt.onClicked: expRevRoot.monthButtonClickedSignal("sepBt")
    octBt.onClicked: expRevRoot.monthButtonClickedSignal("octBt")
    novBt.onClicked: expRevRoot.monthButtonClickedSignal("novBt")
    decBt.onClicked: expRevRoot.monthButtonClickedSignal("decBt")

    // signals
    onMonthButtonClickedSignal: ExpRev.monthSel(mth, expRevRoot, db)
    onFinishEditingSomeText: ExpRev.saveChanges(db, cType, cIndex, cVal, expRevRoot)

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
                width: 0.17 * parent.width - parent.spacing - 30 //30 is to make up to the revOrExpBtn
                placeholderText: qsTr("valor")
                text: value
                onEditingFinished: expRevRoot.finishEditingSomeText("value", index, text)
                Keys.onTabPressed: { ExpRev.highlightOnTab(index, 0, 0); event.accepted = false }
                Keys.onBacktabPressed: { ExpRev.highlightOnTab(index, 1, 1); event.accepted = false }
            }

            Button {
                // exprev ==> 0 - expense; 1 - revenue; 2 - investment; 3 - loan
                id: revOrExpBtn
                width: 30
                height: parent.height
                background: Rectangle{
                    color: "transparent"
                }
                Image{
                    id: revOrExpBtnImg
                    anchors.fill: parent
                    source: image
                }
                onClicked: {
                    ExpRev.revOrExpHandle(index, revOrExpBtnImg)
                    ExpRev.saveChanges(db, "exptype", index, exptype, expRevRoot)
                }
            }

            TextField {
                id: catg
                width: 0.18 * parent.width - parent.spacing
                placeholderText: qsTr("categoria")
                text: category
                onEditingFinished: expRevRoot.finishEditingSomeText("category", index, text)
                Keys.onTabPressed: { ExpRev.highlightOnTab(index, 0, 0); ; event.accepted = false }
                Keys.onBacktabPressed: { ExpRev.highlightOnTab(index, 0, 0); event.accepted = false }
            }

            TextField {
                id: descp
                width: 0.51 * parent.width - parent.spacing
                placeholderText: qsTr("descrição")
                text: description
                onEditingFinished: expRevRoot.finishEditingSomeText("description", index, text)
                Keys.onTabPressed: { ExpRev.highlightOnTab(index, 0, 0); event.accepted = false }
                Keys.onBacktabPressed: { ExpRev.highlightOnTab(index, 0, 0); event.accepted = false }
            }

            TextField {
                id: date
                width: 0.14 * parent.width - parent.spacing
                placeholderText: qsTr("00")
                text: datestring
                inputMask: "99" // inputMask messes with placeholderText
                //inputMethodHints: Qt.ImhDate //only a hint!
                onEditingFinished: expRevRoot.finishEditingSomeText("datestring", index, text)
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
}
