import QtQuick 2.12
import QtQuick.Controls 2.5
import JSON.Data 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 480
    height: 720

    property alias data: data

    FontLoader {          //加载字体
        id: robotoLight
        name: "robotoLight"
        source: "qrc:/fonts/fonts/roboto-light.ttf"
    }

    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                } else {
                    drawer.open()
                }
            }
        }

        Label {
            text: stackView.currentItem.title
            anchors.centerIn: parent
        }
    }

    Drawer {
        id: drawer
        width: window.width * 0.3
        height: window.height

        Column {
            anchors.fill: parent

            ItemDelegate {
                text: qsTr("我的")
                width: parent.width
                onClicked: {
                    stackView.push("UserInfo.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("社区")
                width: parent.width
                onClicked: {
                    stackView.push("Community.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("日历")
                width: parent.width
                onClicked: {
                    stackView.push("Calendar.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("院校")
                width: parent.width
                onClicked: {
                    stackView.push("Institution.qml")
                    drawer.close()
                }
            }
            ItemDelegate{
                text: qsTr("登陆")
                width:parent.width
                onClicked: {
                    stackView.push("LoginPage.qml")
                    drawer.close()
                }
            }
            ItemDelegate{
                text: qsTr("注册")
                width:parent.width
                onClicked: {
                    stackView.push("RegisterPage.qml")
                    drawer.close()
                }
            }
        }
    }
    More{
        id:mymore
        text1_txt:mytest.gettext(mytest.modelindex)  //从 home 接收文档
//        text2_txt: mytest.gettext(mytest.modelindex)
    }

    Home{
        id:mytest
        onMysignal:stackView.push(mymore)
    }

    Data{
        id:data
    }

    Timer{
        id:loaddata
        interval: 10;running: true;repeat: false
        onTriggered: data.loadData()
    }

    StackView {
        id: stackView
        initialItem: mytest
        anchors.fill: parent

    }

    function showRegister()   //切换注册见面
    {
        stackView.replace("qrc:/RegisterPage.qml")        
    }

    function showLogin()    //从 注册界面 切换登陆 界面
    {
        stackView.replace("qrc:/LoginPage.qml")
    }
    function loginSuccess()  //登陆成功切换到个人信息页面
    {
        stackView.push("qrc:/UserInfo.qml",{status:1})
    }

    function getLoginstatus()
    {
        return data.loginstatus;
    }

    function setLoginstatus()
    {
        data.loginstatus = true;
    }
    function savefile()
    {
        data.saveData();
    }
}
