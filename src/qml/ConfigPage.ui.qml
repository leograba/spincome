import QtQuick 2.10
import QtQuick.Controls 2.3

Page {
    id: configRoot

    width: 600
    height: 400
    property alias addLoanBtn: addLoanBtn
    property alias addLoanField: addLoanField
    property alias addInvBtn: addInvBtn
    property alias addInvField: addInvField
    property alias addRevBtn: addRevBtn
    property alias addRevField: addRevField
    property alias addExpBtn: addExpBtn
    property alias addExpField: addExpField
    property alias configRoot: configRoot
    property alias gotoLogin: gotoLogin
    property alias expModel: expModel
    property alias expListView: expListView
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
        text: qsTr("Settings")
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
        //: Go to the login tab
        text: qsTr("Go to login")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }

    Pane {
        id: confSel
        anchors.fill: parent
        visible: false

        Button {
            id: exprevTypesBtn
            text: qsTr("Categories for expenses / revenues")
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
            text: qsTr("User data")
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
            text: qsTr("Categories for budget")
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
            //: Like "bank account" not "user account"
            text: qsTr("Account management")
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

        Rectangle {
            id: addLabels
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            height: addExpField.height
            color: "#00000000"

            Label {
                id: addExpLbl
                width: parent.width / 4
                anchors.left: parent.left
                text: qsTr("Expenses")
                font.bold: true
                font.pointSize: hdSize
            }

            TextField {
                id: addExpField
                //: New class, such as "medical" or "market"
                placeholderText: qsTr("New category")
                width: parent.width / 4 - addExpBtn.width - iconOffset * 1.2
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

            Label {
                id: addRevLbl
                width: parent.width / 4
                anchors.left: addExpBtn.right
                anchors.leftMargin: listviewMargin
                text: qsTr("Revenues")
                font.bold: true
                font.pointSize: hdSize
            }

            TextField {
                id: addRevField
                //: New class, such as "salary" or "stock exchange"
                placeholderText: qsTr("New category")
                width: parent.width / 4 - addRevBtn.width - iconOffset * 1.2
                font.pointSize: addSize
                anchors.left: addExpBtn.right
                anchors.leftMargin: listviewMargin
                anchors.top: addRevLbl.bottom
            }
            Button {
                id: addRevBtn
                width: height
                height: addRevField.height - 5
                anchors.left: addRevField.right
                anchors.leftMargin: iconOffset
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

            Label {
                id: addInvLbl
                width: parent.width / 4
                anchors.left: addRevBtn.right
                anchors.leftMargin: listviewMargin
                text: qsTr("Investments")
                font.bold: true
                font.pointSize: hdSize
            }

            TextField {
                id: addInvField
                //: New class, such as "treasury" or "properties"
                placeholderText: qsTr("New category")
                width: parent.width / 4 - addInvBtn.width - iconOffset * 1.2
                font.pointSize: addSize
                anchors.left: addRevBtn.right
                anchors.leftMargin: listviewMargin
                anchors.top: addInvLbl.bottom
            }
            Button {
                id: addInvBtn
                width: height
                height: addInvField.height - 5
                anchors.left: addInvField.right
                anchors.leftMargin: iconOffset
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

            Label {
                id: addLoanLbl
                width: parent.width / 4
                anchors.left: addInvBtn.right
                anchors.leftMargin: listviewMargin
                text: qsTr("Loans")
                font.bold: true
                font.pointSize: hdSize
            }

            TextField {
                id: addLoanField
                //: New class, such as "family" or "friends"
                placeholderText: qsTr("New category")
                width: parent.width / 4 - addLoanBtn.width - iconOffset * 1.2
                font.pointSize: addSize
                anchors.left: addInvBtn.right
                anchors.leftMargin: listviewMargin
                anchors.top: addLoanLbl.bottom
            }
            Button {
                id: addLoanBtn
                width: height
                height: addLoanField.height - 5
                anchors.left: addLoanField.right
                anchors.leftMargin: iconOffset
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

        ListView {
            id: expListView
            anchors.left: parent.left
            anchors.leftMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: btnMargin
            anchors.top: addLabels.bottom
            anchors.topMargin: btnMargin
            width: parent.width / 4

            focus: true

            model: ListModel {
                id: expModel
            }
        }

        ListView {
            id: revListView
            anchors.left: expListView.right
            anchors.leftMargin: listviewMargin
            anchors.bottom: parent.bottom
            anchors.bottomMargin: btnMargin
            anchors.top: addLabels.bottom
            anchors.topMargin: btnMargin
            width: parent.width / 4

            focus: true

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
            anchors.top: addLabels.bottom
            anchors.topMargin: btnMargin
            width: parent.width / 4

            focus: true

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
            anchors.top: addLabels.bottom
            anchors.topMargin: btnMargin
            width: parent.width / 4

            focus: true

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
                text: qsTr("Categories for expense / revenue")
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
                //: Things like preferences, colors, language, etc
                text: qsTr("User configuration")
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
                text: qsTr("Categories for budget")
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
                text: qsTr("Account configuration")
            }
        }
    ]
}
