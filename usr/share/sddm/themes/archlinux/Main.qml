import QtQuick 2.0
import SddmComponents 2.0

Rectangle {
    id: container
    width: 1600
    height: 900

    TextConstants { id: textConstants }

    Connections {
        target: sddm

        onLoginSucceeded: {
            errorMessage.color = "steelblue"
            errorMessage.text = textConstants.loginSucceded
        }

        onLoginFailed: {
            errorMessage.color = "red"
            errorMessage.text = textConstants.loginFailed
        }
    }

    Rectangle {
        id: rectangle1
        property variant geometry: screenModel.geometry(screenModel.primary)
        color: "transparent"
        anchors.fill: parent

        Image {
            id: background
            anchors.fill: parent
            source: "Roxy.png"
        }

        Text {
            color: "#ffffff"
            text: textConstants.welcomeText.arg(sddm.hostName)
            anchors.left: parent.left
            anchors.leftMargin: 14
            anchors.top: parent.top
            anchors.topMargin: 15
            font.pixelSize: 24
        }

        Button {
            id: shutdownButton
            color: "#0088cc"
            text: textConstants.shutdown
            borderColor: "#333333"
            activeColor: "#0088cc"
            border.color: "#333333"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10
            anchors.right: parent.right
            anchors.rightMargin: 10

            onClicked: sddm.powerOff()

            KeyNavigation.backtab: loginButton; KeyNavigation.tab: rebootButton
        }

        Button {
            id: rebootButton
            color: "#0088cc"
            text: textConstants.reboot
            border.color: "#333333"
            activeColor: "#0088cc"
            borderColor: "#333333"
            anchors.right: parent.right
            anchors.rightMargin: 100
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 10

            onClicked: sddm.reboot()

            KeyNavigation.backtab: shutdownButton; KeyNavigation.tab: name
        }

        Column {
            id: column1
            width: 511
            height: 245
            anchors.top: parent.top
            anchors.topMargin: 100
            anchors.right: parent.right
            anchors.rightMargin: 50
            spacing: 12

            Column {
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 4
                Text {
                    id: lblName
                    width: 60
                    color: "#ffffff"
                    text: textConstants.userName
                    font.bold: true
                    font.pixelSize: 12
                }

                TextBox {
                    id: name
                    width: parent.width; height: 30
                    text: userModel.lastUser
                    font.pixelSize: 14

                    KeyNavigation.backtab: rebootButton; KeyNavigation.tab: password

                    Keys.onPressed: {
                        if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                            sddm.login(name.text, password.text, session.index)
                            event.accepted = true
                        }
                    }
                }
            }

            Column {
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                spacing : 4
                Text {
                    id: lblPassword
                    width: 60
                    color: "#ffffff"
                    text: textConstants.password
                    font.bold: true
                    font.pixelSize: 12
                }

                TextBox {
                    id: password
                    width: parent.width; height: 30
                    font.pixelSize: 14

                    echoMode: TextInput.Password

                    KeyNavigation.backtab: name; KeyNavigation.tab: session

                    Keys.onPressed: {
                        if (event.key === Qt.Key_Return) {
                            sddm.login(name.text, password.text, session.index)
                            event.accepted = true
                        }
                    }
                }
            }

            Column {
                z: 100
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                spacing : 4
                Text {
                    id: lblSession
                    width: 60
                    color: "#ffffff"
                    text: textConstants.session
                    font.bold: true
                    font.pixelSize: 12
                }

                ComboBox {
                    id: session
                    width: parent.width; height: 30
                    font.pixelSize: 14

                    arrowIcon: "angle-down.png"

                    model: sessionModel
                    index: sessionModel.lastIndex

                    KeyNavigation.backtab: password; KeyNavigation.tab: loginButton
                }
            }

            Column {
                width: parent.width
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    id: errorMessage
                    color: "#0088cc"
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: textConstants.prompt
                    font.pixelSize: 10
                }
            }

            Row {
                id: row1
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 40
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 4

                Button {
                    id: loginButton
                    color: "#0088cc"
                    text: textConstants.login
                    activeColor: "#0088cc"
                    borderColor: "#333333"
                    border.color: "#333333"
                    anchors.horizontalCenter: parent.horizontalCenter

                    onClicked: sddm.login(name.text, password.text, session.index)

                    KeyNavigation.backtab: session; KeyNavigation.tab: shutdownButton
                }
            }
        }





    }

    Component.onCompleted: {
        if (name.text == "")
            name.focus = true
        else
            password.focus = true
    }
}
