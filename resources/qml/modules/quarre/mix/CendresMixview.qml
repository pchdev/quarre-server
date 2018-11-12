import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Controls 1.4 as QC14
import WPN114 1.0 as WPN114

import "../items"

Item
{
    property WPN114.Node currentNode;
    property int currentIndex: 0

    property var scenes:
    [
      "/introduction", "/cendres", "/diaclases", "/deidarabotchi", "/markhor", "/ammon",
      "/maaaet", "/carre", "/pando", "/vare", "/jomon", "/wpn214"
    ]

    id: root
    anchors.fill: parent

    WPN114.OSCQueryClient
    {
        id: client
        zeroConfHost: "quarre-server"

        onConnected:
        {


        }
    }

    function next()
    {

    }

    function previous()
    {

    }

    QC14.TabView
    {
        anchors.fill: parent

        QC14.Tab
        {
            title: "Mix"

            Text
            {

            }

            Button
            {
                text: "play"
                checkable: true
            }
        }
    }


}
