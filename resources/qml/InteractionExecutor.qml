import QtQuick 2.0
import WPN114 1.0 as WPN114

WPN114.TimeNode
{
    id: root

    property Interaction target

    duration:   sec(target.countdown+target.length)
    onStart:    target.notify();
    onEnd:      target.end();

    WPN114.TimeNode
    {
        source:  root.source
        date:    sec(target.countdown)
        onStart: target.begin();
    }
}
