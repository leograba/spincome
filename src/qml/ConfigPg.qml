import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.LocalStorage 2.0
import QtQml 2.2

import "/src/js/dbDataHandling.js" as DataBase
import "/src/js/main.js" as Main

ConfigPage{
    Component.onCompleted: {
        Main.initialRootState("config", configRoot)
        Main.applyRootState("config", "")
    }

    // Go to login page
    gotoLogin.onClicked: Main.goToLogin()
}
