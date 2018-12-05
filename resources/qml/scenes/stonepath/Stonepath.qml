import QtQuick 2.0
import WPN114 1.0 as WPN114
import ".."

Scene
{
    id: root

    notify: false
    audio: false

    property alias cendres: cendres
    property alias diaclases: diaclases
    property alias deidarabotchi: deidarabotchi
    property alias markhor: markhor
    property alias ammon: ammon    

    Cendres         { id: cendres; path: root.fmt("cendres")}
    Diaclases       { id: diaclases; path: root.fmt("diaclases")}
    Deidarabotchi   { id: deidarabotchi; path: root.fmt("deidarabotchi")}
    Markhor         { id: markhor; path: root.fmt("markhor")}
    Ammon           { id: ammon; path: root.fmt("ammon")}

    scenario: WPN114.TimeNode
    {
        source: audiostream
        parentNode: parent.scenario
        duration: WPN114.TimeNode.Infinite
        onStart: cendres.start()
    }

    Connections //---------------------------------------------------------- SCENARIO_CONNECTIONS
    {
        target: cendres
        onNext: diaclases.start();
    }

    Connections
    {
        target: diaclases
        onNext: deidarabotchi.start();
    }

    Connections
    {
        target: deidarabotchi
        onEnd:  markhor.start();
    }

    Connections
    {
        target: markhor
        onEnd:  ammon.start();
    }

    Connections
    {
        target: ammon
        onEnd:  root.end()
    }
}
