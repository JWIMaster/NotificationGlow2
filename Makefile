TARGET := iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = SpringBoard
THEOS_PACKAGE_SCHEME=rootless

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = NotificationGlow2
TWEAKNAME_LIBRARIES = lgcuniversal

NotificationGlow2_FILES = Tweak.x
NotificationGlow2_CFLAGS = -fobjc-arc 
NotificationGlow2_LDFLAGS = -lgcuniversal




include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += NotificationGlow2Prefs
include $(THEOS_MAKE_PATH)/aggregate.mk
