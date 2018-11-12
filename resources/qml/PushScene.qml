import QtQuick 2.0
import WPN114 1.0 as WPN114
import WPNPush 1.0 as Push

Item
{
    property int pcolor: 0
    property int index: 0
    property var scene

    Component.onCompleted:
    {
        notifyEnd();
    }

    function play()
    {
        scene.scenario.start();
        notifyStart();
    }

    function notifyStart()
    {
        push.lightPad(index, Push.PadColor.BLACK, Push.PadLightingMode.PULSE_2);
    }

    function notifyEnd()
    {
        push.lightPad( index, pcolor, Push.PadLightingMode.OFF )
    }

}
