import QtQuick 2.0
import QtQuick.Controls 1.4
import WPN114 1.0 as WPN114
import "../../basics/items"

Item
{
    id: root
    property string method
    property bool mono: false

    anchors.fill: parent

    WPN114.Node
    {
        id:     node_position_left
        path:   root.method+'/source/position/left'
        type:   WPN114.Type.Vec2f

        critical: true
        value: Qt.vector2d(0.5, 0.5)
    }

    WPN114.Node
    {
        id:     node_position_right
        path:   root.method+'/source/position/right'
        type:   WPN114.Type.Vec2f

        critical: true
        value: Qt.vector2d(0.5, 0.5)
    }

    TabView
    {
        anchors.fill: parent

        Tab
        {
            title: "mix"

            Rectangle
            {
                anchors.fill: parent

                Button //-------------------------------------------------------------------- PLAY
                {
                    anchors.horizontalCenter: parent.horizontalCenter

                    text: root.method
                    WPN114.Node on checked { path: root.method+'/functions/play'; critical: true }
                }

                QuarreSlider //-------------------------------------------------------------- LEVEL
                {
                    id: dBlevel_slider
                    name: "level"
                    y: 50
                    min: -96;
                    max: 12;

                    WPN114.Node on value { path: root.method+'/stream/dBlevel'; critical: true }
                }

                QuarreSlider //-------------------------------------------------------------- VERB
                {
                    id: reverb_slider
                    name: "reverb"
                    y: 100
                    min: -96;
                    max: 12;

//                    WPN114.Node on value { path: root.method+'/reverb/'+'dblevel'; critical: true }
                }
            }
        }

        Tab
        {
            title: "space"

            SpatializationSphere
            {
                id: sphere
                property var selection: source_l

                MouseArea
                {
                    anchors.fill: parent
                    onPressed:
                    {
                        selection.x = mouseX;
                        selection.y = mouseY;
                    }
                }

                Rectangle //-------------------------------------------------------------- LEFT_CH
                {
                    id:      source_l
                    width:   root.width*0.1
                    height:  width
                    radius:  width/2
                    color:   "green"

                    onXChanged: node_position_left.value.x = x/parent.width
                    onYChanged: node_position_left.value.y = y/parent.height

                    MouseArea
                    {
                        anchors.fill: parent
                        onPressed: sphere.selection = source_l
                    }
                }

                Rectangle //-------------------------------------------------------------- RIGHT_CH
                {
                    id:      source_r
                    width:   root.width*0.1
                    height:  width
                    radius:  width/2
                    color:   "red"

                    onXChanged: node_position_right.value.x = x/parent.width
                    onYChanged: node_position_right.value.y = y/parent.height

                    MouseArea
                    {
                        anchors.fill: parent
                        onPressed: sphere.selection = source_r
                    }
                }
            }
        }
    }
}
