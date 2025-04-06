TARGET := iphone:clang:latest:16.5:14.0
THEOS_PACKAGE_SCHEME=rootless

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = NotificationGlow2Prefs

NotificationGlow2Prefs_FILES = WXMRootListController.m
NotificationGlow2Prefs_FRAMEWORKS = UIKit
NotificationGlow2Prefs_PRIVATE_FRAMEWORKS = Preferences
NotificationGlow2Prefs_INSTALL_PATH = /Library/PreferenceBundles
NotificationGlow2Prefs_CFLAGS = -fobjc-arc
NotificationGlow2Prefs_LIBRARIES = gcuniversal

include $(THEOS_MAKE_PATH)/bundle.mk
