import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls 1.4 as QC

Item
{
    id: root
    property string label
    property bool integer: false
    property alias slider: slider;
    property real min: 0.0
    property real max: 1.0
    property real defaultValue: 0.0

    signal valueChanged(real v)   

    function update(v)
    {
        slider.value    = v;
        spinbox.value   = v;
    }

    Text
    {
        x: 200
        text: label
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Slider
    {
        id:     slider
        from:   root.min
        to:     root.max

        value: defaultValue

        onValueChanged:
        {
            root.valueChanged(slider.value);
            spinbox.value = value;
        }
    }

    QC.SpinBox
    {
        id: spinbox
        decimals: 2
        x: 300

        value: defaultValue

        minimumValue: root.min
        maximumValue: root.max

        onValueChanged: slider.value = value;
    }
}
