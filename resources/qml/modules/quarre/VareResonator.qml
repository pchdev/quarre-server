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
        y: parent.height * 0.2

        WPN114.Node on value { path: "/modules/vare/resonator/brightness" }
    }

    QuarreSlider
    {
        name: "position"
        y: parent.height*0.2*2

        WPN114.Node on value { path: "/modules/vare/resonator/position" }
    }

    QuarreSlider
    {
        name: "hauteur"
        min: 0.1; max: 2;
        y: parent.height*0.2*3;

        WPN114.Node on value { path: "/modules/vare/resonator/pitch" }
    }

    QuarreSlider
    {
        name: "résonance"
        min: 0.0; max: 0.4;
        y: parent.height*0.2*4;

        WPN114.Node on value { path: "/modules/vare/resonator/sustain" }
    }
}
