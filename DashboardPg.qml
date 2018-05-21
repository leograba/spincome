import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.LocalStorage 2.0
import QtQml 2.2
import "/dbDataHandling.js" as DataBase
import "/main.js" as Main

DashboardPage {
    Component.onCompleted: {
        Main.initialRootState("dashboard", dashboard)
    }

    loginBtn.onClicked: {
        // ToDo - Should strip special chars from username
        var queryStr = "SELECT username, password FROM users WHERE username LIKE '" + username.text + "'"
        DataBase.queryReadDb(queryStr, function(err, data){
            //console.debug("DashboardPg.qml: loginBtn.onClicked: data is:")
            //console.debug("\t" + JSON.stringify(data.rows.length))
            //console.debug("\t" + JSON.stringify(data.rows.item(0)))
            if(!err && (data.rows.length === 1)){ //username unique not null --> index always 0
                if(Qt.md5(passwd.text) === data.rows.item(0).password){
                    DataBase.setUsername(data.rows.item(0).username)
                    Main.stateLoginSuccess()
                    console.debug("DashboardPg.qml: loginBtn.onClicked: Login successful for user: " + data.rows.item(0).username)
                }
                else{
                    Main.stateLoginFail()
                    console.debug("DashboardPg.qml: loginBtn.onClicked: Login failed (bad password) for user: " + data.rows.item(0).username)
                }
            }
            else{
                Main.stateLoginFail()
                console.debug("DashboardPg.qml: loginBtn.onClicked: Login failed (username not found)")
            }
        })
    }

    createBtn.onClicked: {
        //dashboard.state = "create_account"
        Main.applyRootState("dashboard", "create_account")
    }

    createSubmit.onClicked: {
        var dataToSave = [] // [username, firstname, lastname, email, password]
        var validationOk = 0 // zero means success

        // ToDo - validate data before adding to DB
        if(login.text) dataToSave.push(login.text)
        else{
            login.placeholderText = "Preenchimento obrigatório"
            validationOk = 1
        }

        dataToSave.push(firstName.text)
        dataToSave.push(lastName.text)

        if(email.text) dataToSave.push(email.text)
        else{
            email.placeholderText = "Preenchimento obrigatório"
            validationOk = 1
        }

        if(Qt.md5(pwd.text) === Qt.md5(pwdConfirm.text)) dataToSave.push(Qt.md5(pwd.text))
        else{
            pwdConfirm.text = ""; pwdConfirm.placeholderText = "Senha não confere, digite novamente"
            validationOk = 1
        }
        //console.debug("DashboardPg.qml: createSubmit.onClicked: data to be saved is: " + JSON.stringify(dataToSave))

        if(!validationOk) {
            DataBase.queryWriteAddToDb("users", dataToSave, function(err){
                //console.debug("DashboardPg.qml: createSubmit.onClicked: error creating user: " + err)
                if(err !== false){ // Check if insertion ok --> error if user already exist
                    login.text = ""; login.placeholderText = "Usuário já cadastrado"
                }
                else{
                    DataBase.createUserTable(login.text, function(err){
                        if(err !== false){
                            login.text = ""; login.placeholderText = "Usuário já cadastrado"
                        }
                        else{
                            Main.applyRootState("dashboard", "account_created")
                        }
                    })
                }
            })
        }
    }
}
