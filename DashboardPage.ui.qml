import QtQuick 2.10
import QtQuick.Controls 2.3

Page {
    id: dashboard
    width: 600
    height: 400
    property alias passwd: passwd
    property alias loginBtn: loginBtn
    property alias dashboard: dashboard
    property alias username: username

    header: Label {
        text: qsTr("Dashboard")
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    GridView {
        id: gridView
        width: parent.width * 0.7
        visible: false
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 5
        anchors.right: parent.right
        anchors.rightMargin: 5
        anchors.top: parent.top
        anchors.topMargin: 5
        cellWidth: width / 2
        cellHeight: height / 2
        delegate: Item {
            x: 5
            height: 50
            Column {
                spacing: 5
                width: gridView.cellWidth
                height: gridView.cellHeight / 2
                Rectangle {
                    width: (gridView.cellWidth - 5) * progress
                    height: gridView.cellHeight / 2
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
            ListElement {
                name: "4500.00"
                colorCode: "grey"
                progress: 0.5
            }

            ListElement {
                name: "256.02"
                colorCode: "red"
                progress: 1
            }

            ListElement {
                name: "-32.74"
                colorCode: "blue"
                progress: 0.2
            }

            ListElement {
                name: "0.00"
                colorCode: "green"
                progress: 0
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
        placeholderText: qsTr("nome")
        text: root.userName
        anchors.right: gridView.left
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
        anchors.right: gridView.left
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
        anchors.right: gridView.left
        anchors.rightMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 5
        anchors.top: passwdLabel.bottom
        anchors.topMargin: 0
    }
    states: [
        State {
            name: "login_success"
            PropertyChanges {
                target: gridView
                visible: true
            }
        },

        State {
            name: "login_fail"
        },

        State {
            name: "create_account"
        }
    ]
}
