import QtQuick 2.0
import WPN114 1.0 as WPN114

WPN114.TimeNode
{
    id: root

    signal begin();
    property Interaction target
    property int countdown
    property int length

    duration:   length === -1 ? -1 : root.countdown+root.length
    onStart:    target.notify(countdown/1000, length === -1 ? -1 : length/1000);
    onEnd:      target.end();

    WPN114.TimeNode
    {
        source:   root.source
        date:     root.countdown
        onStart:
        {
            target.begin();
            root.begin();
        }
    }
}
