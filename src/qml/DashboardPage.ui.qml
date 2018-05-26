import QtQuick 2.10
import QtQuick.Controls 2.3

Page {
    id: dashboard
    width: 600
    height: 400
    property alias pwdConfirm: pwdConfirm
    property alias pwd: pwd
    property alias email: email
    property alias login: login
    property alias lastName: lastName
    property alias firstName: firstName
    property alias createSubmit: createSubmit
    property alias createBtn: createBtn
    property alias passwd: passwd
    property alias loginBtn: loginBtn
    property alias dashboard: dashboard
    property alias username: username
    property alias dashboardData: dashboardData

    property int txtsize: 12
    property double createRatio: 0.35

    header: Label {
        text: qsTr("Dashboard")
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    Pane {
        id: yearSelDashboard
        visible: false
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 11
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
        width: parent.width * 0.7

        GridView {
            id: gridView
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 11
            //anchors.right: parent.right
            //anchors.rightMargin: 5
            anchors.top: parent.top
            anchors.topMargin: 5
            cellWidth: width / 2
            cellHeight: height / 3

            delegate: Item {
                x: 5
                height: 50
                Column {
                    spacing: 5
                    width: gridView.cellWidth
                    height: gridView.cellHeight / 3
                    Rectangle {
                        width: (gridView.cellWidth - 5) * progress
                        height: gridView.cellHeight / 3
                        color: colorCode
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    Text {
                        text: name
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
            model: ListModel {
                id: dashboardData
            }
        }
    }

    TextField {
        id: userLabel
        height: 42
        width: 70
        text: qsTr("Usuário:")
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 5
        activeFocusOnPress: false
        activeFocusOnTab: false
    }

    TextField {
        id: username
        text: ""
        placeholderText: qsTr("nome")
        anchors.right: yearSelDashboard.left
        anchors.rightMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.left: userLabel.right
        anchors.leftMargin: 0
    }

    TextField {
        id: passwdLabel
        height: 42
        width: 70
        text: qsTr("Senha:")
        anchors.top: userLabel.bottom
        anchors.topMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 5
        activeFocusOnPress: false
        activeFocusOnTab: false
    }

    TextField {
        id: passwd
        text: qsTr("")
        anchors.right: yearSelDashboard.left
        anchors.rightMargin: 0
        anchors.top: username.bottom
        anchors.topMargin: 0
        placeholderText: "passwd"
        anchors.left: passwdLabel.right
        anchors.leftMargin: 0
        echoMode: TextInput.Password
    }

    Button {
        id: loginBtn
        text: qsTr("Login")
        spacing: 5
        anchors.right: yearSelDashboard.left
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: passwdLabel.bottom
        anchors.topMargin: 0
    }

    Button {
        id: createBtn
        text: qsTr("Criar conta")
        spacing: 5
        anchors.right: yearSelDashboard.left
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: loginBtn.bottom
        anchors.topMargin: 0
    }

    Pane {
        id: createPane
        width: parent.width * 0.7
        focusPolicy: Qt.ClickFocus
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 0
        visible: false

        Label {
            id: createheader
            text: qsTr("Crie sua conta")
            anchors.horizontalCenter: parent.horizontalCenter
            font.bold: true
            font.pointSize: 15
            anchors.top: parent.top
            anchors.topMargin: 0
        }

        Label {
            id: firstNameLabel
            text: qsTr("Primeiro Nome")
            width: parent.width * createRatio
            font.pointSize: txtsize
            anchors.top: createheader.bottom
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 5
        }

        TextField {
            id: firstName
            placeholderText: qsTr("e.g. Arlindo")
            width: parent.width * (1 - createRatio)
            anchors.top: createheader.bottom
            anchors.topMargin: 2
            anchors.right: parent.right
            anchors.rightMargin: 5
        }

        Label {
            id: lastNameLabel
            text: qsTr("Último Nome")
            width: parent.width * createRatio
            font.pointSize: txtsize
            anchors.top: firstNameLabel.bottom
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 5
        }

        TextField {
            id: lastName
            placeholderText: qsTr("e.g. Pinto")
            width: parent.width * (1 - createRatio)
            anchors.top: firstNameLabel.bottom
            anchors.topMargin: 2
            anchors.right: parent.right
            anchors.rightMargin: 5
        }

        Label {
            id: loginLabel
            text: qsTr("Usuário / Login")
            width: parent.width * createRatio
            font.pointSize: txtsize
            anchors.top: lastNameLabel.bottom
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 5
        }

        TextField {
            id: login
            placeholderText: qsTr("Nome de usuário")
            width: parent.width * (1 - createRatio)
            anchors.top: lastNameLabel.bottom
            anchors.topMargin: 2
            anchors.right: parent.right
            anchors.rightMargin: 5
        }

        Label {
            id: emailLabel
            text: qsTr("E-mail")
            width: parent.width * createRatio
            font.pointSize: txtsize
            anchors.top: loginLabel.bottom
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 5
        }

        TextField {
            id: email
            placeholderText: qsTr("e.g. arlindo.pinto@mymail.com")
            width: parent.width * (1 - createRatio)
            anchors.top: loginLabel.bottom
            anchors.topMargin: 2
            anchors.right: parent.right
            anchors.rightMargin: 5
        }

        Label {
            id: pwdCreateLabel
            text: qsTr("Senha")
            width: parent.width * createRatio
            font.pointSize: txtsize
            anchors.top: emailLabel.bottom
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 5
        }

        TextField {
            id: pwd
            placeholderText: qsTr("Crie uma senha")
            width: parent.width * (1 - createRatio)
            anchors.top: emailLabel.bottom
            anchors.topMargin: 2
            anchors.right: parent.right
            anchors.rightMargin: 5
        }

        Label {
            id: pwdConfirmLabel
            text: qsTr("Confirmar Senha")
            width: parent.width * createRatio
            font.pointSize: txtsize
            anchors.top: pwdCreateLabel.bottom
            anchors.topMargin: 10
            anchors.left: parent.left
            anchors.leftMargin: 5
        }

        TextField {
            id: pwdConfirm
            placeholderText: qsTr("Digite novamente a senha")
            width: parent.width * (1 - createRatio)
            anchors.top: pwdCreateLabel.bottom
            anchors.topMargin: 2
            anchors.right: parent.right
            anchors.rightMargin: 5
        }

        Button {
            id: createSubmit
            text: qsTr("Criar nova conta")
            spacing: 5
            anchors.right: parent.right
            anchors.rightMargin: 5
            anchors.left: parent.left
            anchors.leftMargin: 5
            anchors.top: pwdConfirmLabel.bottom
            anchors.topMargin: 15
        }
    }

    Pane {
        id: accCreatedPane
        width: parent.width * 0.7
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 0
        visible: false

        Label {
            id: successMsgHeader
            text: qsTr("Conta criada")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            font.bold: true
            font.pointSize: 15
            anchors.topMargin: 0
        }

        Label {
            id: successMsgText
            width: parent.width
            text: qsTr("Realize o login para continuar")
            anchors.left: parent.left
            anchors.top: successMsgHeader.bottom
            anchors.leftMargin: 5
            font.pointSize: txtsize
            anchors.topMargin: 10
        }
    }

    Label {
        id: loginFailText
        visible: false
        text: qsTr("Usuário e/ou senha incorretos!")
        anchors.left: loginBtn.right
        anchors.leftMargin: 10
        font.pointSize: txtsize
        anchors.top: parent.top
        anchors.topMargin: 15
    }

    states: [
        State {
            name: "login_success"
            PropertyChanges {
                target: yearSelDashboard
                visible: true
            }
            PropertyChanges {
                target: loginBtn
                text: qsTr("Logout")
            }
            PropertyChanges {
                target: createBtn
                visible: false
            }
        },

        State {
            name: "login_fail"
            PropertyChanges {
                target: loginFailText
                visible: true
            }
        },

        State {
            name: "create_account"
            PropertyChanges {
                target: createPane
                visible: true
            }
        },
        State {
            name: "account_created"
            PropertyChanges {
                target: accCreatedPane
                visible: true
            }
        }
    ]
}
