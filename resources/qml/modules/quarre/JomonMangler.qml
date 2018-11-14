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
        name: "resampler"
        min: 125; max: 15000;
        WPN114.Node on value { path: "/modules/mangler/resampler" }
        y: parent.height*0.2
    }

    QuarreSlider
    {
        name: "bitcrusher"
        min: 0; max: 2.1
        WPN114.Node on value { path: "/modules/mangler/bitcrusher" }
        y: parent.height*0.2 * 2
    }

    QuarreSlider
    {
        name: "bitdepth"
        min: 3; max: 10;
        WPN114.Node on value { path: "/modules/mangler/bitdepth" }
        y: parent.height*0.2 * 3
    }

    QuarreSlider
    {
        name: "thermonuclear"
        min: 0; max: 16;
        WPN114.Node on value { path: "/modules/mangler/thermonuclear" }
        y: parent.height*0.2 * 4
    }

}
