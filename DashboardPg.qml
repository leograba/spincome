import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.LocalStorage 2.0
import QtQml 2.2
import "/dbDataHandling.js" as DataBase

DashboardPage {
    Component.onCompleted: {
        DataBase.setDbFromUsername(root)// must be called whenever the JS is included
    }

    loginBtn.onClicked: {
        dashboard.state = "login_success"
        console.log("Username is: " + username.text + " and root username is: " + root.userName)
        root.userName = username.text
        DataBase.setDbFromUsername(root)
    }
}
