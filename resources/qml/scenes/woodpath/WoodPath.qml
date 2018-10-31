import QtQuick 2.0
import WPN114 1.0 as WPN114

Item
{
    id:     root
    signal  end()

    property alias maaaet:      maaaet
    property alias carre:       carre
    property alias pando:       pando
    property alias vare:        vare
    property alias jomon:       jomon
    property alias scenario:    scenario

    Maaaet      { id: maaaet }
    Carre       { id: carre }
    Pando       { id: pando }
    Vare        { id: vare }
    JomonSugi   { id: jomon }

    WPN114.TimeNode
    {
        id: scenario
        source: audio_stream
        duration: -1

        onStart:
        {
            console.log("starting woodpath scenario");
            maaaet.scenario.start();
        }
    }

    Connections // MAAAET TO CARRE
    {
        target: maaaet
        onNext: carre.scenario.start();
    }

    Connections // CARRE TO PANDO
    {
        target: carre
        onNext: pando.scenario.start();
    }

    Connections // PANDO TO VARE
    {
        target: pando
        onEnd:  vare.scenario.start();
    }

    Connections // VARE TO JOMON
    {
        target: vare
        onEnd:  jomon.scenario.start();
    }

    Connections
    {
        target: jomon
        onEnd:  root.end()
    }
}
