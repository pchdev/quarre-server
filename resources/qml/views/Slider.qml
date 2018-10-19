import QtQuick 2.0
import QtQuick.Controls 2.2
import QtQuick.Controls 1.4 as QC

Item
{
    id: root
    property string label
    property bool integer: false

    signal valueChanged(real v)

    Text
    {
        x: 200
        text: label
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Slider
    {
        id: slider
        from: 0
        to: 1
        onValueChanged: root.valueChanged(slider.value);
    }

    QC.SpinBox
    {
        decimals: 2
        x: 300
        id: spinbox
        value: slider.value
    }

}
