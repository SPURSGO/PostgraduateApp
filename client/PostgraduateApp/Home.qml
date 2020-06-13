import QtQuick 2.0
import QtQuick.Controls 2.5

Page{
    id:root
    signal mysignal
    property alias modelindex: listView.currentIndex
    title:("Home")

    Rectangle {
        width: 480
        height:720
        color: "white"

        ListModel{
            id:id_model

            ListElement{
                modeltext:"lzdsdasd"
                index:0
            }
            ListElement{
                modeltext:"1李冯你好呀 "
                index:1
            }
            ListElement{
                modeltext:"2李冯你好呀 "
                index:2
            }
            ListElement{
                modeltext:"3李冯你好呀 "
                index:3
            }
            ListElement{
                modeltext:"4李冯你好呀 "
                index:4
            }
            ListElement{
                modeltext:"5李冯你好呀 "
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
                    height: 80

                    color: ListView.isCurrentItem ? "lightGray" : "gray"

                    Text {
                        id:text1
                        anchors.centerIn: parent
                        font.pixelSize: 10
                        text: modeltext
                    }
                    MouseArea {
                        hoverEnabled: true
                        anchors.fill: parent
                        onEntered: listView.currentIndex = index //实现item切
                        onClicked: root.mysignal()
                    }
                }
            }
            spacing: 5
            focus: true

            Timer{
                interval: 1000;running:true;repeat: false
                onTriggered:{
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
        id_model.get(n).modeltext="dasdsadsadasd"
   }
}
