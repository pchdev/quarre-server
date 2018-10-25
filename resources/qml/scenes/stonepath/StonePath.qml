import QtQuick 2.0
import WPN114 1.0 as WPN114

Item
{
    id: root

    property alias cendres: cendres
    property alias diaclases: diaclases
    property alias deidarabotchi: deidarabotchi
    property alias markhor: markhor
    property alias ammon: ammon    
    property alias scenario: scenario

    signal end()

    WPN114.TimeNode
    {
        id: scenario
        source: audio_stream
        duration: -1

        onStart:
        {
            console.log("starting stonepath scenario");
            cendres.scenario.start();
        }
    }

    Connections
    {
        target: cendres
        onNext: diaclases.scenario.start();
    }

    Connections
    {
        target: diaclases
        onNext: deidarabotchi.scenario.start();
    }

    Connections
    {
        target: deidarabotchi
        onEnd:  markhor.scenario.start();
    }

    Connections
    {
        target: markhor
        onEnd:  ammon.scenario.start();
    }

    Connections
    {
        target: ammon
        onEnd:  root.end()
    }

    Cendres         { id: cendres }
    Diaclases       { id: diaclases }
    Deidarabotchi   { id: deidarabotchi }
    Markhor         { id: markhor }
    Ammon           { id: ammon }
}
