import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.LocalStorage 2.0
import QtQml 2.2
import "/src/js/ExpenseRevenuePage.js" as ExpRev
import "/src/js/dbDataHandling.js" as DataBase
import "/src/js/main.js" as Main

ExpenseRevenuePage {
    property var db: new Object()
    property var consultation: new Object()
    signal finishEditingSomeText(string cType, int cIndex, string cVal)

    Component.onCompleted: {
        Main.initialRootState("exprev", expRevRoot)
        Main.applyRootState("exprev", "nologin")
        ExpRev.yearMonthSetup(expRevRoot)
    }

    // Go to login page
    gotoLogin.onClicked: Main.goToLogin()

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
    onMonthButtonClickedSignal: {
        console.log("ExpenseRevenuePg.qml: onMonthButtonClicked: " + mth + " clicked; user name is: " + DataBase.getUsername())
        ExpRev.monthSel(mth, expRevRoot, db)
    }
    onFinishEditingSomeText: ExpRev.saveChanges(cType, cIndex, cVal, expRevRoot)

    onStateChanged: {
        console.debug("ExpenseRevenuePg.qml: onStateChanged: State changed to " + Main.getRootState("exprev"))
        if(Main.getRootState("exprev") === ""){
            listOfExpRevs.clear() // clear data
        }
    }

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
                placeholderText: qsTr("value")
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
                    ExpRev.saveChanges("exptype", index, exptype)
                }
            }

            TextField {
                id: catg
                width: 0.18 * parent.width - parent.spacing
                placeholderText: qsTr("category")
                text: category
                onEditingFinished: expRevRoot.finishEditingSomeText("category", index, text)
                Keys.onTabPressed: { ExpRev.highlightOnTab(index, 0, 0); ; event.accepted = false }
                Keys.onBacktabPressed: { ExpRev.highlightOnTab(index, 0, 0); event.accepted = false }
            }

            TextField {
                id: descp
                width: 0.51 * parent.width - parent.spacing
                placeholderText: qsTr("description")
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
