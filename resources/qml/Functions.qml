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
}
