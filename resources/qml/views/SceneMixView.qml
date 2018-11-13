import QtQuick 2.0
import QtQuick.Controls 2.4

ScrollView
{
    id: root
    property var items: [ ]
    property int ypos: 30

    Rectangle
    {
        id: rect
        anchors.fill: parent

    }

    ScrollBar.vertical.policy: ScrollBar.AlwaysOn

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

    function display(path)
    {
        if ( path ===  "") return;

        root.clear();
        var node = net.server.get(path).subnode("audio");

        for ( var i = 0; i < node.nsubnodes(); ++i )
        {
            var subnode = node.subnodeAt(i);
            var dblevel_n = subnode.subnode("stream/dBlevel");

            var component = Qt.createComponent("items/Slider.qml");
            var slider = component.createObject(rect, { "y": ypos })

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
