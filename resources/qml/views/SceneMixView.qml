import QtQuick 2.0

Rectangle
{
    property var path
    property var items: [ ]

    onPathChanged:
    {
        var node = query_server.get(path).subnode("audio");

    }

}
