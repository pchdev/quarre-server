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

        SourceMix { method: "/introduction/audio/digibirds" }
        SourceMix { method: "/introduction/audio/dragon-hi" }
        SourceMix { method: "/introduction/audio/dragon-lo" }
        SourceMix { method: "/introduction/audio/river" }
        SourceMix { method: "/introduction/audio/spring" }
        SourceMix { method: "/introduction/audio/swarms" }
        SourceMix { method: "/introduction/audio/synth" }
        SourceMix { method: "/introduction/audio/verb" }
        SourceMix { method: "/introduction/audio/walking-1" }
        SourceMix { method: "/introduction/audio/walking-2" }
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
