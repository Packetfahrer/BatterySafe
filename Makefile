export ARCHS = armv7 arm64

include theos/makefiles/common.mk

TWEAK_NAME = BatterySafe
BatterySafe_FILES = Tweak.xm
BatterySafe_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk