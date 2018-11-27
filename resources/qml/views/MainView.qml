import QtQuick 2.0
import QtQuick.Controls 2.4
import QtQuick.Controls 1.4 as QQC14
import QtQuick.Layouts 1.11
import WPN114 1.0 as WPN114

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

        FontLoader
        {
            id: font_lato_light
            source: "file:///Users/pchd/Repositories/quarre2/resources/fonts/Lato-Light.ttf"
        }

        Image //----------------------------------------------------------------- GUI
        {
            // note that having low & high-dpi separate files would be a good idea
            id: quarre_background
            antialiasing: true
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            source: "file:///Users/pchd/Repositories/quarre-server/resources/images/quarre.jpg"

            Rectangle
            {
                anchors.fill: parent
                color: "black"
                opacity: 0.6

                Rectangle
                {
                    anchors.fill: parent
                    radius: width/2
                    color: "black"
                    opacity: 0.7
                }
            }
        }

        Text
        {
            id: scene_label
            anchors.horizontalCenter: parent.horizontalCenter
            text: "quarrè"
            font.pointSize: 40
            y: parent.height * 0.15
            color: "white"
            font.family: font_lato_light.name
        }

        Connections
        {
            target: main_scenario
            onRunningSceneChanged:
                scene_label.text = main_scenario.runningScene.name();

        }

        MultiVUMeter
        {
            id: vumeters
            nchannels: vu_master.numOutputs
            anchors.centerIn: parent
            height: 150
        }

        Slider
        {
            orientation: Qt.Vertical
            anchors.left: vumeters.right
            anchors.verticalCenter: parent.verticalCenter
            from: -96; to: -33
            value: audiostream.dBlevel

            onValueChanged: audiostream.dBlevel = value;
        }

        Text
        {
            id: timer_label
            anchors.horizontalCenter: parent.horizontalCenter
            text: "00:00"
            font.pointSize: 40
            y: parent.height * 0.7
            color: "white"
            font.family: font_lato_light.name
        }

        Component.onCompleted:
        {
            functions.setTimeout(function(){
                vumeters.reset();
            }, 125 )
        }
    }

    RoomsView // --------------------------------------------------------------- ROOMS_VIEW
    {
        id: sceneview
        color: "black"
        visible: false

        setup:   roomsetup
        width: parent.width - tree.width
        height: width

        x: tree.width
        y: tabbar.height

        Component.onCompleted: sceneview.drawSetup();

    }

    SceneMixView //------------------------------------------------------------- MIX_VIEW
    {
        id: mixview
        visible: false

        x: tree.width
        y: tabbar.height
        width: parent.width - tree.width
        height: parent.height - footer_rect.height - tabbar.height

        property string path
        WPN114.Node on path { path: "/views/mix/display" }

        onPathChanged:
        {
            mixview.display(path);
            sceneview.drawScene(path);
        }

        Connections
        {
            target: main_scenario
            onRunningSceneChanged:
            {
                mixview.display( main_scenario.runningScene.path );
                sceneview.drawScene( main_scenario.runningScene.path );
            }
        }
    }

    Rectangle // --------------------------------------------------------------- FOOTER
    {
        id:         footer_rect
        x:          tree.width
        y:          sceneview.height + tabbar.height
        width:      sceneview.width
        height:     root.height - sceneview.height - tabbar.height
        color:      "black"
        opacity:    0.6

        Loader
        {
            id: loader
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
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
                mixview.visible = false;
            }
        }

        TabButton
        {
            text: "SceneSpace"
            onPressed:
            {
                masterview.visible = false;
                sceneview.visible = true;
                mixview.visible = false;
            }
        }

        TabButton
        {
            text: "SceneMix"
            onPressed:
            {
                masterview.visible = false;
                sceneview.visible = false;
                mixview.visible = true;
            }
        }
    }

    QQC14.TreeView //---------------------------------------------------------------------- TREE_VIEW
    {
        id: tree
        height: parent.height
        width: parent.width*0.4

        QQC14.TableViewColumn
        {
            title: "name"
            role: "NodeName"
            width: 200
        }

        QQC14.TableViewColumn
        {
            title: "value"
            role: "NodeValue"
            width: 100
        }

        onDoubleClicked:
        {
            var node = net.server.nodeTree().get(index);
            root.target = node;

            if ( node.type === WPN114.Type.Impulse )
            {
                loader.source = "items/Button.qml";
                loader.item.text = node.name;
                loader.item.checkable = false;
                loader.item.checked = false;

                loader.item.clicked.connect(root.impulse);
            }

            else if ( node.type === WPN114.Type.Bool )
            {
                loader.source = "items/Button.qml";
                loader.item.text = node.name;
                loader.item.checkable = true;
                loader.item.checked = node.value;

                loader.item.clicked.connect(root.toggle);
            }

            else if ( node.type === WPN114.Type.Float )
            {
                loader.source = "items/Slider.qml";
                loader.item.label = node.name;
                loader.item.valueChanged.connect(node.setValue);                
                loader.item.defaultValue = node.value;

                if ( node.name === "dBlevel" )
                {
                    loader.item.min = -96
                    loader.item.max = 12;
                }
            }

            else if ( node.type === WPN114.Type.Int )
            {
                // TODO
            }

            else if ( node.type === WPN114.Type.String )
            {
                loader.source = "items/TextField.qml";
                loader.item.onAccepted.connect(root.text);
            }
        }
    }

}
