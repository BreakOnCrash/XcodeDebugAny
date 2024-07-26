THEOS_DEVICE_IP = localhost -o StrictHostKeyChecking=no
THEOS_DEVICE_PORT = 2222

ARCHS = arm64 arm64e

TARGET := iphone:clang:16.5:latest
THEOS_PACKAGE_SCHEME=rootless

include $(THEOS)/makefiles/common.mk

# tweak
INSTALL_TARGET_PROCESSES = lockdownd
TWEAK_NAME = XcodeDebugAny

XcodeDebugAny_FILES = Tweak.x
XcodeDebugAny_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

# XcodeDebugAnyPrefs

include $(THEOS_MAKE_PATH)/aggregate.mk

BUNDLE_NAME = XcodeDebugAnyPrefs

XcodeDebugAnyPrefs_FILES = Prefs/XDARootListController.m
XcodeDebugAnyPrefs_FRAMEWORKS = UIKit
XcodeDebugAnyPrefs_PRIVATE_FRAMEWORKS = Preferences
XcodeDebugAnyPrefs_INSTALL_PATH = /Library/PreferenceBundles
XcodeDebugAnyPrefs_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/bundle.mk
