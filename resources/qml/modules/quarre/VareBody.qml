import QtQuick 2.0
import "items"

Rectangle
{
    anchors.fill: parent
    color: "transparent"

    QuarreSlider
    {
        name: "ton"
        value: ossia_modules.vare_body_tone
        onValueChanged: ossia_modules.vare_body_tone = value
        y: parent.height*0.05
    }

    QuarreSlider
    {
        name: "fréquence de résonance"
        min: -1.0; max: 1.0
        value: ossia_modules.vare_body_pitch
        onValueChanged: ossia_modules.vare_body_pitch = value
        y: parent.height*0.20
    }

    QuarreSlider
    {
        name: "position horizontale"
        value: ossia_modules.vare_body_xy.x
        onValueChanged: ossia_modules.vare_body_xy.x = value
        y: parent.height*0.35
    }

    QuarreSlider
    {
        name: "position verticale"
        value: ossia_modules.vare_body_xy.y
        onValueChanged: ossia_modules.vare_body_xy.y = value
        y: parent.height*0.5
    }

    QuarreSlider
    {
        name: "résonance"
        value: ossia_modules.vare_body_sustain
        onValueChanged: ossia_modules.vare_body_sustain = value
        y: parent.height*0.65
    }
}
