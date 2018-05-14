import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.LocalStorage 2.0
import QtQml 2.2
import "/dbDataHandling.js" as DataBase
import "/main.js" as Main

DashboardPage {
    Component.onCompleted: {
        DataBase.setDbFromUsername(root)// must be called whenever the JS is included
        Main.initialRootState("dashboard", dashboard)
    }

    loginBtn.onClicked: {
        if(passwd.text === "123456" && username.text === "leonardinho"){
            dashboard.state = "login_success"
            root.userName = username.text
            DataBase.setDbFromUsername(root)
            Main.applyRootState("exprev", "")
            //root.expRevLoader.state = ""
        }
        else{
            console.debug("DashboardPg.qml: loginBtn: login failed: " + username.text + " " + passwd.text)
            dashboard.state = "login_fail"
            Main.applyRootState("exprev", "nologin")
            //root.expRevLoader.state = "nologin"
        }
    }
}
