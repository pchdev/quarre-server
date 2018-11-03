import QtQuick 2.0
import WPN114 1.0 as WPN114
import "../.."
import ".."

Item
{

    WPN114.TimeNode
    {
        id: mix_scenario
        exposePath: "/mix/scenario"
        source: audio_stream
        duration: -1

        onEnd:
        {
            // save preset
        }
    }

    MixInteraction
    {
        id:      introduction_mix_interaction
        target:  "/introduction/audio"
    }
}
