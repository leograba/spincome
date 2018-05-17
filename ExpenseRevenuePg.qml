import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.LocalStorage 2.0
import QtQml 2.2
import "/ExpenseRevenuePage.js" as ExpRev
import "/dbDataHandling.js" as DataBase
import "/main.js" as Main

ExpenseRevenuePage {
    property var db: new Object()
    property var consultation: new Object()
    property string lastYearMonth
    signal finishEditingSomeText(string cType, int cIndex, string cVal)

    Component.onCompleted: {
        Main.initialRootState("exprev", expRevRoot)
        Main.applyRootState("exprev", "nologin")
        ExpRev.setup(expRevRoot)
        console.debug("ExpenseRevenuePg.qml: onCompleted: Username at expense revenue page: " + root.userName)
        /*console.debug("ExpenseRevenuePg.qml: onCompleted: Consultation 1:\n\t" + DataBase.genSqliteQuery(0, DataBase.dbName, "", ""));
        console.debug("ExpenseRevenuePg.qml: onCompleted: Consultation 2:\n\t" + DataBase.genSqliteQuery(1, DataBase.dbName, "2018-05", ""));
        console.debug("ExpenseRevenuePg.qml: onCompleted: Consultation 3:\n\t" + DataBase.genSqliteQuery(2, DataBase.dbName, "", ""));
        console.debug("ExpenseRevenuePg.qml: onCompleted: Consultation 4:\n\t" + DataBase.genSqliteQuery(3, DataBase.dbName, "", "2"));
        console.debug("ExpenseRevenuePg.qml: onCompleted: Consultation 5:\n\t" + DataBase.genSqliteQuery(4, DataBase.dbName, "2018-05", "2"));
        console.debug("ExpenseRevenuePg.qml: onCompleted: Consultation 6:\n\t" + DataBase.genSqliteQuery(5, DataBase.dbName, "", ""));*/
        //DataBase.setUsername(root) // must be called whenever the JS is included
        console.debug("ExpenseRevenuePg.qml: onCompleted: Username after setup:" + DataBase.getUsername())
        //DataBase.createConfigureDb()
        db = LocalStorage.openDatabaseSync(ExpRev.dbName, ExpRev.dbVer,
                                               ExpRev.dbDesc, ExpRev.dbEstSize,
                                               ExpRev.createConfigureDb)
        /*DataBase.queryReadDb(db, DataBase.genSqliteQuery(1, DataBase.expRevTableName, "2018-05", ""), function(err, data){
            if(!err) {
                console.debug("ExpenseRevenuePg.qml: onCompleted:  Result of query2string: " + DataBase.query2string(data, function(err, strResult){
                    if(!err) {
                        var dataToSave = [] //[d.value, d.exptype, d.category, d.description, d.datestring]
                        dataToSave.push(strResult[0].value)
                        dataToSave.push(strResult[0].exptype)
                        dataToSave.push(strResult[0].category)
                        dataToSave.push(strResult[0].description)
                        dataToSave.push("2018-05-" + strResult[0].datestring)
                        DataBase.queryWriteAddToDb(db, DataBase.expRevTableName, dataToSave)
                        console.debug("ExpenseRevenuePg.qml: onCompleted: Last row = " + DataBase.lastAddedRow)
                        DataBase.queryUpdateDb(db, DataBase.expRevTableName, DataBase.lastAddedRow, "value", "666")
                    }
                }))
            }
        });*/
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
        console.log("ExpenseRevenuePg.qml: onMonthButtonClicked: " + mth + " clicked")
        console.debug("ExpenseRevenuePg.qml: onMonthButtonClicked: User name: " + DataBase.getUsername())
        ExpRev.monthSel(mth, expRevRoot, db)
    }
    onFinishEditingSomeText: ExpRev.saveChanges(db, cType, cIndex, cVal, expRevRoot)

    onStateChanged: {

        console.debug("ExpenseRevenuePg.qml: onStateChanged: State changed to " + Main.getRootState("exprev"))
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
