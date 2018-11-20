import QtQuick 2.0
import WPN114 1.0 as WPN114
import ".."
import "../../engine"

Scene
{
    id: root
    notify: true
    audio: false

    scenario: WPN114.TimeNode
    {
        onStart:
        {
            console.log("starting demos")
            insectspat.start()
        }
    }

    property bool follow: false

    WPN114.Node on follow { path: "/scenario/demos/follow" }

    Insects         { id: insectspat; path: root.fmt("insects") }
    DiaclasesGong   { id: diaclases; path: root.fmt("diaclases") }
    Rainbells       { id: rainbells; path: root.fmt("rainbells") }
    Temples         { id: temples; path: root.fmt("temples") }

    Connections { target: insectspat; onEnd: if ( follow ) diaclases.start(); }
    Connections { target: diaclases; onEnd: if ( follow ) rainbells.start() }
    Connections { target: rainbells; onEnd: if ( follow )temples.start() }
}
