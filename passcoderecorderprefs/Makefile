TARGET := iphone:clang
ARCHS = armv7 arm64
include theos/makefiles/common.mk

BUNDLE_NAME = passcoderecorderprefs
passcoderecorderprefs_FILES = passcoderecorderprefs.mm
passcoderecorderprefs_INSTALL_PATH = /Library/PreferenceBundles
passcoderecorderprefs_FRAMEWORKS = UIKit
passcoderecorderprefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/passcoderecorderprefs.plist$(ECHO_END)
