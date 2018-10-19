.import WPN114 1.0 as WPN114
.import QtQuick 2.0 as QtQuick
.import QtQuick.Controls 2.0 as Controls

function createComponent(parent, node)
{
    explore(node);
}

function explore(node)
{
    for ( var n = 0; n < node.nsubnodes(); ++n )
    {
        var sub = node.subnodeAt(n);

        if ( sub.type === WPN114.Type.None ) explore(sub)
        else display(sub);
    }
}

function display(node)
{
    var obj, component;

    if      ( node.type === WPN114.Type.Impulse )  obj = "Button.qml";
    else if ( node.type === WPN114.Type.Float )    obj = "Slider.qml";
    else if ( node.type === WPN114.Type.Int )      obj = "Slider.qml";
    else if ( node.type === WPN114.Type.Bool )     obj = "Button.qml";

    component = Qt.createComponent(obj);

    if ( component.status === QtQuick.Component.Ready )
        finishCreation(component, node);

    else component.statusChanged.connect(finishCreation)
}


function finishCreation(component, node)
{

    if ( node.type === WPN114.Type.Impulse )
    {
        var button = component.createObject
                ( root, { "y": ypos, "text": node.name } );

        button.pressed.connect(node.setValue)
    }

    else if ( node.type === WPN114.Type.Bool )
    {
        var toggle = component.createObject
                ( root, { "y": ypos, "text": node.name, "checkable": true } );

        toggle.toggled.connect(node.setValue)
    }

    else if ( node.type === WPN114.Type.Float )
    {
        var slider = component.createObject
                ( root, { "y": ypos, "label": node.name })

        slider.valueChanged.connect(node.setValue)
    }

    else if ( node.type === WPN114.Type.Int )
    {
        var slider = component.createObject
                ( root, { "y": ypos, "label": node.name, "integer": true })

        slider.valueChanged.connect(node.setValue)
    }

    ypos += 50;
}
