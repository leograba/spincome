import QtQuick 2.10
import QtQuick.Controls 2.3

Page {
    width: 600
    height: 400

    header: Label {
        text: qsTr("Budget")
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    Label {
        //: Work-in-progress notice
        text: qsTr("Work in place - This will be the budget")
        anchors.centerIn: parent
    }
}
