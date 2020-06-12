import QtQuick 2.12
import QtQuick.Controls 2.5

Page {
    width: 320
    height: 480
    title: "我的"


    Column {
        id: column
        x:3
        y: 11
        width: parent.width
        height: 164
        spacing: 2
        Repeater {
            model: 1
            Rectangle {
                width: parent.width
                height: parent.height

                radius: 4

                color: "lightblue"
            }
        }



        Row {
        id: row
        width: parent.width
        height: 80

        Button {
            id: button
            width: parent.width/2
            height:parent.height
            text: qsTr("Button")
        }
        Button {
            id: button1
            width: parent.width/2
            height:parent.height
            text: qsTr("Button")
        }
    }
        Row {
        id: row1
        width: parent.width
        height: 80

        Button {
            id: button2
            width: parent.width/2
            height:parent.height
            text: qsTr("Button")
        }
        Button {
            id: button3
            width: parent.width/2
            height:parent.height
            text: qsTr("Button")
        }
    }
        Row {
        id: row2
        width: parent.width
        height: 80

        Button {
            id: button4
            width: parent.width/2
            height:parent.height
            text: qsTr("Button")
        }
        Button {
            id: button5
            width: parent.width/2
            height:parent.height
            text: qsTr("Button")
        }
    }
   }
}
