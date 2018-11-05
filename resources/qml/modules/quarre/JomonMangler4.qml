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
        name: "crush modulation"

        WPN114.Node on value { path: "/modules/mangler/lfo/crush" }
        y: parent.height*0.2
    }

    QuarreSlider
    {
        name: "resampler modulation"

        WPN114.Node on value { path: "/modules/mangler/lfo/resampler" }
        y: parent.height*0.2 * 2
    }

    QuarreSlider
    {
        name: "modulation filtre"

        WPN114.Node on value { path: "/modules/mangler/lfo/freq" }
        y: parent.height*0.2 * 3
    }

    QuarreSlider
    {
        name: "modulation résonance"

        WPN114.Node on value { path: "/modules/mangler/lfo/res" }
        y: parent.height*0.2 * 3
    }

}
