import QtQuick 2.0
import WPN114 1.0 as WPN114
import "items"
import "../basics/items"

Rectangle
{
    anchors.fill: parent
    color: "transparent"

    QuarreSlider
    {
        name: "ton"        
        y: parent.height*0.2

        WPN114.Node on value { path: "/modules/markhor/body/tone" }
    }

    QuarreSlider
    {
        name: "fréquence de résonance"
        y: parent.height*0.2*2

        WPN114.Node on value { path: "/modules/markhor/body/pitch" }
    }

    WPN114.Node
    {
        id:     body_xy
        path:   "/modules/markhor/body/xy"
        type:   WPN114.Type.Vec2f
        value:  Qt.vector2d(0.0, 0.0)
    }

    QuarreSlider
    {
        name: "modèle horizontal"
        onValueChanged: body_xy.value.x = value;
        y: parent.height*0.2*3
    }

    QuarreSlider
    {
        name: "modèle vertical"
        onValueChanged: body_xy.value.x = value;
        y: parent.height*0.2*4
    }
}
