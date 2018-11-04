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
        name: "brillance"
        y: parent.height*0.05

        WPN114.Node on value { path: "/modules/vare/resonator/brightness" }
    }

    QuarreSlider
    {
        name: "position"
        y: parent.height*0.2

        WPN114.Node on value { path: "/modules/vare/resonator/position" }
    }

    QuarreSlider
    {
        name: "hauteur"
        y: parent.height*0.35

        WPN114.Node on value { path: "/modules/vare/resonator/pitch" }
    }

    QuarreSlider
    {
        name: "résonance"
        min: 0.0; max: 0.6
        y: parent.height*0.5

        WPN114.Node on value { path: "/modules/vare/resonator/sustain" }
    }
}
