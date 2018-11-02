import QtQuick 2.0
import QtQuick.Controls 2.4

import "../items"

Item
{
    id: root

    SwipeView
    {
        id: view

        anchors.fill: parent
        currentIndex: 0

        SourceMix { method: "/introduction/digibirds" }
        SourceMix { method: "/introduction/dragon-hi" }
        SourceMix { method: "/introduction/dragon-lo" }
        SourceMix { method: "/introduction/river" }
        SourceMix { method: "/introduction/spring" }
        SourceMix { method: "/introduction/swarms" }
        SourceMix { method: "/introduction/synth" }
        SourceMix { method: "/introduction/verb" }
        SourceMix { method: "/introduction/walking-1" }
        SourceMix { method: "/introduction/walking-2" }
    }

    PageIndicator
    {
        id:         indicator
        count:      view.count

        currentIndex:   view.currentIndex
        anchors.bottom: view.bottom

        anchors.horizontalCenter: parent.horizontalCenter
    }
}
