import QtQuick 2.0
import WPN114 1.0 as WPN114

Item
{
    property int nchannels: 2
    width: nchannels*25-nchannels

    function processPeak(v)
    {
        for ( var i = 0; i < v.length; ++i )
              repeater.itemAt(i).peak = v[i];
    }

    function processRms(v)
    {
        for ( var i = 0; i < v.length; ++i )
              repeater.itemAt(i).rms = v[i];
    }

    Repeater
    {
        id: repeater
        anchors.fill: parent
        model: nchannels

        WPN114.VUMeter
        {
            anchors.verticalCenter: parent.verticalCenter
            x: index*width-index
            color: "transparent"

            height: 150
            width: 25
        }
    }
}
