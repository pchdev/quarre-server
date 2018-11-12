import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.11
import WPN114 1.0 as WPN114
import "views/NodeView.js" as NodeView
import "views"

Item
{
    id: root

    anchors.fill: parent

    property int ypos: 0
    property int xpos: tree.width+20
    property alias tree: tree
    property alias vumeters: vumeters
    property alias timer: timer_label
    property alias scene_view: sceneview
    property var target

    function impulse  ( )  { target.value = 0 }
    function toggle   ( )  { target.value = loader.item.checked }
    function slider   ( )  { target.value = loader.item.value }
    function text     ( )  { target.value = loader.item.text; loader.item.text = "" }

    Rectangle // ------------------------------------------------------------------- MASTER_VIEW
    {
        id: masterview
        height: parent.height
        width: parent.width - tree.width
        x: tree.width

        visible: true

        MultiVUMeter
        {
            id: vumeters
            nchannels: audio_stream.numOutputs
            anchors.centerIn: parent
            height: 150
        }

        Text
        {
            id: timer_label
            anchors.horizontalCenter: parent.horizontalCenter
            text: "00:00"
            font.pointSize: 40
            y: parent.height * 0.75
        }
    }

    RoomsView // --------------------------------------------------------------- ROOMS_VIEW
    {
        id: sceneview
        color: "black"
        visible: false

        setup:   rooms_setup
        target:  scenario.woodpath.maaaet.rooms

        width: parent.width - tree.width
        height: width

        x: tree.width
        y: tabbar.height

    }

    SceneMixView //------------------------------------------------------------- MIX_VIEW
    {
        id: mixview
        visible: false
        path: "/introduction"

        width: parent.width - tree.width
        height: parent.height
        x: tree.width
        y: tabbar.height
    }

    Rectangle // --------------------------------------------------------------- FOOTER
    {
        id:         footer_rect
        x:          tree.width
        y:          sceneview.height + tabbar.height
        width:      sceneview.width
        height:     root.height - sceneview.height - tabbar.height
        color:      "dimgrey"

        Loader { id: loader } // <------ FOR INDIVIDUAL NODE CONTROL
    }

    TabBar // ----------------------------------------------------------------- TABS
    {
        id: tabbar
        width: parent.width - tree.width
        x: tree.width

        TabButton
        {
            text: "Main"
            onPressed:
            {
                masterview.visible = true;
                sceneview.visible = false;
            }
        }

        TabButton
        {
            text: "SceneSpace"
            onPressed:
            {
                masterview.visible = false;
                sceneview.visible = true;
            }
        }

        TabButton
        {
            text: "SceneMix"
            onPressed:
            {

            }
        }
    }

    TreeView //---------------------------------------------------------------------- TREE_VIEW
    {
        id: tree
        height: parent.height
        width: parent.width*0.4

        TableViewColumn
        {
            title: "name"
            role: "NodeName"
            width: 200
        }

        TableViewColumn
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
                loader.item.valueChanged.connect(node.setValue);

                if ( node.name === "dBlevel" )
                {
                    loader.item.slider.from = -96
                    loader.item.slider.to = 12;
                }
            }

            else if ( node.type === WPN114.Type.Int )
            {
                // TODO
            }

            else if ( node.type === WPN114.Type.String )
            {
                loader.source = "views/TextField.qml";
                loader.item.onAccepted.connect(root.text);
            }
        }
    }

}
