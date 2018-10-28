import QtQuick 2.9
import QtQuick.Controls 2.0
import QtQuick.Window 2.2
import WPN114 1.0 as WPN114
import WPN214 1.0 as WPN214
import "scenes"
import "scenes/stonepath"
import "views"

Rectangle
{
    id: application
    objectName: "quarre-root"

    visible: true
    width: 640
    height: 480

    WPN114.FolderNode //------------------------------------------------------------- NETSERVER
    {
        device: module_server
        recursive: true
        folderPath: "/Users/pchd/Repositories/quarre-server/resources/qml/modules"
        path: "/modules"
        filters: ["*.qml"]
    }

    WPN114.OSCQueryServer
    {
        id: module_server
        name: "quarre-modules"
        tcpPort: 8576
        udpPort: 4132
    }

    WPN114.OSCQueryServer
    {
        id: query_server
        singleDevice: true
        name: "quarre-server"
        tcpPort: 5678
        udpPort: 1234       
    }

    WPN114.Node
    {
        id:     audio_reset
        path:   "/global/audio/reset"
        type:   WPN114.Type.Impulse

        critical: true

        onValueReceived:
        {
            console.log("AUDIO reset");
            introduction.rooms.active = false
            stonepath.cendres.rooms.active = false
            stonepath.diaclases.rooms.active = false
            stonepath.deidarabotchi.rooms.active = false
            stonepath.markhor.rooms.active = false
            stonepath.ammon.rooms.active = false
        }
    }

    WPN114.AudioStream //------------------------------------------------------------- AUDIO
    {
        id:             audio_stream

        outDevice:      "Scarlett 2i2 USB"
        numOutputs:     2

//        outDevice:      "Soundflower (64ch)"
//        numOutputs:     8

        sampleRate:     44100
        blockSize:      512

        Component.onCompleted:
        {
            introduction.rooms.setup         = rooms_setup
            stonepath.cendres.rooms.setup    = rooms_setup
            stonepath.diaclases.rooms.setup  = rooms_setup
            stonepath.deidarabotchi.rooms.setup  = rooms_setup
            stonepath.markhor.rooms.setup    = rooms_setup
            stonepath.ammon.rooms.setup      = rooms_setup
            instruments.rooms.setup          = rooms_setup
            effects.rooms.setup              = rooms_setup

            start();
        }

        WPN114.Node on dBlevel { path: "/global/audio/master/level" }
        WPN114.Node on active { path: "/global/audio/master/active" }
        WPN114.Node on mute { path: "/global/audio/master/muted" }
    }


    WPN114.RoomSetup // octophonic ring setup for quarrè-angoulême
    {
        id: rooms_setup;        
//        WPN114.SpeakerRing { nspeakers: 8; offset: Math.PI/8; influence: 0.55 }
        WPN114.SpeakerPair { xspread: 0.25; y: 0.5; influence: 0.5 }
    }

    ClientManager   { id: client_manager; maxClients: 4 }
    Introduction    { id: introduction }
    //WoodPath        { id: woodpath }
    StonePath       { id: stonepath }

    Instruments     { id: instruments }
    Effects         { id: effects }
    Functions       { id: functions }

    Button
    {
        text: "introduction";
        onPressed:
        {
            introduction.scenario.start()
            audio_stream.tick.connect(logger.update)
        }
    }

    Button { y: 50; text: "stonepath"; onPressed: stonepath.scenario.start() }

    Button
    {
        y: 100;
        text: "cendres";
        onPressed:
        {
            stonepath.cendres.scenario.start()
            audio_stream.tick.connect(logger.update)
        }
    }

    Button
    {
        y: 150;
        text: "diaclases";
        onPressed:
        {
            stonepath.diaclases.scenario.start()
            audio_stream.tick.connect(logger.update)
        }
    }

    Button
    {
        y: 200;
        text: "deidarabotchi";
        onPressed:
        {
            stonepath.deidarabotchi.scenario.start()
            audio_stream.tick.connect(logger.update)
        }
    }


    Button
    {
        y: 250;
        text: "markhor";
        onPressed:
        {
            stonepath.markhor.scenario.start()
            audio_stream.tick.connect(logger.update)
        }
    }

    Button
    {
        y: 300
        text: "ammon"
        onPressed:
        {
            stonepath.ammon.scenario.start()
            audio_stream.tick.connect(logger.update)
        }
    }

    Item
    {
        id: logger
        property int count;
        property string countstr;

        onCountstrChanged: console.log(countstr);

        function update(tick)
        {
            count += tick;
            countstr = functions.realToTime(count);
        }

    }

    Connections
    {
        target: introduction
        onEnd:
        {
            if ( introduction.xroads_result === 0 );
            else stonepath.scenario.start();
        }
    }

    Connections
    {
        target: stonepath
        onEnd: ; // wpn214 start & then loop
    }

}
