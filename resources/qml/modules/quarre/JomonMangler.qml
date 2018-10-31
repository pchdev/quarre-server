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
        name: "bad_resampler"
        min: 125; max: 33150;

        WPN114.Node on value { path: "/modules/mangler/resampler" }
        y: parent.height*0.2
    }

    QuarreSlider
    {
        name: "thermonuclear war"
        min: 0.0; max: 16.0;

        WPN114.Node on value { path: "/modules/mangler/thermonuclear" }
        y: parent.height*0.2 * 2
    }

    QuarreSlider
    {
        name: "bitdepth"
        min: 0; max: 8;

        WPN114.Node on value { path: "/modules/mangler/bitdepth" }
        y: parent.height*0.2 * 3
    }

}
