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
        source: audiostream
        target: woodpath.carre.interaction_insects
        countdown: sec( 5 )
        length: sec( 60 )

        onStart:
        {
            woodpath.carre.rooms.active = true
            woodpath.carre.insects.dBlevel = 0
            woodpath.carre.insects.play();
        }

        onEnd:
        {
            woodpath.carre.insects.stop();
            woodpath.carre.rooms.active = false
        }
    }
}
