import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.LocalStorage 2.0
import QtQml 2.2
import "/ExpenseRevenuePage.js" as ExpRev

ExpenseRevenuePage {
    property var db: new Object()
    property string lastYearMonth
    signal finishEditingSomeText(string cType, int cIndex, string cVal)

    Component.onCompleted: {
        ExpRev.setup(root)
        db = LocalStorage.openDatabaseSync(ExpRev.dbName, ExpRev.dbVer,
                                               ExpRev.dbDesc, ExpRev.dbEstSize,
                                               ExpRev.createConfigureDb)
    }

    // selection buttons
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

    // signals
    onMonthButtonClickedSignal: ExpRev.monthSel(mth, root, db)
    onFinishEditingSomeText: ExpRev.saveChanges(db, cType, cIndex, cVal)

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
                onEditingFinished: root.finishEditingSomeText("value", index, text)
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
                onClicked: ExpRev.revOrExpHandle(index, revOrExpBtnImg)
            }

            TextField {
                id: catg
                width: 0.18 * parent.width - parent.spacing
                placeholderText: qsTr("categoria")
                text: category
                onEditingFinished: root.finishEditingSomeText("category", index, text)
                Keys.onTabPressed: { ExpRev.highlightOnTab(index, 0, 0); ; event.accepted = false }
                Keys.onBacktabPressed: { ExpRev.highlightOnTab(index, 0, 0); event.accepted = false }
            }

            TextField {
                id: descp
                width: 0.51 * parent.width - parent.spacing
                placeholderText: qsTr("descrição")
                text: description
                onEditingFinished: root.finishEditingSomeText("description", index, text)
                Keys.onTabPressed: { ExpRev.highlightOnTab(index, 0, 0); event.accepted = false }
                Keys.onBacktabPressed: { ExpRev.highlightOnTab(index, 0, 0); event.accepted = false }
            }

            TextField {
                id: date
                width: 0.14 * parent.width - parent.spacing
                //placeholderText: qsTr("DD/MM/AA")
                text: datestring
                inputMask: "99/99/99"
                inputMethodHints: Qt.ImhDate //only a hint!
                onEditingFinished: root.finishEditingSomeText("datestring", index, text)
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
