import QtQuick 2.0
import WPN114 1.0 as WPN114

Rectangle
{
    id: frame
    anchors.fill: parent
    color: "transparent"

    WPN114.Node
    {
        id:     selection
        path:   "/modules/crossroads/selection"
        type:   WPN114.Type.Int
        value:  0
    }

    Rectangle
    {
        id: tree_rect
        property bool selected: false

        x:          parent.width*0.2
        y:          parent.height*0.1
        width:      parent.width*0.25
        height:     parent.height*0.4

        color: "#282a2d"
        border.width: 10
        border.color: "black"
        opacity: 0.7

        onSelectedChanged:
        {
            if ( selected )
            {
                color = "darkgray";
                mountain_rect.selected = false;
                selection.value = 1;
            }
            else
            {
                color = "#282a2d"
                if ( !mountain_rect.selected )
                    selection.value = 0;
            }
        }

        Image
        {
            id: tree
            antialiasing: true
            anchors.fill: parent
            fillMode: Image.PreserveAspectFit
            source: "qrc:/modules/tree.png"

            transform: Scale
            {
                origin.x : tree_rect.width/2
                origin.y: tree_rect.height/2
                xScale: 0.7
                yScale: 0.7
            }
        }

        MouseArea
        {
            anchors.fill: parent
            onClicked: parent.selected = !parent.selected;
        }
    }

    Text //--------------------------------------------------------------------- WOOD_LABEL
    {
        text:       "bois"
        color:      "#ffffff"

        width:      tree_rect.width
        x:          tree_rect.x
        y:          parent.height * 0.55

        horizontalAlignment:    Text.AlignHCenter
        verticalAlignment:      Text.AlignVCenter
        textFormat:             Text.PlainText
        font.pointSize:         16 * root.fontRatio
        font.family:            font_lato_light.name
    }

    Rectangle
    {
        id: mountain_rect
        property bool selected: false

        x:          parent.width*0.55
        y:          parent.height*0.1
        width:      parent.width*0.25
        height:     parent.height*0.4

        color: "#282a2d"
        border.width: 10
        border.color: "black"
        opacity: 0.7

        onSelectedChanged:
        {
            if ( selected )
            {
                color = "darkgray";
                tree_rect.selected = false;
                selection.value = 2;
            }
            else
            {
                color = "#282a2d"
                if ( !tree_rect.selected ) selection.value = 0;
            }
        }

        Image
        {
            id: mountain
            antialiasing: true
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            source: "qrc:/modules/mountain.png"

            transform: Scale
            {
                origin.x : mountain_rect.width/2
                origin.y: mountain_rect.height/2
                xScale: 0.7
                yScale: 0.7
            }
        }

        MouseArea
        {
            anchors.fill: parent
            onClicked: parent.selected = !parent.selected;
        }
    }

    Text //--------------------------------------------------------------------- STONE_LABEL
    {
        text:       "pierre"
        color:      "#ffffff"

        width:      mountain_rect.width
        x:          mountain_rect.x
        y:          parent.height * 0.55

        horizontalAlignment:    Text.AlignHCenter
        verticalAlignment:      Text.AlignVCenter
        textFormat:             Text.PlainText
        font.pointSize:         16 * root.fontRatio
        font.family:            font_lato_light.name
    }


}
