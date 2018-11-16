import QtQuick 2.0
import WPN114 1.0 as WPN114
import ".."
import "../../engine"

Scene
{
    notify: true
    audio: false

    scenario: WPN114.TimeNode
    {
        source:      audiostream
        parentNode:  parent.scenario
        duration:    WPN114.TimeNode.Infinite

        onStart:
        {
            instruments.kaivo_1.active = true;
            instruments.rooms.active = true;
        }

        onEnd:
        {
            instruments.kaivo_1.active = false;
            instruments.rooms.active = false;
        }

        InteractionExecutor // ========================================== DIACLASES_GONG
        {
            id: demos_diaclases
            exposePath: fmt( "diaclases" )
            target: stonepath.diaclases.interaction_spring_low
            countdown: sec( 5 )
            length: WPN114.TimeNode.Infinite

            onStart:
            {
                instruments.kaivo_1.setPreset( instruments.spring );
                instruments.kaivo_1.set("env1_attack", 0)
            }

            InteractionExecutor
            {
                target: stonepath.diaclases.interaction_spring_timbre
                countdown: sec( 5 )
                length: WPN114.TimeNode.Infinite
            }
        }

        InteractionExecutor // ========================================== RAINBELLS
        {
            id: demos_rainbells
            after: demos_diaclases
            exposePath: fmt( "rainbells" )
            target: woodpath.vare.interaction_rainbells
            countdown: sec( 5 )
            length: WPN114.TimeNode.Infinite

            onStart: instruments.kaivo_1.setPreset( instruments.rainbells );
            onEnd: instruments.kaivo_1.allNotesOff();
        }

        InteractionExecutor // ========================================== TEMPLES
        {
            id: demos_temples
            after: demos_rainbells
            exposePath: fmt( "temples" );
            target: stonepath.ammon.interaction_strings
            countdown: sec( 5 )
            length: WPN114.TimeNode.Infinite

            onStart:
            {
                instruments.kaivo_1.setPreset( instruments.tguitar );
                // set lavaur verb
            }

            InteractionExecutor
            {
                target: stonepath.ammon.interaction_strings_timbre
                countdown: sec( 5 )
                length: WPN114.TimeNode.Infinite
            }

            onEnd: scenario.end();
        }
    }
}
