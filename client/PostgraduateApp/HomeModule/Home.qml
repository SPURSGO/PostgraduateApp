import QtQuick 2.0
import QtQuick.Controls 2.5
import ReadFileQML 1.0
import QtGraphicalEffects 1.0

Page{
    id:root
    signal mysignal
    property alias modelindex: listView.currentIndex
    title:("经验分享")


    Rectangle {
        width: parent.width
        height: parent.height
        color: "white"

        ListModel{
            id:id_model

            ListElement{
                modeltext:""

                imagesource: "qrc:/images/images/tx1.jpg"
                index:0
            }
            ListElement{
                modeltext:""
                imagesource: "qrc:/images/images/tx2.jpg"
                index:1                
            }
            ListElement{
                modeltext:""
                imagesource: "qrc:/images/images/tx3.jpg"
                index:2
            }
            ListElement{
                modeltext:""
                imagesource: "qrc:/images/images/tx4.jpg"
                index:3
            }
            ListElement{
                modeltext:""
                imagesource: "qrc:/images/images/tx5.jpg"
                index:4
            }
            ListElement{
                modeltext:""
                imagesource: "qrc:/images/images/tx6.jpg"
                index:5
            }
        }

        ListView {
            id: listView
            anchors.fill: parent
            anchors.margins: 20
            clip: true
            model: id_model
            delegate: Component {
                id: numberDelegate

                Rectangle {
                    id:rectangle
                    width: ListView.view.width
                    height: 180
                    radius: 10
                    color: ListView.isCurrentItem ? "lightGray" : "gray"

                    Text {
                        id:text1
                        width:parent.width-120
                        height: parent.height
                        wrapMode: Text.WordWrap     //文本自动换行
                        text: modeltext
                        font.pixelSize: 20
                        elide:Text.ElideRight
                    }

                    //OpacityMask中的source表示你要显示的图片，maskSource表示将图片固定在此区域内显示。
                    Item {
                        anchors.right: parent.right
                        id:iconRct
                        width: 100
                        height: 100

                        Rectangle{
                            id:mask
                            width: parent.width
                            height: parent.height
                            radius: width/2
                            visible: false
                        }

                        Image {
                            id: profilepic
                            anchors.fill: parent
                            smooth :true
                            visible: false
                            source: imagesource
                        }

                        OpacityMask{
                            anchors.fill: parent
                            source: profilepic
                            maskSource: mask
                        }
                    }

                    MouseArea {
                        hoverEnabled: true
                        anchors.fill: parent
                        onEntered:
                        {
                            listView.currentIndex = index //实现item切
                        }
                        onClicked: root.mysignal()
                    }
                }
            }
            spacing: 5
            focus: true

            Timer{
                interval: 100;running:true;repeat: false
                onTriggered:{
                  networkmange.sendsingal()  //向服务器发送信号 ，请求接收 文章和视频
                    for(var i=0;i<6;i++){
                        change_id_model_modeltext(i)  //接收文章
                    }
//                   networkmange.receive_vedio()  //接受

                }
            }
        }
    }

    function gettext(n){
        var item = id_model.get(n)
        var mystring = item.modeltext
        return mystring
    }

    function change_id_model_modeltext(n){
        id_model.get(n).modeltext=networkmange.receive_article()
    }
}
