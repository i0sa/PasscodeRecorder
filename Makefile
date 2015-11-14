TARGET := iphone:clang
ARCHS = armv7 arm64
include theos/makefiles/common.mk

TWEAK_NAME = PasscodeRecorder
PasscodeRecorder_FILES = Tweak.xm
PasscodeRecorder_FRAMEWORKS = UIKit
PasscodeRecorder_LIBRARIES = flipswitch

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += passcoderecorderprefs
SUBPROJECTS += passrecorderflipswitch
include $(THEOS_MAKE_PATH)/aggregate.mk
