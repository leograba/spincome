import QtQuick 2.10
import QtQuick.Controls 2.3

Page {
    id: configRoot

    width: 600
    height: 400
    property alias configRoot: configRoot
    property alias gotoLogin: gotoLogin
    property int btnMargin: 10
    property double btnWidth: confSel.width / 2 - 2 * btnMargin
    property double btnHeight: confSel.height / 2 - 2 * btnMargin

    header: Label {
        text: qsTr("Configurações")
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10
    }

    Button {
        id: gotoLogin
        text: qsTr("Ir para login")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    Pane {
        id: confSel
        anchors.fill: parent
        visible: false

        //property double btnWidth: width / 2 - 2 * btnMargin
        //property double btnHeight: height / 2 - 2 * btnMargin
        Button {
            id: exprevTypesBtn
            text: qsTr("Categorias para despesa/receita")
            anchors.left: parent.left
            anchors.leftMargin: btnMargin
            anchors.top: parent.top
            anchors.topMargin: btnMargin
            width: btnWidth
            height: btnHeight
        }

        Button {
            id: userDataBtn
            text: qsTr("Dados da usuário")
            anchors.top: parent.top
            anchors.topMargin: btnMargin
            anchors.left: exprevTypesBtn.right
            anchors.leftMargin: btnMargin
            width: btnWidth
            height: btnHeight
        }

        Button {
            id: budgetTypesBtn
            text: qsTr("Categorias para orçamento")
            anchors.top: exprevTypesBtn.bottom
            anchors.topMargin: btnMargin
            anchors.left: parent.left
            anchors.leftMargin: btnMargin
            width: btnWidth
            height: btnHeight
        }

        Button {
            id: accountsBtn
            text: qsTr("Gerenciamento de contas")
            anchors.top: exprevTypesBtn.bottom
            anchors.topMargin: btnMargin
            anchors.left: budgetTypesBtn.right
            anchors.leftMargin: btnMargin
            width: btnWidth
            height: btnHeight
        }
    }

    states: [
        State {
            name: "conf_sel"

            PropertyChanges {
                target: gotoLogin
                visible: false
            }
            PropertyChanges {
                target: confSel
                visible: true
            }
        }
    ]
}
