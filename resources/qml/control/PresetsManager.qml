import QtQuick 2.0
import WPN114 1.0 as WPN114

Item
{
    WPN114.Node //----------------------------------------------------------------------- PRESETS
    {
        path: "/presets/save"
        type: WPN114.Type.String

        onValueReceived:
        {
            var nodes = net.server.collectNodes("dBlevel")
            nodes.forEach(function(node) {
                node.defaultValue = node.value;
            });

            net.server.savePreset(newValue, [ "dBlevel" ], [ "DEFAULT_VALUE" ])
        }
    }

    WPN114.Node
    {
        path: "/presets/load"
        type: WPN114.Type.String
        onValueReceived:
        {
            net.server.loadPreset(newValue);

            var nodes = net.server.collectNodes("dBlevel")
            nodes.forEach(function(node) {
                node.value = node.defaultValue;
            });
        }
    }

}
