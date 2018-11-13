import QtQuick 2.0

Rectangle
{
    id: root
    property string path
    property var items: [ ]
    property int ypos: 30

    function clear()
    {
        for ( var i = 0; i < items.length; ++i )
        {
            var item = items[i];
            item.destroy();
        }

        items.length = 0;
        root.ypos = 30;
    }

    function display()
    {
        root.clear();
        var node = net.server.get(path).subnode("audio");

        for ( var i = 0; i < node.nsubnodes(); ++i )
        {
            var subnode = node.subnodeAt(i);
            var dblevel_n = subnode.subnode("stream/dBlevel");

            var component = Qt.createComponent("Slider.qml");
            var slider = component.createObject(root, { "y": ypos })

            slider.label = subnode.name;
            slider.min = -96;
            slider.max = 12;
            slider.defaultValue = dblevel_n.value;
            slider.valueChanged.connect(dblevel_n.setValue);
            dblevel_n.valueChanged.connect(slider.update);

            ypos += 30;
            items.push( slider );
        }
    }
}
