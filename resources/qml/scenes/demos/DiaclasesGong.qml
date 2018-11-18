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
        source: audiostream
        duration: WPN114.TimeNode.Infinite
        onStart:
        {
            instruments.kaivo_1.dBlevel = -4
            instruments.k1_fork_921.dBlevel = -6;
            instruments.rooms.active = true;
            instruments.kaivo_1.active = true;

            functions.setTimeout(function(){
                instruments.kaivo_1.setPreset( instruments.spring );
            }, 1000 )
        }

        onEnd: instruments.kaivo_1.allNotesOff();

        InteractionExecutor // ========================================== DIACLASES_GONG
        {
            id: gong_palm
            target: stonepath.diaclases.interaction_spring_low
            countdown: sec( 5 )
            length: sec( 45 )
        }

        InteractionExecutor // ========================================== DIACLASES_GONG
        {
            date: sec( 52 )
            target: stonepath.diaclases.interaction_spring_low_2
            countdown: sec( 5 )
            length: sec( 45 )

            onStart: instruments.kaivo_1.set("env1_attack", 0);
            onEnd: scenario.end();
        }

        InteractionExecutor
        {
            target: stonepath.diaclases.interaction_spring_timbre
            countdown: sec( 5 )
            length: min ( 95 )
        }
    }
}
