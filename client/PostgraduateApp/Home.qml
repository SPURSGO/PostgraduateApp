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
                    for(var i=0;i<6;i++){
                        change_id_model_modeltext(i)
                    }
                }
          }
        }
    }
    FileIo{
           id:myFile
           source:"good.txt"
           onError: console.log(msg)
       }

    function gettext(n){
        var item = id_model.get(n)
        var mystring = item.modeltext
        return mystring
    }

    function change_id_model_modeltext(n){
        console.log("WRITE:" + myFile.write("this is really coolFileContent needs to inherit the QObject class and use a series of Qt macros within the class.
The Q_PROPERTY macro is used here to declare a property of this class and give the method names corresponding to set and get. There is also the Q_INVOKABLE macro so that the methods of the FileContent class can be called in QML.

The FileContent class here has two properties, one is the file name filename and the other is the content of the file. These two properties can be directly assigned as properties of Item in QML.

We call FileContent in QML as FileContentItem, but now we can't diris is really coolFileContent needs to inherit the QObject class and use a series of Qt macros within the class.
The Q_PROPERTY macro is used here to declare a property of this class and give the method names corresponding to set and get. There is also the Q_INVOKABLE macro so that the methods of the FileContent class can be called in QML.

The FileContent class here has two properties, one is the file name filename and the other is the content of the file. These two properties can be directly assigned as properties of Item in QML.

We call FileContent in QML as FileContentItem, but now we can't diris is really coolFileContent needs to inherit the QObject class and use a series of Qt macros within the class.
The Q_PROPERTY macro is used here to declare a property of this class and give the method names corresponding to set and get. There is also the Q_INVOKABLE macro so that the methods of the FileContent class can be called in QML.

The FileContent class here has two properties, one is the file name filename and the other is the content of the file. These two properties can be directly assigned as properties of Item in QML.

We call FileContent in QML as FileContentItem, but now we can't directly refer to FileContentItem in QML files. We also need to register the class we wrote to the Qml system through the qmlRegisterType method provided by QmlEngine.

Add in the main function:!"));
        console.log("source: "+myFile.source)
        id_model.get(n).modeltext= myFile.read()
        id_model.get(n).imagesource="/images/images/profilePic.png"
   }
}
