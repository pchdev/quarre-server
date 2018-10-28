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
}
