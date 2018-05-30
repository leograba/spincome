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
    property int hdSize: 12
    property int addSize: 11
    property int iconMargin: 8
    property int iconOffset: 8
    property int listviewMargin: 5
    property string iconAddPath: "/images/button_refresh.png"

    header: Label {
        id: configHeader
        text: qsTr("Configurações")
        font.pixelSize: Qt.application.font.pixelSize * 2
        padding: 10

        Button {
            id: backBtn
            anchors.right: parent.right
            width: parent.width / 10
            height: parent.height
            anchors.rightMargin: 5
            visible: false
            onClicked: configRoot.state = "conf_sel"
            Image {
                anchors.rightMargin: 12
                anchors.leftMargin: 12
                anchors.bottomMargin: 12
                anchors.topMargin: 12
                anchors.fill: parent
                source: "/images/button_back.png"
                fillMode: Image.PreserveAspectFit
            }
        }
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

        Button {
            id: exprevTypesBtn
            text: qsTr("Categorias para despesa/receita")
            anchors.left: parent.left
            anchors.leftMargin: btnMargin
            anchors.top: parent.top
            anchors.topMargin: btnMargin
            width: btnWidth
            height: btnHeight
            onClicked: configRoot.state = "conf_exprev"
        }

        Button {
            id: userDataBtn
            text: qsTr("Dados de usuário")
            anchors.top: parent.top
            anchors.topMargin: btnMargin
            anchors.left: exprevTypesBtn.right
            anchors.leftMargin: btnMargin
            width: btnWidth
            height: btnHeight
            onClicked: configRoot.state = "conf_userdata"
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
            onClicked: configRoot.state = "conf_budget"
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
            onClicked: configRoot.state = "conf_accounts"
        }
    }

    Pane {
        id: exprevConf
        anchors.fill: parent
        visible: false

        /*Label {
            id: exprevConfHead
            text: qsTr("Categorias para despesa, receita, investimento e empréstimo")
            font.pointSize: 15
        }*/
        ListView {
            id: expListView
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: btnMargin
            anchors.top: parent.top
            anchors.topMargin: btnMargin
            width: parent.width / 4

            focus: true
            highlight: Rectangle {
                color: "grey"
            }
            highlightFollowsCurrentItem: true
            headerPositioning: ListView.PullBackHeader
            ScrollBar.vertical: ScrollBar {
            }

            header: Rectangle {
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                Label {
                    id: addExpLbl
                    width: parent.width
                    text: qsTr("Despesas")
                    font.bold: true
                    font.pointSize: hdSize
                }
                TextField {
                    id: addExpField
                    placeholderText: qsTr("Nova categoria")
                    width: parent.width - addExpBtn.width - iconOffset
                    font.pointSize: addSize
                    anchors.left: parent.left
                    anchors.top: addExpLbl.bottom
                }
                Button {
                    id: addExpBtn
                    width: height
                    height: addExpField.height - 5
                    anchors.left: addExpField.right
                    anchors.leftMargin: iconOffset
                    anchors.top: addExpLbl.bottom
                    Image {
                        anchors.rightMargin: iconMargin
                        anchors.leftMargin: iconMargin
                        anchors.bottomMargin: iconMargin
                        anchors.topMargin: iconMargin
                        anchors.fill: parent
                        source: iconAddPath
                        fillMode: Image.PreserveAspectFit
                    }
                }
            }

            model: ListModel {
                id: expModel
            }

            //delegate:
        }

        ListView {
            id: revListView
            anchors.left: expListView.right
            anchors.leftMargin: listviewMargin
            anchors.bottom: parent.bottom
            anchors.bottomMargin: btnMargin
            anchors.top: parent.top
            anchors.topMargin: btnMargin
            width: parent.width / 4

            focus: true
            highlight: Rectangle {
                color: "grey"
            }
            highlightFollowsCurrentItem: true
            headerPositioning: ListView.PullBackHeader
            ScrollBar.vertical: ScrollBar {
            }

            header: Rectangle {
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                Label {
                    id: addRevLbl
                    width: parent.width
                    text: qsTr("Receitas")
                    font.bold: true
                    font.pointSize: hdSize
                }
                TextField {
                    id: addRevField
                    placeholderText: qsTr("Nova categoria")
                    width: parent.width - addRevBtn.width - iconOffset
                    font.pointSize: addSize
                    anchors.left: parent.left
                    anchors.top: addRevLbl.bottom
                }
                Button {
                    id: addRevBtn
                    width: height
                    height: addRevField.height - 5
                    anchors.left: addRevField.right
                    anchors.top: addRevLbl.bottom
                    Image {
                        anchors.rightMargin: iconMargin
                        anchors.leftMargin: iconMargin
                        anchors.bottomMargin: iconMargin
                        anchors.topMargin: iconMargin
                        anchors.fill: parent
                        source: iconAddPath
                        fillMode: Image.PreserveAspectFit
                    }
                }
            }

            model: ListModel {
                id: revModel
            }
        }

        ListView {
            id: invListView
            anchors.left: revListView.right
            anchors.leftMargin: listviewMargin
            anchors.bottom: parent.bottom
            anchors.bottomMargin: btnMargin
            anchors.top: parent.top
            anchors.topMargin: btnMargin
            width: parent.width / 4

            focus: true
            highlight: Rectangle {
                color: "grey"
            }
            highlightFollowsCurrentItem: true
            headerPositioning: ListView.PullBackHeader
            ScrollBar.vertical: ScrollBar {
            }

            header: Rectangle {
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                Label {
                    id: addInvLbl
                    width: parent.width
                    text: qsTr("Investimentos")
                    font.bold: true
                    font.pointSize: hdSize
                }
                TextField {
                    id: addInvField
                    placeholderText: qsTr("Nova categoria")
                    width: parent.width - addInvBtn.width - iconOffset
                    font.pointSize: addSize
                    anchors.left: parent.left
                    anchors.top: addInvLbl.bottom
                }
                Button {
                    id: addInvBtn
                    width: height
                    height: addInvField.height - 5
                    anchors.left: addInvField.right
                    anchors.top: addInvLbl.bottom
                    Image {
                        anchors.rightMargin: iconMargin
                        anchors.leftMargin: iconMargin
                        anchors.bottomMargin: iconMargin
                        anchors.topMargin: iconMargin
                        anchors.fill: parent
                        source: iconAddPath
                        fillMode: Image.PreserveAspectFit
                    }
                }
            }

            model: ListModel {
                id: invModel
            }
        }

        ListView {
            id: loanListView
            anchors.left: invListView.right
            anchors.leftMargin: listviewMargin
            anchors.bottom: parent.bottom
            anchors.bottomMargin: btnMargin
            anchors.top: parent.top
            anchors.topMargin: btnMargin
            width: parent.width / 4

            focus: true
            highlight: Rectangle {
                color: "grey"
            }
            highlightFollowsCurrentItem: true
            headerPositioning: ListView.PullBackHeader
            ScrollBar.vertical: ScrollBar {
            }

            header: Rectangle {
                anchors.right: parent.right
                anchors.rightMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                Label {
                    id: addLoanLbl
                    width: parent.width
                    text: qsTr("Empréstimos")
                    font.bold: true
                    font.pointSize: hdSize
                }
                TextField {
                    id: addLoanField
                    placeholderText: qsTr("Nova categoria")
                    width: parent.width - addLoanBtn.width - iconOffset
                    font.pointSize: addSize
                    anchors.left: parent.left
                    anchors.top: addLoanLbl.bottom
                }
                Button {
                    id: addLoanBtn
                    width: height
                    height: addLoanField.height - 5
                    anchors.left: addLoanField.right
                    anchors.top: addLoanLbl.bottom
                    Image {
                        anchors.rightMargin: iconMargin
                        anchors.leftMargin: iconMargin
                        anchors.bottomMargin: iconMargin
                        anchors.topMargin: iconMargin
                        anchors.fill: parent
                        source: iconAddPath
                        fillMode: Image.PreserveAspectFit
                    }
                }
            }

            model: ListModel {
                id: loanModel
            }
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
        },
        State {
            name: "conf_exprev"
            PropertyChanges {
                target: gotoLogin
                visible: false
            }
            PropertyChanges {
                target: backBtn
                visible: true
            }
            PropertyChanges {
                target: exprevConf
                visible: true
            }
            PropertyChanges {
                target: configHeader
                text: qsTr("Categorias para despesa/receita")
            }
        },
        State {
            name: "conf_userdata"
            PropertyChanges {
                target: gotoLogin
                visible: false
            }
            PropertyChanges {
                target: backBtn
                visible: true
            }
            PropertyChanges {
                target: configHeader
                text: qsTr("Configurações de usuário")
            }
        },
        State {
            name: "conf_budget"
            PropertyChanges {
                target: gotoLogin
                visible: false
            }
            PropertyChanges {
                target: backBtn
                visible: true
            }
            PropertyChanges {
                target: configHeader
                text: qsTr("Categorias para orçamento")
            }
        },
        State {
            name: "conf_accounts"
            PropertyChanges {
                target: gotoLogin
                visible: false
            }
            PropertyChanges {
                target: backBtn
                visible: true
            }
            PropertyChanges {
                target: configHeader
                text: qsTr("Configurações de contas")
            }
        }
    ]
}
