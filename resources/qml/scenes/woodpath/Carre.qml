import QtQuick 2.0
import ".."
import "../.."

Item
{
    Item //------------------------------------------------------------------------------ INTERACTIONS
    {
        id: interactions

        Interaction //------------------------------------------------- KAIVO_XDRONE
        {
            id: kaivo_xdrone_interaction
            title: "Matière brute, sculpture"
            module: "basics/XRotation.qml"
            length: 60
            countdown: 20

            description:
                "Orientez votre appareil de bas en haut, et inversement,
                 afin de modifier le timbre et la vitesse du son continu."

            mappings: QuMapping
            {
                source: "gestures/shake/trigger"
                expression: function(v) {  }
            }
        }

        Interaction //------------------------------------------------- KAIVO_XYDRONE
        {
            id: kaivo_xydrone_interaction
            title: "Matière brute, sculpture (2)"
            module: "basics/XYZRotation.qml"
            length: 75
            countdown: 20

            description:
                "Orientez votre appareil de bas en haut (X) et
                faites pivoter sa tranche (Y) afin de modifier le timbre,
                la vitesse et la hauteur du son continu."

            mappings: QuMapping
            {
                source: "gestures/shake/trigger"
                expression: function(v) {  }
            }
        }

        Interaction //------------------------------------------------- KAIVO_XYDRONE
        {
            id: kaivo_pitchwhip_interaction
            title: "Matière brute, sculpture (2)"
            module: "basics/XYZRotation.qml"
            length: 75
            countdown: 20

            description:
                "Orientez votre appareil de bas en haut (X) et
                faites pivoter sa tranche (Y) afin de modifier le timbre,
                la vitesse et la hauteur du son continu."

            mappings: QuMapping
            {
                source: "gestures/shake/trigger"
                expression: function(v) {  }
            }
        }
    }

}
