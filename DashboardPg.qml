import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.LocalStorage 2.0
import QtQml 2.2
import "/dbDataHandling.js" as DataBase

DashboardPage {
    Component.onCompleted: {
        console.log("Some text here: " + root.userName)
        DataBase.setDbFromUsername(dashboard)
    }

    loginBtn.onClicked: {
        dashboard.state = "login_success"
    }
}
