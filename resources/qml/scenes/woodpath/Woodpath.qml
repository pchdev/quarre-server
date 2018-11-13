import QtQuick 2.0
import WPN114 1.0 as WPN114

import ".."

Scene
{
    id: root
    property alias maaaet:      maaaet
    property alias carre:       carre
    property alias pando:       pando
    property alias vare:        vare
    property alias jomon:       jomon

    Maaaet      { id: maaaet; path: root.fmt("maaaet") }
    Carre       { id: carre; path: root.fmt("carre") }
    Pando       { id: pando; path: root.fmt("pando") }
    Vare        { id: vare; path: root.fmt("vare") }
    Jomon       { id: jomon; path: root.fmt("jomon") }

    scenario: WPN114.TimeNode
    {
        source:        audiostream
        parentNode:  parent.scenario
        duration:   WPN114.TimeNode.Infinite
        onStart:    maaaet.start();
    }

    Connections // MAAAET TO CARRE
    {
        target: maaaet
        onNext: carre.start();
    }

    Connections // CARRE TO PANDO
    {
        target: carre
        onNext: pando.start();
    }

    Connections // PANDO TO VARE
    {
        target: pando
        onEnd:  vare.start();
    }

    Connections // VARE TO JOMON
    {
        target: vare
        onNext: jomon.start();
    }

    Connections // JOMON TO WOODPATH END
    {
        target: jomon
        onEnd:  end();
    }
}
