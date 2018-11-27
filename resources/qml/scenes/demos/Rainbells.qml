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
        id: demos_rainbells
        source: audiostream
        target: woodpath.vare.interaction_rainbells
        countdown: sec( 5 )
        length: sec( 60 )

        onStart:
        {
            instruments.kaivo_1.dBlevel = -18
            instruments.k1_fork_921.dBlevel = -24;
            instruments.rooms.active = true;
            instruments.kaivo_1.active = true;
            functions.setTimeout(function(){
                instruments.kaivo_1.setPreset( instruments.rainbells );
            }, 1000 )

        }

        onEnd: instruments.kaivo_1.allNotesOff();
    }
}
