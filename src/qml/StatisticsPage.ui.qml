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
        x: 41
        y: 58
        color: "#2f39eb"
        text: qsTr("Ola natalia")
        font.pixelSize: 40
    }

    CheckBox {
        id: checkBox
        x: 31
        y: 105
        text: qsTr("Te amo")
        onClicked: {
            if (checkBox.checked) {
                dial.enabled = false
            } else {
                dial.enabled = true
            }
        }
        font.pointSize: 40
    }

    CheckBox {
        id: checkBox1
        x: 31
        y: 189
        text: qsTr("Te odeio")
        font.pointSize: 40
        font.capitalization: Font.AllLowercase
    }

    Dial {
        id: dial
        x: 343
        y: 53
        width: 376
        height: 363
        enabled: true
        font.weight: Font.ExtraLight
        spacing: 1
        stepSize: 5
        from: 0
        value: 50
        to: 100

        Text {
            id: dialtext
            x: 117
            y: 131
            width: 143
            height: 102
            color: "#2f39eb"
            text: Math.round(dial.value)
            font.bold: true
            font.family: "Times New Roman"
            textFormat: Text.PlainText
            font.pixelSize: 120
        }
    }
}
