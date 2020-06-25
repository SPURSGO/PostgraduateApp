import QtQuick 2.0
import QtQuick.Controls 2.5

Page{
    property alias text: text1.text
    width: parent.width
    height: parent.height
    title:("More")

    Flickable{
            id:myflickable
            width: parent.width
            height: parent.height/2
            contentWidth: parent.width
            contentHeight: 2000
            flickableDirection: Flickable.VerticalFlick
            Column{
                spacing: 1475
            Rectangle{
                    id:moreRectangle1
                    width: myflickable.width
                    height: myflickable.height/2
                    Text {
                        id:text1
                        width:parent.width
                        height: parent.height
                        wrapMode: Text.WordWrap     //文本自动换行
                        font.pixelSize: 20
                   //     elide:Text.ElideRight
                    }

                }
            Rectangle{
                    id:moreRectangle2
                    width:myflickable.width
                    height:myflickable.height/2
                    //border.color: "black"
                    //radius: 10

                    ListModel{
                        id:more_listmodel
                    }

                    ListView{
                        id:moreListView
                        anchors.fill: parent
                        header:Rectangle{
                               width:parent.width
                               height:50
                               Text {
                                   id: headerText
                                   anchors.centerIn: parent
                                   text: qsTr("-----------------------------------------热点评论-----------------------------------------")
                               }
                        }


                        /*footer: Rectangle{
                            width:parent.width
                            height:50
                            anchors.centerIn: parent
                            Text {
                                id: footerText
                                text: qsTr("Footer")
                                anchors.centerIn: parent

                            }
                        }*/

                    }
                    }
            }

    }


}
