import QtQuick 2.0
import QtQuick.Controls 1.4 as QC14
import WPN114 1.0 as WPN114
import "views/NodeView.js" as NodeView

Item
{
    id: root

    anchors.fill: parent

    property int ypos: 0
    property int xpos: tree.width+20
    property alias tree: tree
    property var items: [ ]
    property var target

    Loader
    {
        id: loader
        x: root.xpos
        y: root.ypos

    }

    function impulse() { target.value = 0 }
    function toggle()  { target.value = loader.item.checked }
    function slider()  { target.value = loader.item.value }

    QC14.TreeView
    {
        id: tree
        height: parent.height
        width: parent.width*0.4

        QC14.TableViewColumn
        {
            title: "name"
            role: "NodeName"
            width: 200
        }

        QC14.TableViewColumn
        {
            title: "value"
            role: "NodeValue"
            width: 100
        }

        onDoubleClicked:
        {
            var node = query_server.nodeTree().get(index);
            root.target = node;

            if ( node.type === WPN114.Type.Impulse )
            {
                loader.source = "views/Button.qml";
                loader.item.text = node.name;
                loader.item.checkable = false;
                loader.item.checked = false;
                loader.item.clicked.connect(root.impulse);
            }

            else if ( node.type === WPN114.Type.Bool )
            {
                loader.source = "views/Button.qml";
                loader.item.text = node.name;
                loader.item.checkable = true;
                loader.item.checked = node.value;

                loader.item.clicked.connect(root.toggle);
            }

            else if ( node.type === WPN114.Type.Float )
            {
                loader.source = "views/Slider.qml";
                loader.item.label = node.name;
//                loader.item.width = 300
//                loader.item.height = 25
                loader.item.valueChanged.connect(node.setValue);
            }
        }
    }

}
