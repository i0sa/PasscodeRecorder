TARGET := iphone:clang
ARCHS = armv7 arm64
include theos/makefiles/common.mk

BUNDLE_NAME = passrecorderflipswitch
passrecorderflipswitch_FILES = Switch.x
passrecorderflipswitch_FRAMEWORKS = UIKit
passrecorderflipswitch_LIBRARIES = flipswitch
passrecorderflipswitch_INSTALL_PATH = /Library/Switches

include $(THEOS_MAKE_PATH)/bundle.mk