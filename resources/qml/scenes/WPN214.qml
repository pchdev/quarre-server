import QtQuick 2.0
import WPN114 1.0 as WPN114
import ".."
import "../engine"

Scene
{
    id: root

    property var fade_target: woodpath.jomon

    scenario: WPN114.TimeNode
    {
        source: audiostream
        parentNode: parent.scenario
        duration: WPN114.TimeNode.Infinite

        InteractionExecutor
        {
            id:         interaction_ending_ex
            target:     interaction_ending
            countdown:  sec( 10 )
            length:     min( 4.30 )

            onStart:    sampler.play();
        }

        WPN114.Automation
        {
            after: interaction_ending_ex;
            target: fade_target.rooms
            property: "level"
            duration: sec( 10 )

            from: fade_target.rooms.level; to: 0;

            onEnd:
            {
                if ( fade_target === woodpath.jomon )
                     woodpath.jomon.cicadas.stop()
                else if ( fade_target === stonepath.ammon )
                     stonepath.ammon.wind.stop();

                functions.setTimeout(function(){
                    fade_target.rooms.active = false
                    scenario.end();
                }, 2000 )
            }
        }
    }

    Interaction //----------------------------------------------------- INTERACTION
    {
        id: interaction_ending
        title: "Crédits"
        module: "quarre/WPN214.qml"
        description: "Merci pour votre participation"
        broadcast: true
    }

    WPN114.StereoSource //----------------------------------------- SAMPLER
    {
        parentStream: rooms
        fixed: true
        diffuse: 0.2
        xspread: 0.25
        y: 0.75

        exposePath: fmt("audio/sampler/source")

        WPN114.StreamSampler { id: sampler; dBlevel: -9
            exposePath: fmt("audio/sampler")
            path: "audio/wpn214/wpn214.wav" }
    }
}

