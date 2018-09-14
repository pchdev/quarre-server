import QtQuick 2.0
import "items"

Rectangle
{
    anchors.fill: parent
    color: "transparent"

    property bool shaking: false;

    onEnabledChanged:
    {

    }

    QuarreSlider
    {
        name: "longueur enveloppe"
        min: 0.0; max: 0.3
        value: ossia_modules.vare_env_decay
        onValueChanged: ossia_modules.vare_env_decay = value
        y: parent.height*0.05
    }

    QuarreSlider
    {
        name: "longueur enveloppe 2"
        min: 0.0; max: 1.0
        value: ossia_modules.vare_gate_decay
        onValueChanged: ossia_modules.vare_gate_decay = value
        y: parent.height*0.2
    }

    QuarreSlider
    {
        name: "spectre"
        value: ossia_modules.vare_gate_leak
        onValueChanged: ossia_modules.vare_gate_leak = value
        y: parent.height*0.35
    }

    QuarreSlider
    {
        name: "vitesse modulation"
        min: 0.1; max: 50
        value: ossia_modules.vare_noise_rate
        onValueChanged: ossia_modules.vare_noise_rate = value
        y: parent.height*0.5
    }

    QuarreSlider
    {
        name: "taille modulation"
        min: 0.0; max: 100
        value: ossia_modules.vare_sequencer_width
        onValueChanged: ossia_modules.vare_sequencer_width = value
        y: parent.height*0.65
    }
}
