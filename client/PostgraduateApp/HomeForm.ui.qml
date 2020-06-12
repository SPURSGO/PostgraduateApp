import QtQuick 2.12
import QtQuick.Controls 2.5

Page {
    visible: true
    width: 320
    height: 480

    title: qsTr("Home")

    // @disable-check M221
    Component {
        id: numberDelegate

        Rectangle {
            width: ListView.view.width
            height: 80

            color: ListView.isCurrentItem ? "lightGray" : "gray"

            Text {
                anchors.centerIn: parent
                font.pixelSize: 10
                text: index
            }
            MouseArea {
                hoverEnabled: true
                anchors.fill: parent
                onEntered: listView.currentIndex = index //实现item切
            }
        }
    }

    Rectangle {
        width: 320
        height: 480
        color: "white"
        ListView {
            id: listView
            anchors.fill: parent
            anchors.margins: 20
            clip: true
            model: 10
            delegate: numberDelegate
            spacing: 5
            focus: true
        }
    }
}
