import QtQuick 2.0
import "items"

Rectangle
{
    anchors.fill: parent
    color: "transparent"

    QuarreSlider
    {
        name: "brillance"
        value: ossia_modules.markhor_resonator_brightness
        onValueChanged: ossia_modules.markhor_resonator_brightness = value
        y: parent.height * 0.2
    }

    QuarreSlider
    {
        name: "position"
        value: ossia_modules.markhor_resonator_inpos
        onValueChanged: ossia_modules.markhor_resonator_inpos = value
        y: parent.height*0.2*2
    }

    QuarreSlider
    {
        name: "hauteur"
        min: 0.1; max: 2;
        onValueChanged: ossia_modules.markhor_resonator_pitch = value
        value: ossia_modules.markhor_resonator_pitch
        y: parent.height*0.2*3;
    }

    QuarreSlider
    {
        name: "résonance"
        min: 0.0; max: 0.4;
        onValueChanged: ossia_modules.markhor_resonator_sustain = value
        value: ossia_modules.markhor_resonator_sustain
        y: parent.height*0.2*4;
    }
}
