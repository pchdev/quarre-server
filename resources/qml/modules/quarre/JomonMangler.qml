import QtQuick 2.0
import "items"

Rectangle
{
    anchors.fill: parent
    color: "transparent"

    QuarreSlider
    {
        name: "bad_resampler"
        min: 125; max: 33150;
        value: ossia_modules.jomon_mangler_resampler
        onValueChanged: ossia_modules.jomon_mangler_resampler = value
        y: parent.height*0.2
    }

    QuarreSlider
    {
        name: "thermonuclear war"
        min: 0.0; max: 16.0;
        value: ossia_modules.jomon_mangler_thermonuclear
        onValueChanged: ossia_modules.jomon_mangler_thermonuclear = value
        y: parent.height*0.2 * 2
    }

    QuarreSlider
    {
        name: "bitdepth"
        min: 0; max: 8;
        value: ossia_modules.jomon_mangler_bitdepth
        onValueChanged: ossia_modules.jomon_mangler_bitdepth = value
        y: parent.height*0.2 * 3
    }

}
