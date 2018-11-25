import QtQuick 2.0
import WPN114 1.0 as WPN114
import "items"

Rectangle
{
    id:         touchbirds_root
    color:      "#232426"
    opacity:    0.8

    WPN114.Node
    {
        id:     birds_node
        path:   "/modules/birds/trigger"
        type:   WPN114.Type.Vec4f
        value:  Qt.vector4d(0, 0, 0, 0)
    }

    property var birds: ["fauvette", "pic-vert", "loriot", "rossignol"]

    SpatializationSphere
    {
        Repeater
        {
            model: birds
            QuarreBird { name: modelData; number_id: index }
        }
    }
}
