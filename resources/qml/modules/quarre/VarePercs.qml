import QtQuick 2.0
import "items"
import "../basics/items"
import WPN114 1.0 as WPN114

Rectangle
{
    property int num_pads: 12
    property var pads_status: new Array(num_pads);
    property var pushed_pads: []

    id: pads_manager
    color: "transparent"


    WPN114.Node
    {
        id:     pads_node
        path:   "/modules/vare/pads/index"
        type:   WPN114.Type.Int
        value:  0
    }

    function pressed(i,b)
    {
        console.log(i, b);
        pads_status[i] = b;

        if ( b )
        {
            for ( var j = 0; j < pushed_pads.length; ++j )
                pad_repeater.itemAt(pushed_pads[j]).release();

            pushed_pads.push(i);
            pads_node.value = i+1;
            pad_repeater.itemAt(i).push();
        }

        else
        {
            // remove pad from array
            for ( var k = 0; k < pushed_pads.length; ++k )
                if ( i === pushed_pads[k] )
                    pushed_pads.splice(k,1);

            // release pad in gui
            pad_repeater.itemAt(i).release();

            // light the last pressed pad if any
            if ( pushed_pads.length > 0 )
            {
                pad_repeater.itemAt(pushed_pads[pushed_pads.length-1]).push();
                pads_node.value = pushed_pads[pushed_pads.length-1]+1;
            }

            else pads_node.value = 0;
        }
    }

    Grid
    {
        columns: 4
        rows: 3
        spacing: 20
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        Repeater
        {
            id: pad_repeater
            model: num_pads

            QuarrePad
            {
                id:         target
                width:      pads_manager.width/6
                height:     pads_manager.width/6
                pad_index:  index

                onPressedChanged:
                    pads_manager.pressed(pad_index, pressed)
            }
        }
    }
}
