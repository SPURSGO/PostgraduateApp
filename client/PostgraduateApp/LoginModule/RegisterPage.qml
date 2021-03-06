import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1


Page {
    title:("注册")
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
            placeholderText: qsTr("请输入用户名")

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
            placeholderText: qsTr("请输入密码")

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
            placeholderText: qsTr("请再次输入密码")

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

        Button{
            id: regsterBtn
            Layout.preferredWidth: register.sourceSize.width *4
            Layout.preferredHeight: register.height
            font.pixelSize: Math.round(register.height/5)
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("注册")

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
                    var message_1 = "请输入用户名"
                    popup.popMessage = message_1
                    popup.open()
                }
               else if(registerPassword.text ==="" || registerPassword_copy.text==="")
                {
                    var message_2 = "请输入密码"
                    popup.popMessage = message_2
                    popup.open()
                }
               else if(registerPassword.text != registerPassword_copy.text)
                {
                   var message = "请确保两次输入的密码一致"
                   popup.popMessage = message
                   popup.open()
               }
               else
               {
                   if(!networkmange.register_userinfo(registerUsername.text, registerPassword.text))  //注册失败
                   {
                       var message_3 = "该账户已存在，注册失败"
                       popup.popMessage = message_3
                       popup.open()
                   }else{                  //注册成功
                       var message_4 = "注册成功"
                       popup.popMessage = message_4
                       popup.open()
                       registertime.start()
                   }
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
            text: qsTr("已存在一个账户，点我")
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
                    text: qsTr("登陆")
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

    // Popup will be closed automatically in 3 seconds after its opened
    Timer {
        id: popupClose
        interval: 3000
        onTriggered: popup.close()
    }

    Timer{
        id:registertime
        interval: 2000
        onTriggered: showLogin()
    }

}
