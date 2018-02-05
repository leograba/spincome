import QtQuick 2.10
import QtQuick.Controls 2.3

Page {
    id: dashboard
    width: 600
    height: 400
    property alias dashboard: dashboard
    property alias username: username

    header: Label {
        text: qsTr("Dashboard")
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    TextField {
        id: username
        x: 76
        y: 6
        placeholderText: qsTr("nome")
        text: qsTr("leonardo")
    }

    TextField {
        id: textField
        x: 0
        y: 6
        width: 70
        height: 42
        text: qsTr("Usuário:")
        leftPadding: 4
        activeFocusOnPress: false
        activeFocusOnTab: false
    }

    GridView {
        id: gridView
        anchors.left: username.right
        anchors.leftMargin: 5
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
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
}
