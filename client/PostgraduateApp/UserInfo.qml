import QtQuick 2.12
import QtQuick.Controls 2.5
import QtGraphicalEffects 1.0
import JSON.Data 1.0

Page {
    property alias _mask: _mask
    property alias but: but

    Column {
        id: column
        x:3
        y: 11
        width: parent.width
        height: 164
        spacing: 8

        Rectangle {
            id: img
            width: 150
            height: 150
            radius: width/2
            //color: "black"

            Image {
                id: _user
                smooth: true
                visible: false
                anchors.fill: parent
                source: "qrc:/images/images/user.jpg"
                antialiasing: true
            }
            Rectangle {
                id: _mask
                anchors.fill: parent
                radius: width/2
                visible: false
                antialiasing: true
                smooth: true
            }
            OpacityMask {
                id:mask_image
                anchors.fill: _user
                source: _user
                maskSource: _mask
                visible: true
                antialiasing: true
            }
            Button{
                id:but
                text:getLoginstatus() ?"登出" :"未登陆"
                anchors.left: _mask.right
                enabled: !getLoginstatus()
                onClicked:{
                    showLogin()
                    console.log(getLoginstatus())
                }
                anchors.leftMargin: 5
            }
        }
        Button{
            width: parent.width
            height: parent.height/2

            flat: true
            background: Rectangle {
                anchors.fill: parent
                color: "#FFFF6F"
                Text {
                    anchors.centerIn: parent
                    text: qsTr("考研会员，更多权益")
                    color: "#ffffff"
                    font.family: "微软雅黑 Light"
                    font.pointSize: 11
                }
            }
        }

        Row{
            Rectangle{id:sp; width: 10;height: 20;color:"#46A3FF"}
            Text {
                id: myservice
                anchors.left: sp
                anchors.leftMargin: 10
                text: qsTr("我的服务")
                font.family:"微软雅黑 Light"
                font.pointSize:12;
            }
        }
        Rectangle{
            width: parent.width
            height: parent.height
            color: "white"

            Row {
                id: row2
                width: parent.width
                spacing: 20
                height: 100

                Item {
                    id: name
                    width: 20
                    height:parent.height
                }

                Button {
                    id: button
                    //anchors.leftMargin: 50
                    width: parent.width/4
                    height:parent.height
                    checkable: true
                    background: Image {
                        id: icon1
                        width: parent.width
                        height: parent.height-20
                        source: "qrc:/images/images/icon1.png"
                    }
                    Text {
                        id: a
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("我的消息")
                    }
                    MouseArea{
                        anchors.fill: parent
                        // onClicked:
                    }

                    // text: qsTr("我的消息")
                }


                Button {
                    id: button1
                    width: parent.width/4
                    height:parent.height
                    checkable: true
                    background: Image {
                        id: icon2
                        width: parent.width
                        height: parent.height-20
                        source: "qrc:/images/images/icon2.png"
                    }
                    Text {
                        id: b
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("我的课程")
                    }
                    MouseArea{
                        anchors.fill: parent
                        // onClicked:
                    }

                }



                Button {
                    id: button2

                    width: parent.width/4
                    height:parent.height
                    checkable: true
                    background: Image {
                        id: icon3
                        width: parent.width
                        height: parent.height-20
                        source: "qrc:/images/images/icon3.png"
                    }
                    Text {
                        id: c
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("课程缓存")
                    }
                    MouseArea{
                        anchors.fill: parent
                        // onClicked:
                    }
                }
            }
        }

        Row{
            Rectangle{id:sp1; width: 10;height: 20;color:"#46A3FF"}
            Text {
                id: mytools
                anchors.left: sp1
                anchors.leftMargin: 10
                text: qsTr("更多工具")
                font.family:"微软雅黑 Light"
                font.pointSize:12
            }
        }
        Rectangle{
            width: parent.width
            height: parent.height
            color: "white"

            Grid{
                id: gridLayout1
                columns: 4;
                rows:2;
                anchors.fill: parent;
                anchors.margins: 5;
                columnSpacing: 10;
                rowSpacing: 10;
                Button {
                    id: button3
                    anchors.leftMargin: 50
                    width: parent.width/5+10
                    height:parent.height/2
                    checkable: true
                    background: Image {
                        id: icon4
                        width: parent.width
                        height: parent.height-20
                        source: "qrc:/images/images/icon4.png"
                    }
                    Text {
                        id: d
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("备考资料")
                    }
                    MouseArea{
                        anchors.fill: parent
                        // onClicked:
                    }

                }
                Button {
                    id: button4

                    width: parent.width/5+10
                    height:parent.height/2
                    checkable: true
                    background: Image {
                        id: icon5
                        width: parent.width
                        height: parent.height-20
                        source: "qrc:/images/images/icon5.png"
                    }
                    Text {
                        id: e
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("音频资料")
                    }
                    MouseArea{
                        anchors.fill: parent
                        // onClicked:
                    }

                }
                Button {
                    id: button5

                    width: parent.width/5+10
                    height:parent.height/2
                    checkable: true
                    background: Image {
                        id: icon6
                        width: parent.width
                        height: parent.height-20
                        source: "qrc:/images/images/icon6.png"
                    }
                    Text {
                        id: f
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("历史记录")
                    }
                    MouseArea{
                        anchors.fill: parent
                        // onClicked:
                    }


                }
                Button {
                    id: button6

                    width: parent.width/5+10
                    height:parent.height/2
                    checkable: true
                    background: Image {
                        id: icon7
                        width: parent.width
                        height: parent.height-20
                        source: "qrc:/images/images/icon7.png"
                    }
                    Text {
                        id: g
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("我的订单")
                    }
                    MouseArea{
                        anchors.fill: parent
                        // onClicked:
                    }

                }
                Button {
                    id: button7

                    width: parent.width/5+10
                    height:parent.height/2
                    checkable: true
                    background: Image {
                        id: icon8
                        width: parent.width
                        height: parent.height-20
                        source: "qrc:/images/images/icon8.png"
                    }
                    Text {
                        id: h
                        anchors.bottom: parent.bottom
                        anchors.horizontalCenter: parent.horizontalCenter
                        text: qsTr("帮助与反馈")
                    }
                    MouseArea{
                        anchors.fill: parent
                        // onClicked:
                    }
                }
            }
        }
    }
}


