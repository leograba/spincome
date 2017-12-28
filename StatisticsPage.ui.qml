import QtQuick 2.10
import QtQuick.Controls 2.3
import QtCharts 2.2

Page {
    width: 600
    height: 400
    contentWidth: 2

    header: Label {
        text: qsTr("Estatísticas")
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    Label {
        text: qsTr("Página de estatísticas")
        anchors.verticalCenterOffset: -131
        anchors.horizontalCenterOffset: -201
        anchors.centerIn: parent
    }

    Text {
        id: text1
        x: 47
        y: 86
        text: qsTr("Ola natalia")
        font.pixelSize: 12
    }

    CheckBox {
        id: checkBox
        x: 31
        y: 105
        text: qsTr("Te amo")
    }

    CheckBox {
        id: checkBox1
        x: 31
        y: 189
        text: qsTr("Te odeio")
    }

    Dial {
        id: dial
        x: 343
        y: 53
        font.weight: Font.ExtraLight
        spacing: 1
        stepSize: 5
        from: 0
        value: 50
        to: 100

        Text {
            id: dialtext
            x: 38
            y: 116
            text: Math.round(dial.value)
            textFormat: Text.PlainText
            font.pixelSize: 17
        }
    }
}
