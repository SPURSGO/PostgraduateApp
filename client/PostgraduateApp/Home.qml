import QtQuick 2.0
import QtQuick.Controls 2.5
import ReadFileQML 1.0

Page{
    id:root
    signal mysignal
    property alias modelindex: listView.currentIndex
    title:("Home")

    Rectangle {
        width: parent.width
        height: parent.height
        color: "white"

        ListModel{
            id:id_model

            ListElement{
                modeltext:""
                imagesource: ""
                index:0
            }
            ListElement{
                modeltext:""
                imagesource: ""
                index:1
            }
            ListElement{
                modeltext:""
                imagesource: ""
                index:2
            }
            ListElement{
                modeltext:""
                imagesource: ""
                index:3
            }
            ListElement{
                modeltext:""
                imagesource: ""
                index:4
            }
            ListElement{
                modeltext:""
                imagesource: ""
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
                    Image {
                        height: 100
                        width: 120
                        anchors.right: parent.right
                        id: rectangle_image
                        source: imagesource
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
                    networkmange.sendsingal()
                    for(var i=0;i<6;i++){
                        change_id_model_modeltext(i)
                    }
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
//        id_model.get(n).imagesource="/images/images/profilePic.png"
    }
}
