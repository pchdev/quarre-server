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
        name: "drive"

        WPN114.Node on value { path: "/modules/mangler/drive" }
        y: parent.height*0.2
    }

    QuarreSlider
    {
        name: "crush"
        max: 0.85

        WPN114.Node on value { path: "/modules/mangler/crush" }
        y: parent.height*0.2 * 2
    }

    QuarreSlider
    {
        name: "resampler"
        min: 0; max: 0.8;

        WPN114.Node on value { path: "/modules/mangler/resampler" }
        y: parent.height*0.2 * 3
    }

}
