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

        SourceMix { method: "/cendres/ashes" }
        SourceMix { method: "/cendres/birds" }
        SourceMix { method: "/cendres/boiling" }
        SourceMix { method: "/cendres/burn" }
        SourceMix { method: "/cendres/dragon" }
        SourceMix { method: "/cendres/groundwalk" }
        SourceMix { method: "/cendres/background" }
        SourceMix { method: "/cendres/marmots" }
        SourceMix { method: "/cendres/necks" }
        SourceMix { method: "/cendres/quarre" }
        SourceMix { method: "/cendres/redbirds_1" }
        SourceMix { method: "/cendres/redbirds_2" }
        SourceMix { method: "/cendres/thunder" }
        SourceMix { method: "/cendres/waves" }
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
