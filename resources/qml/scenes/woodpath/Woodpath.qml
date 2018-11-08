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

    function reset()
    {
        maaaet.rooms.active   = false
        carre.rooms.active    = false
        pando.rooms.active    = false
        vare.rooms.active     = false
        jomon.rooms.active    = false
    }

    function initialize(setup)
    {
        maaaet.rooms.setup      = setup
        carre.rooms.setup       = setup
        pando.rooms.setup       = setup
        vare.rooms.setup        = setup
        jomon.rooms.setup       = setup
    }

    WPN114.TimeNode
    {
        id:     scenario
        source: audio_stream

        onStart:
        {
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
        onNext: jomon.scenario.start();
    }

    Connections // JOMON TO WOODPATH END
    {
        target: jomon
        onEnd:  root.end()
    }
}
