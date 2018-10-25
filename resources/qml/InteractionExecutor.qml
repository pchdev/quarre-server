import QtQuick 2.0
import WPN114 1.0 as WPN114

WPN114.TimeNode
{
    id: root

    property Interaction target
    property var startExpression
    property var endExpression

    duration:   sec(target.countdown+target.length)
    onStart:    target.notify();
    onEnd:      target.end();

    WPN114.TimeNode
    {
        date:    sec(target.countdown)
        onStart: target.begin();
    }

    Component.onCompleted:
    {
        if ( startExpression !== undefined )
             startExpression.connect(root.start)

        if ( endExpression !== undefined )
             endExpression.connect(root.end)
    }
}
