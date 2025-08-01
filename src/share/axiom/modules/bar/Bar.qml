import Quickshell
import QtQuick
import qs.styles

PanelWindow {
    id: root
    anchors {
        left: true
        right: true
        top: true
    }

    height: heightBar

    color: "transparent"

    mask: Region {}

    property real heightBar: 39

    StyledRect {

        color: "transparent"
        anchors.top: parent.top
        width: parent.width
        height: root.heightBar

        Row {
            anchors.fill: parent
            StyledRect {
                id: leftWing
                anchors.left: parent.left
                width: parent.width * 0.25
                height: parent.height
            }
            Corners {
                anchors.left: leftWing.right
                corner: Corners.CornerEnum.StraightTopLeft
                size: 40
                x: 0
            }

            StyledRect {

                height: parent.height * 0.85
                width: parent.width * 0.13
                radius: 50
                anchors.centerIn: parent
            }
            Corners {
                anchors.right: rightWing.left
                corner: Corners.CornerEnum.StraightTopRight
                size: 40
            }

            StyledRect {
                id: rightWing
                height: parent.height
                width: parent.width * 0.25
                anchors.right: parent.right
            }
        }
    }
}
