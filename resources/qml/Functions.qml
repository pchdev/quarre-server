import QtQuick 2.0

Item
{
    id: root
    Component { id: timerComponent; Timer {} }

    function setTimeout(callback, timeout)
    {
        var timer = timerComponent.createObject(root)
        timer.interval = timeout || 0
        timer.triggered.connect(function()
        {
            timer.destroy()
            callback()
        })

        timer.start()
    }

    function realToTime(value)
    {
        value /= 1000;
        var min = Math.floor(value/60), sec = Math.round(value) % 60;
        var min_str, sec_str;

        if      ( min < 10 )
                min_str = "0" + min.toString();
        else    min_str = min.toString();

        if      ( sec < 10 )
                sec_str = "0" + sec.toString();
        else    sec_str = sec.toString();

        return min_str + ":" + sec_str;
    }

    function randPosition3D()
    {
        return Qt.vector3d(Math.random(), Math.random(), Math.random());
    }

    function processScoreIncrement(score, interaction, next, instrument)
    {
        var idx         = score.index
        var chord       = score.score[idx];
        var next_chord  = score.score[idx+1];

        // send confirmation, and clear remote's display
        interaction.owners.forEach(function(owner) {
            owner.remote.sendMessage("/modules/strings/display", 0, true)
        });

        for ( var i = 0; i < chord['notes'].length; ++i )
        {
            ( function(i) {
                setTimeout( function()
                {
                    instrument.noteOn(0, chord['notes'][i], chord['velocity'][i]);
                },  chord['times'][i]);

                setTimeout( function()
                {
                    instrument.noteOff(0, chord['notes'][i], chord['velocity'][i]);
                },  chord['duration']); })(i);
        }

        // display next chord
        setTimeout( function() {
            next.owners.forEach(function(owner) {
                var value = next_chord["notes"].length;
                owner.remote.sendMessage("/modules/strings/display", value, true)})
        }, chord["duration"])


        score.index++;

    }
}
