.import WPN114 1.0 as WPN114
.import QtQuick 2.0 as QtQuick
.import QtQuick.Controls 2.0 as Controls

var target;

function createComponent(parent, node)
{
    target = parent;

    for ( var i = 0; i < target.items.length; ++i )
        target.items[i].deleteLater()

    if ( node.type !== WPN114.Type.None )
         display(node);
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
                ( target, { "y": target.ypos, "x": target.xpos, "text": node.name } );

        button.clicked.connect(node.setValue)
        target.items.push(button);
    }

    else if ( node.type === WPN114.Type.Bool )
    {
        var toggle = component.createObject
                ( target, { "y": target.ypos, "x": target.xpos, "text": node.name, "checkable": true } );

        toggle.checked = node.value;
        toggle.toggled.connect(node.setValue)
        target.items.push(toggle);
    }

    else if ( node.type === WPN114.Type.Float )
    {
        var slider = component.createObject
                ( target, { "y": target.ypos, "x": target.xpos, "label": node.name })

        slider.valueChanged.connect(node.setValue)
        target.items.push(slider);
    }

    else if ( node.type === WPN114.Type.Int )
    {
        var slider = component.createObject
                ( target, { "y": target.ypos, "x": target.xpos, "label": node.name, "integer": true })

        slider.valueChanged.connect(node.setValue)
        target.items.push(slider);
    }

    target.ypos += 50;
}
