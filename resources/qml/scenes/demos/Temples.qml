import QtQuick 2.0
import WPN114 1.0 as WPN114

import ".."
import "../../engine"

Scene
{
    notify: true
    audio: false

    scenario: InteractionExecutor
    {
        id: demos_temples
        source: audiostream
        target: stonepath.ammon.interaction_strings
        countdown: sec( 5 )
        length: WPN114.TimeNode.Infinite

        onStart:
        {
            // we use a different reverb for this scene
            instruments.rooms.active = true;
            instruments.kaivo_1.active = true;
            effects.reverb.active = false;
            effects.lavaur.active = true;

            instruments.k1_fork_921.active      = false
            instruments.k1_fork_lavaur.active   = true
            instruments.kaivo_1.dBlevel         = -4;
            instruments.k1_fork_lavaur.dBlevel  = -12;

            functions.setTimeout(function(){
                instruments.kaivo_1.setPreset(instruments.tguitar);
            }, 1000 )
        }

        InteractionExecutor
        {
            target: stonepath.ammon.interaction_strings_timbre
            countdown: sec( 5 )
            length: WPN114.TimeNode.Infinite
        }

        onEnd:
        {
            effects.reverb.active = true;
            effects.lavaur.active = false;
            instruments.k1_fork_921.active      = true
            instruments.k1_fork_lavaur.active   = false
            instruments.kaivo_1.allNotesOff();
        }
    }
}
