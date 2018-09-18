import QtQuick 2.0
import Ossia 1.0 as Ossia

Item
{
    property bool gestures_blow_trigger:            false
    property bool gestures_hammer_trigger:          false
    property bool gestures_palm_trigger:            false
    property bool gestures_shake_trigger:           false
    property vector3d touch_birds_trigger:          Qt.vector3d(0, 0, 0)
    property bool touch_trajectories_trigger:       false
    property vector2d touch_trajectories_position:  Qt.vector2d(0, 0)
    property real sensors_rotation_x_angle:         0.0
    property real sensors_rotation_y_angle:         0.0
    property real sensors_rotation_z_angle:         0.0
    property vector3d sensors_rotation_xyz_data:    Qt.vector3d(0, 0, 0)
    property vector3d sensors_accelerometers_xyz_data:    Qt.vector3d(0, 0, 0)
    property vector2d touch_xy_points:              Qt.vector2d(0, 0)
    property bool sensors_proximity_close:          false
    property int vote_choice: 0

    Ossia.Binding //-------------------------------------------------------- VOTE_CHOICE
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter("/modules/vote/choice")
        on:         vote_choice
    }

    Ossia.Binding //-------------------------------------------------------- BLOW_GESTURE
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter("/modules/gestures/blow/trigger")
        on:         gestures_blow_trigger
    }

    Ossia.Binding //-------------------------------------------------------- HAMMER_GESTURE
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/gestures/hammer/trigger')
        on:         gestures_hammer_trigger
    }

    Ossia.Binding //-------------------------------------------------------- PALM_GESTURE
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/gestures/palm/trigger')
        on:         gestures_palm_trigger
    }

    Ossia.Binding //-------------------------------------------------------- SHAKE_GESTURE
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/gestures/shake/trigger')
        on:         gestures_shake_trigger
    }

    Ossia.Binding //-------------------------------------------------------- BIRDS_TRIGGER
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/birds/trigger')
        on:         touch_birds_trigger
    }

    Ossia.Binding //-------------------------------------------------------- TRAJECTORIES
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/trajectories/trigger')
        on:         touch_trajectories_trigger
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/trajectories/position')
        on:         touch_trajectories_position
    }

    Ossia.Binding //-------------------------------------------------------- ROTATION_X
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter("/modules/sensors/rotation/x/angle")
        on:         sensors_rotation_x_angle
    }

    Ossia.Binding //-------------------------------------------------------- ROTATION_Y
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter("/modules/sensors/rotation/y/angle")
        on:         sensors_rotation_y_angle
    }

    Ossia.Binding //-------------------------------------------------------- ROTATION_Z
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter("/modules/sensors/rotation/z/angle")
        on:         sensors_rotation_z_angle
    }

    Ossia.Binding //-------------------------------------------------------- ROTATION_XYZ
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter("/modules/sensors/rotation/xyz/data")
        on:         sensors_rotation_xyz_data
    }

    Ossia.Binding //-------------------------------------------------------- ACCEL_XYZ
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter("/modules/sensors/accelerometers/xyz/data")
        on:         sensors_accelerometers_xyz_data
    }

    Ossia.Binding //-------------------------------------------------------- TOUCH_XY
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/xytouch/trigger')
        on:         touch_xy_points
    }

    Ossia.Binding //-------------------------------------------------------- PROXIMITY
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/sensors/proximity/close')
        on:         sensors_proximity_close
    }

    property real vare_resonator_inpos: 0.0
    property real vare_resonator_pitch_p: -2

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/vare/resonator/inpos')
        on:         vare_resonator_inpos
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/vare/resonator/pitch_p')
        on:         vare_resonator_pitch_p
    }

    property real vare_body_tone: 0.36
    property real vare_body_pitch: -1.0
    property vector2d vare_body_xy: Qt.vector2d(0.5, 0.5)
    property real vare_body_sustain: 1.0

    Ossia.Binding //-------------------------------------------------------- VARE_BODY
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/vare/body/tone')
        on:         vare_body_tone
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/vare/body/pitch')
        on:         vare_body_pitch
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/vare/body/xy')
        on:         vare_body_xy
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/vare/body/sustain')
        on:         vare_body_sustain
    }

    property real vare_granular_pitch: 3.0
    property real vare_granular_overlap: 1.0
    property real vare_granular_x: 0.25
    property real vare_granular_x_p: 1.0
    property real vare_granular_rate: 27.5

    Ossia.Binding //-------------------------------------------------------- VARE_GRANULAR
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/vare/granular/x')
        on:         vare_granular_x
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/vare/granular/x_p')
        on:         vare_granular_x_p
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/vare/granular/pitch')
        on:         vare_granular_pitch
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/vare/granular/overlap')
        on:         vare_granular_overlap
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/vare/granular/rate')
        on:         vare_granular_rate
    }

    property real vare_gate_decay: 0.52
    property real vare_env_decay: 0.05
    property real vare_gate_leak: 0.0
    property real vare_noise_rate: 2.62
    property real vare_sequencer_width: 100
    property real vare_seq_rate: 0.571

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/vare/seq/rate')
        on:         vare_seq_rate
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/vare/gate/decay')
        on:         vare_gate_decay
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/vare/env/decay')
        on:         vare_env_decay
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/vare/gate/leak')
        on:         vare_gate_leak
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/vare/noise/rate')
        on:         vare_noise_rate
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/vare/sequencer/width')
        on:         vare_sequencer_width
    }

    property real markhor_resonator_brightness: 0.0
    property real markhor_resonator_inpos: 1.0
    property real markhor_resonator_pitch: 2.0
    property real markhor_resonator_sustain: 0.30

    Ossia.Binding //-------------------------------------------------------- MARKHOR_RESONATOR
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/markhor/resonator/brightness')
        on:         markhor_resonator_brightness
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/markhor/resonator/inpos')
        on:         markhor_resonator_inpos
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/markhor/resonator/pitch_p')
        on:         markhor_resonator_pitch
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/markhor/resonator/sustain')
        on:         markhor_resonator_sustain
    }

    property real markhor_body_tone: 1.0
    property real markhor_body_pitch: -1.0
    property vector2d markhor_body_xy: Qt.vector2d(0.5, 1.0)

    Ossia.Binding //-------------------------------------------------------- MARKHOR_BODY
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/markhor/body/tone')
        on:         markhor_body_tone
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/markhor/body/pitch')
        on:         markhor_body_pitch
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/markhor/body/xy')
        on:         markhor_body_xy
    }

    property real markhor_granular_pitch: 0.0
    property real markhor_granular_pitch_env: 0.0
    property real markhor_granular_overlap: 0.250
    property int markhor_granular_sample: 0

    Ossia.Binding //-------------------------------------------------------- MARKHOR_GRANULAR
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/markhor/granular/pitch_env')
        on:         markhor_granular_pitch_env
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/markhor/granular/pitch')
        on:         markhor_granular_pitch
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/markhor/granular/sample')
        on:         markhor_granular_sample
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/markhor/granular/overlap')
        on:         markhor_granular_overlap
    }

    property int markhor_pads_index: 0

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/markhor/pads/index')
        on:         markhor_pads_index
    }

    property bool strings_trigger:      false
    property bool strings_trigger2:     false
    property alias strings:             strings_new
    property alias strings2:            strings_new2

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       '/common/modules/strings/trigger'
        on:         strings_trigger
    }

    Ossia.Callback
    {
        id:         strings_new
        device:     ossia_net.client
        node:       '/common/modules/strings/new'
    }
    Ossia.Binding
    {
        device:     ossia_net.client
        node:       '/common/modules/strings/trigger2'
        on:         strings_trigger2
    }

    Ossia.Callback
    {
        id:         strings_new2
        device:     ossia_net.client
        node:       '/common/modules/strings/new2'
    }

    property real ammon_reverb_level: 0.5
    property int ammon_reverb_model: 0

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/ammon/reverb/level')
        on:         ammon_reverb_level
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/ammon/reverb/model')
        on:         ammon_reverb_model
    }


    property real jomon_reverb_level: 0.5
    property real jomon_lpf_freq: 1
    property real jomon_arp_bend: 0
    property real jomon_arp_tempo: 90
    property var jomon_arp_notes: []
    property int jomon_arp_notes_add: 0
    property int jomon_arp_notes_remove: 0
    property real jomon_arp_gate: 100
    property int jomon_arp_velocity: 20
    property bool jomon_palm_state: false
    property string jomon_arp_mode: "FIFO"
    property bool jomon_arp_trigger: false

    property real jomon_mangler_resampler: 12000.0
    property real jomon_mangler_thermonuclear: 0.0
    property int jomon_mangler_bitdepth: 8.0
    property real jomon_mangler_love: 75.0
    property real jomon_mangler_jive: 15.0
    property int jomon_mangler_attitude: 0

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/jomon/mangler/resample')
        on:         jomon_mangler_resampler
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/jomon/mangler/thermonuclear')
        on:         jomon_mangler_thermonuclear
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/jomon/mangler/bitdepth')
        on:         jomon_mangler_bitdepth
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/jomon/mangler/love')
        on:         jomon_mangler_love
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/jomon/mangler/jive')
        on:         jomon_mangler_jive
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/jomon/mangler/attitude')
        on:         jomon_mangler_attitude
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/jomon/arp/trigger')
        on:         jomon_arp_trigger
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/jomon/reverb/level')
        on:         jomon_reverb_level
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/jomon/lpf/frequency')
        on:         jomon_lpf_freq
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/jomon/arp/bend')
        on:         jomon_arp_bend
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/jomon/arp/notes/list')
        on:         jomon_arp_notes
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/jomon/arp/notes/add')
        on:         jomon_arp_notes_add
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/jomon/arp/notes/remove')
        on:         jomon_arp_notes_remove
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/jomon/arp/mode')
        on:         jomon_arp_mode
    }

    Ossia.Binding
    {
        device:     ossia_net.client
        node:       ossia_net.format_user_parameter('/modules/jomon/palm/state')
        on:         jomon_palm_state
    }

}
