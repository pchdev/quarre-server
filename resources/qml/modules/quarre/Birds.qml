import QtQuick 2.0
import "items"

Rectangle
{
    id:         touchbirds_root
    color:      "#232426"
    opacity:    0.8

    property var birds: ["fauvette", "pic-vert", "loriot", "rossignol"]

    SpatializationSphere
    {
        Repeater
        {
            model: birds
            QuarreBird
            {
                name: modelData
                number_id: index
            }
        }
    }
}
