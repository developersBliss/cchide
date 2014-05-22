export ARCHS=armv7 arm64
export TARGET=iphone:latest:7.0

include theos/makefiles/common.mk

TWEAK_NAME = CCHide
CCHide_FILES = Tweak.xm
CCHide_FRAMEWORKS = UIKit, MediaPlayer

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += cchideprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
