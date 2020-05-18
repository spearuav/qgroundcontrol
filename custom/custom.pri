message("Adding Custom Plugin")

#-- Version control
#   Major and minor versions are defined here (manually)

NINOXC2_VER_MAJOR = 0
NINOXC2_VER_MINOR = 0
NINOXC2_VER_FIRST_BUILD = 0

# Build number is automatic
# Uses the current branch. This way it works on any branch including build-server's PR branches
CUSTOM_QGC_VER_BUILD = $$system(git --git-dir ../.git rev-list $$GIT_BRANCH --first-parent --count)
win32 {
    NINOXC2_VER_BUILD = $$system("set /a $$NINOXC2_VER_BUILD - $$NINOXC2_VER_FIRST_BUILD")
} else {
    NINOXC2_VER_BUILD = $$system("echo $(($$NINOXC2_VER_BUILD - $$NINOXC2_VER_FIRST_BUILD))")
}
NINOXC2_VERSION = $${NINOXC2_VER_MAJOR}.$${NINOXC2_VER_MINOR}.$${NINOXC2_VER_BUILD}

DEFINES -= GIT_VERSION=\"\\\"$$GIT_VERSION\\\"\"
DEFINES += GIT_VERSION=\"\\\"$$NINOXC2_VERSION\\\"\"

message(NinoxC2 Version: $${NINOXC2_VERSION})

# Build a single flight stack by disabling APM support
MAVLINK_CONF = ardupilotmega
#CONFIG  += QGC_DISABLE_APM_MAVLINK
#CONFIG  += QGC_DISABLE_APM_PLUGIN QGC_DISABLE_APM_PLUGIN_FACTORY

# We implement our own PX4 plugin factory
CONFIG  += QGC_DISABLE_PX4_PLUGIN_FACTORY

# Branding

DEFINES += CUSTOMHEADER=\"\\\"CustomPlugin.h\\\"\"
DEFINES += CUSTOMCLASS=CustomPlugin

TARGET   = SpearUAVGroundStation
DEFINES += QGC_APPLICATION_NAME='"\\\"SpearUAV NinoxC2\\\""'

DEFINES += QGC_ORG_NAME=\"\\\"spearuav.com\\\"\"
DEFINES += QGC_ORG_DOMAIN=\"\\\"com.spearuav\\\"\"

QGC_APP_NAME        = "SpearUAV NinoxC2 GroundControl"
QGC_BINARY_NAME     = "NinoxC2GroundControl"
QGC_ORG_NAME        = "SpearUAV"
QGC_ORG_DOMAIN      = "com.spearuav"
QGC_APP_DESCRIPTION = "SpearUAV NinoxC2 GroundControl"
QGC_APP_COPYRIGHT   = "Copyright (C) 2020 SpearUAV Development Team. All rights reserved."

QGC_INSTALLER_ICON = "custom\\SPEAR_Icon_Red.ico"
RC_ICONS = custom/res/Images/spearuav.ico

# Our own, custom resources
RESOURCES += \
    $$PWD/custom.qrc

QML_IMPORT_PATH += \
   $$PWD/res

# Our own, custom sources
SOURCES += \
    $$PWD/src/CustomPlugin.cc \

HEADERS += \
    $$PWD/src/CustomPlugin.h \

INCLUDEPATH += \
    $$PWD/src \

#-------------------------------------------------------------------------------------
# Custom Firmware/AutoPilot Plugin

INCLUDEPATH += \
    $$PWD/src/FirmwarePlugin \
    $$PWD/src/AutoPilotPlugin

HEADERS+= \
    $$PWD/src/AutoPilotPlugin/CustomAutoPilotPlugin.h \
    $$PWD/src/FirmwarePlugin/CustomFirmwarePlugin.h \
    $$PWD/src/FirmwarePlugin/CustomFirmwarePluginFactory.h \

SOURCES += \
    $$PWD/src/AutoPilotPlugin/CustomAutoPilotPlugin.cc \
    $$PWD/src/FirmwarePlugin/CustomFirmwarePlugin.cc \
    $$PWD/src/FirmwarePlugin/CustomFirmwarePluginFactory.cc \

