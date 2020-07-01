import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.1
import JSON.Data 1.0

Page {
    id: loginPage

    title:("登陆")
    property color backGroundColor : "#353535"  //背景颜色
    property color mainAppColor: "#ffffff"
    property color mainTextCOlor: "#f0f0f0"
    property color popupBackGroundColor: "#b44"
    property color popupTextCOlor: "#ffffff"


    background: Rectangle {
        color: backGroundColor
    }

    // Place title uniqCast and profileImage
    Rectangle {
        id: iconRect
        width: parent.width
        height: parent.height / 2.6
        color: backGroundColor

        Text {       //uniqCase
            id: title
            text: qsTr("<b>Graduate</b>")
            font.family: "robotLight"
            color: mainAppColor
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: (parent.height/6) * -1
            font.pixelSize: Math.round(profilePic.height/3)
        }

        Image {     //头像
            id: profilePic
            source: "qrc:/images/images/profilePic.png"
            sourceSize.width: loginPage.width / 5.5
            sourceSize.height: loginPage.height / 5.5
            anchors.horizontalCenter: iconRect.horizontalCenter
            anchors.bottom: iconRect.bottom
        }
    }

    // UserName, PIN and Login btn   // 用户名 密码 登陆按钮
    ColumnLayout {
        width: parent.width
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: parent.height / 6
        spacing: parent.height / 10

        TextField {

            id: loginUsername
            placeholderText: qsTr("请输入用户名")
            Layout.preferredWidth: title.width * 3
            Layout.alignment: Qt.AlignHCenter
            color: mainTextCOlor
            font.pixelSize: Math.round(profilePic.height/5)
            font.family: "robotLight"
            leftPadding: 30
            background: Rectangle {
                width: parent.width - 10
                height: 1
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                color: mainAppColor
            }

            onAccepted:
            {
            }
        }

        TextField {
            id: loginPassword
            placeholderText: qsTr("请输入密码")
            Layout.preferredWidth: title.width * 3
            Layout.alignment: Qt.AlignHCenter
            color: mainTextCOlor
            font.pixelSize: Math.round(profilePic.height/5)
            font.family: "robotoLight"
            leftPadding: 30
            echoMode: TextField.Password
            background: Rectangle {
                width: parent.width - 10
                height: 1
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                color: mainAppColor
            }

            onAccepted:    //槽  接受回车键的信号
            {
            }
        }

        Button{     //登陆按钮
            id: loginBtn
            Layout.preferredWidth: title.width * 3
            Layout.preferredHeight: profilePic.height
            font.pixelSize: Math.round(profilePic.height/5)
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("登陆")

            contentItem: Text {
                text: loginBtn.text
                font: loginBtn.font
                opacity: enabled ? 1.0 : 0.3
                color: loginBtn.down ? "burlywood" : "#ffffff"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                elide: Text.ElideRight
            }

            background: Rectangle {
                height: profilePic.height
                color: "transparent"
                border.color: loginBtn.down ? "burlywood" : "#ffffff"
            }

            // Trigger loginUser with username and password
            onClicked: {  //点击登陆


                if(loginUsername.text=="" || loginPassword.text=="")
                {
                    var message_2 = "请输入用户名或密码"
                    popup.popMessage = message_2
                    popup.open()
                }else{
                    if(networkmange.login(loginUsername.text,loginPassword.text)) //登陆成功
                    {

                        var message = "登陆成功"
                        popup.popMessage = message
                        popup.open()
                        logintimer.start();
                        setLoginstatus();
                        savefile()
                    }else{
                        var message_1 = "登陆失败，错误的用户名或密码"
                        popup.popMessage = message_1
                        popup.open()
                    }
                }
            }
        }



        RowLayout {     //注册 和 忘记密码
            id: row1
            width: parent.width
            height: 30
            spacing:parent.width/4*2

            Button {      //注册按钮   可以进行页面切换
                id: register

                height: parent.height
                Layout.preferredWidth: text1.width
                Layout.leftMargin: parent.width/7
                background: Rectangle {
                    anchors.fill: parent
                    color: "transparent"

                    Text {
                        id: text1
                        anchors.centerIn: parent
                        text: qsTr("注册>>")
                        color: "#ffffff"
                        font.underline: true
                        font.family: "微软雅黑 Light"
                        font.pointSize:11
                    }
                }
                onClicked: {
                    showRegister()   //切换注册界面
                }
            }

            Button {    //忘记密码  没有实现
                id: forgetPsd
                width: 63
                height: 12

                Layout.rightMargin: parent.width/7

                background: Rectangle {
                    anchors.fill: parent
                    color: "transparent"
                    Text {
                        anchors.centerIn: parent
                        text: qsTr("忘记密码?")
                        color: "#ffffff"
                        font.family: "微软雅黑 Light"
                        font.pointSize: 11
                    }
                }
            }
        }
    }


    //Popup to show messages or warnings on the bottom postion of the screen
    Popup {       //弹出控件   //验证 用户 密码 是否正确可以使用
        id: popup
        property alias popMessage: message.text

        background: Rectangle {
            implicitWidth: loginPage.width
            implicitHeight: 60
            color: popupBackGroundColor
        }
        y: (loginPage.height - 60)
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
        interval: 2000
        onTriggered: popup.close()
    }

    Timer{
        id:logintimer
        interval: 2000
        onTriggered: loginSuccess()
    }

}
