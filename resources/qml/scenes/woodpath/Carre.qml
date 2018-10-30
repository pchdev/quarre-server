import QtQuick 2.0
import WPN114 1.0 as WPN114
import ".."
import "../.."

Item
{
    id: root
    signal next();

    WPN114.TimeNode
    {
        id: scenario
        source: audio_stream

        InteractionExecutor
        {
            target: interaction_bell_low_1
            date: sec(5)
        }

        InteractionExecutor
        {
            target: interaction_bell_hi_1
            date: sec(10)
        }

        InteractionExecutor
        {


        }
    }

    Item //------------------------------------------------------------------------------ INTERACTIONS
    {
        id: interactions

        Interaction //------------------------------------------------- NIWOOD-LOW
        {
            id: interaction_bell_low_1
            // low smallbells
            title: "Cloches primitives, déclenchement (1)"
        }

        Interaction //------------------------------------------------- NIWOOD-HI
        {
            id: interaction_bell_hi_1
            // hi-smallbells
            title: "Cloches primitives, déclenchement (2)"
        }

        Interaction //------------------------------------------------- NIWOOD-TIMBRE
        {
            id: interaction_bell_timbre_1
            // niwood timbre (brightness 0-0.5, position, body pitch)
            title: "Cloches primitives, timbre (1)"
        }

        Interaction //------------------------------------------------- INSECTS
        {
            id: interaction_insects
            // add and erase insects
            title: "Insectes, déclenchemen"
        }

    }

}
