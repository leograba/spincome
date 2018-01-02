import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.LocalStorage 2.0
import QtQml 2.2
import "/ExpenseRevenuePage.js" as ExpRev

ExpenseRevenuePage {
    property var db: new Object()
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

    //expRevListView.Keys.onUpPressed: expRevScrollBar.decrease()
    //expRevListView.Keys.onDownPressed: expRevScrollBar.increase()
    //expRevKeys.onUpPressed: console.log("Up pressed!")
}
