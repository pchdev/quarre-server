import QtQuick 2.0
import WPN114 1.0 as WPN114
import ".."

Item
{
    id: root

    property list<WPN114.AudioPlugin> instr

    property string path
    property bool running: false
    property int shutdown_after: 3000
    signal next ( );
    signal end  ( );

    WPN114.Node { path: fmt("end"); type: WPN114.Type.Impulse; onValueReceived: root.stop() }
    WPN114.Node { path: fmt("begin"); type: WPN114.Type.Impulse; onValueReceived: root.start() }

    function fmt(str)
    {
        return path+"/"+str;
    }

    function name()
    {
        var name = path.split('/');
        return name[name.length-1];
    }

    function start() // ===================================== START_SCENE
    {
        if ( !audiostream.active )
              audiostream.active = true;

        rooms.active = true;
        net.clients.notifyScene( name() );

        if ( !timer.running ) timer.start();

        scenario.start();
        running = true;

        main_scenario.runningScene = this;
    }

    function stop() // ====================================== STOP_SCENE
    {
        scenario.end();
    }

    function onEnd() // ===================================== ON_SCENE_END
    {
        var main = net.server.get(path);

        // stop all samplers
        var stopnodes = main.collect( "stop" );
        stopnodes.forEach(function(node){
            node.value = 0;
        })

        // set rooms inactive a while later
        functions.setTimeout(function(){
            rooms.active = false;
        }, shutdown_after )

        running = false
        end();
    }

    function reset() // ===================================== RESET_SCENE
    {
        rooms.active = false;
        var dbnodes = net.server.collectNodes("dBlevel");

        dbnodes.forEach(function(node){
            node.value = node.defaultValue;
        });
    }

    property WPN114.Rooms rooms: WPN114.Rooms
    {
        parentStream: audiostream
        exposePath: fmt("audio/rooms")
        setup:  roomsetup
        active: false
    }

    property WPN114.TimeNode scenario
    Component.onCompleted:
    {
        scenario.end.connect(root.onEnd);
    }

}
