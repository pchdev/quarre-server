QT += quick quickwidgets widgets
CONFIG += c++11 qtquickcompiler console

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp \
    source/wpnconsoleinput.cpp

RESOURCES += resources/qml/qml.qrc \
    resources/qml/modules/modules.qrc \
    resources/images/images.qrc \
    resources/fonts/fonts.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

DISTFILES += \
resources/audio/introduction/digibirds.wav \
resources/audio/introduction/dragon-hi.wav \
resources/audio/introduction/dragon-lo.wav \
resources/audio/introduction/spring.wav \
resources/audio/introduction/swarms.wav \
resources/audio/introduction/synth.wav \
resources/audio/introduction/verb.wav \
resources/audio/introduction/walking-1.wav \
resources/audio/introduction/walking-2.wav \
resources/audio/introduction/water.wav \
\
resources/audio/stonepath/cendres/ashes.wav \
resources/audio/stonepath/cendres/boiling.wav \
resources/audio/stonepath/cendres/burn.wav \
resources/audio/stonepath/cendres/dragon.wav \
resources/audio/stonepath/cendres/groundwalk.wav \
resources/audio/stonepath/cendres/light-background.wav \
resources/audio/stonepath/cendres/necks.wav \
resources/audio/stonepath/cendres/quarre.wav \
resources/audio/stonepath/cendres/redbirds-1.wav \
resources/audio/stonepath/cendres/redbirds-2.wav \
resources/audio/stonepath/cendres/waves.wav \
\
resources/audio/stonepath/diaclases/drone.wav \
resources/audio/stonepath/diaclases/harmonics.wav \
resources/audio/stonepath/diaclases/smoke.wav \
resources/audio/stonepath/diaclases/stonewater.wav \
\
resources/audio/stonepath/deidarabotchi/background.wav \
resources/audio/stonepath/deidarabotchi/breath.wav \
resources/audio/stonepath/deidarabotchi/kaivo.wav \
resources/audio/stonepath/deidarabotchi/synth.wav \
resources/audio/stonepath/deidarabotchi/wind.wav \
\
resources/audio/stonepath/markhor/ambient-light.wav \
resources/audio/stonepath/markhor/bell-hit.wav \
resources/audio/stonepath/markhor/soundscape.wav \
\
resources/audio/stonepath/ammon/broken-radio.wav \
resources/audio/stonepath/ammon/footsteps.wav \
resources/audio/stonepath/ammon/harmonics.wav \
resources/audio/stonepath/ammon/wind.aiff \
\
resources/audio/woodpath/maaaet/birds-background.wav \
resources/audio/woodpath/maaaet/grasshoppers.wav \
resources/audio/woodpath/maaaet/groundcreek.wav \
resources/audio/woodpath/maaaet/leaves.wav \
resources/audio/woodpath/maaaet/wind.wav \
\
resources/audio/woodpath/pando/digigreen.wav \
resources/audio/woodpath/pando/flute.wav \
resources/audio/woodpath/pando/insects.wav \
resources/audio/woodpath/pando/leaves.wav \
resources/audio/woodpath/pando/verb.wav \
resources/audio/woodpath/pando/woodworks.wav \
\
resources/audio/woodpath/vare/hammer.wav \
resources/audio/woodpath/vare/snowfall.wav \
\
resources/audio/woodpath/jomon/cicadas.wav \
resources/audio/woodpath/jomon/dmsynth.wav \
resources/audio/woodpath/jomon/fsynths.wav \
resources/audio/woodpath/jomon/leaves.wav \
resources/audio/woodpath/jomon/owl1.wav \
resources/audio/woodpath/jomon/owl2.wav \
resources/audio/woodpath/jomon/owl3.wav \
resources/audio/woodpath/jomon/owl4.wav

#APP_AUDIO_FILES.files = $$DISTFILES
#APP_AUDIO_FILES.path = Contents/Resources
#QMAKE_BUNDLE_DATA += APP_AUDIO_FILES

HEADERS += \
    source/wpnconsoleinput.hpp
