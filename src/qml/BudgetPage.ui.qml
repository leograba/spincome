import QtQuick 2.10
import QtQuick.Controls 2.3

Page {
    width: 600
    height: 400

    header: Label {
        text: qsTr("Orçamento")
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    Label {
        text: qsTr("Este será o orçamento")
        anchors.centerIn: parent
    }
}
