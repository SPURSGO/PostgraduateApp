import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import PGAPP.controls 1.0

Page {
    id: registerPage

    property color backGroundColor : "#353535"  //背景颜色
    property color mainAppColor: "#ffffff"
    property color mainTextCOlor: "#f0f0f0"
    property color popupBackGroundColor: "#b44"
    property color popupTextCOlor: "#ffffff"

//    signal registerClicked()

    background: Rectangle {
        color: backGroundColor
    }

    // Place title uniqCast and profileImage
    Rectangle {
        id: iconRect
        width: parent.width
        height: parent.height / 4
        color: backGroundColor
        Image {
            id: register
            source: "qrc:/images/images/register.png"
            sourceSize.width: registerPage.width / 5.5
            sourceSize.height: registerPage.height / 5.5
            anchors.horizontalCenter: iconRect.horizontalCenter
            anchors.bottom: iconRect.bottom
        }
    }

    // UserName, PIN and Login btn
    ColumnLayout {
        id:colum
        width: parent.width
        anchors.top: iconRect.bottom
        anchors.topMargin: parent.height/20
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: parent.height / 15

        TextField {

            id: registerUsername
            placeholderText: qsTr("User Name")

            Layout.preferredWidth: register.sourceSize.width *4

            Layout.alignment: Qt.AlignHCenter
            color: mainTextCOlor
            font.pixelSize: Math.round(register.sourceSize.width/5)
            font.family: "robotLight"
            leftPadding: 30
            background: Rectangle {
                    width: parent.width - 10
                    height: parent.height

                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    color: backGroundColor
                    border.color: "white"
                    border.width: 1
                    radius: height / 2
            }

            onAccepted:
            {
            }
        }

        TextField {
            id: registerPassword
            placeholderText: qsTr("please enter password")

            Layout.preferredWidth: register.sourceSize.width *4
            Layout.alignment: Qt.AlignHCenter
            color: mainTextCOlor
            font.pixelSize: Math.round(register.sourceSize.width/5)
            font.family: "robotoLight"
            leftPadding: 30
            echoMode: TextField.Password
            background: Rectangle {
                    width: parent.width - 10
                    height: parent.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    color: backGroundColor
                    border.color: "white"
                    border.width: 1
                    radius: height / 2
            }

            onAccepted:    //槽  接受回车键的信号
            {

            }
        }

        TextField {
            id: registerPassword_copy
            placeholderText: qsTr("Please enter the password again")

            Layout.preferredWidth: register.sourceSize.width *4
            Layout.alignment: Qt.AlignHCenter
            color: mainTextCOlor
            font.pixelSize: Math.round(register.sourceSize.width/5)
            font.family: "robotoLight"
            leftPadding: 30
            echoMode: TextField.Password
            background: Rectangle {
                    width: parent.width - 10
                    height: parent.height
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    color: backGroundColor
                    border.color: "white"
                    border.width: 1
                    radius: height / 2
            }

            onAccepted:    //槽  接受回车键的信号
            {

            }
        }

        UserRegister
        {
            id:ur
        }

        Button{
            id: regsterBtn
            Layout.preferredWidth: register.sourceSize.width *4
            Layout.preferredHeight: register.height
            font.pixelSize: Math.round(register.height/5)
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Sign up")

            contentItem: Text {
                text: regsterBtn.text
                font: regsterBtn.font
                opacity: enabled ? 1.0 : 0.3
                color: regsterBtn.down ? "burlywood" : "#ffffff"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                height: register.height
                color: "transparent"
                border.color: regsterBtn.down ? "burlywood" : "#ffffff"
            }


            onClicked: {  // 在本地进行一些简单的验证
               if(registerUsername.text ==="")
                {
                    var message_1 = "please enter user name"
                    popup.popMessage = message_1
                    popup.open()
                }
               else if(registerPassword.text ==="" || registerPassword_copy.text==="")
                {
                    var message_2 = "Please enter the password"
                    popup.popMessage = message_2
                    popup.open()
                }
               else if(registerPassword.text != registerPassword_copy.text)
                {
                   var message = "Please ensure that the password entered twice is the same"
                   popup.popMessage = message
                   popup.open()
               }
               else
               {
//                    ur.sendInfo(registerUsername.text, registerPassword.text) //

                   networkmange.register_userinfo(registerUsername.text, registerPassword.text)
               }

            }
        }

    }

    RowLayout {     //切换登陆 按钮
        id: row
        height: 30

        anchors.top: colum.bottom
        anchors.topMargin: 50
        anchors.right: parent.right
        anchors.rightMargin: 30
        anchors.left: parent.left
        anchors.leftMargin: 30
        spacing: 20
        Label {
            id: label
            color: "#ffffff"
            text: qsTr("Already have an account? Click me")
            font.pointSize: 11
            font.family: "微软雅黑 Light"
        }

        Button {
            id: loginButton
            Layout.preferredWidth: text2.width
            height: 20

            background: Rectangle {
                anchors.fill: parent
                color: "transparent"

                Text {
                    id:text2
                    anchors.centerIn: parent
                    text: qsTr("Sign in")
                    color: "white"
                    font.underline: true
                    font.family: "微软雅黑"
                    font.pointSize: 12
                }
            }
            onClicked: {   //切换登陆
                showLogin()
            }
        }
    }



    //Popup to show messages or warnings on the bottom postion of the screen
    Popup {       //弹出控件   //验证 用户 密码 是否正确可以使用
        id: popup
        property alias popMessage: message.text

        background: Rectangle {
            implicitWidth: registerPage.width
            implicitHeight: 60
            color: popupBackGroundColor
        }
        y: (registerPage.height - 60)
        modal: true
        focus: true
        closePolicy: Popup.CloseOnPressOutside
        Text {
            id: message
            anchors.centerIn: parent
            font.pointSize: 12
            color: popupTextCOlor
        }
        onOpened: popupClose.start()
    }

    // Popup will be closed automatically in 2 seconds after its opened
    Timer {
        id: popupClose
        interval: 3000
        onTriggered: popup.close()
    }

}
