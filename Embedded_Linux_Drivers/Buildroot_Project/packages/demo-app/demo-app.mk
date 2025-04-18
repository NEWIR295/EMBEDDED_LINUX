DEMO_APP_VERSION = 1.0
DEMO_APP_SITE = $(TOPDIR)/package/demo-app
DEMO_APP_SITE_METHOD = local
DEMO_APP_LICENSE = GPL-2.0

define DEMO_APP_BUILD_CMDS
    $(TARGET_CC) $(TARGET_CFLAGS) $(@D)/demo_app.c -o $(@D)/demo_app
endef

define DEMO_APP_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/demo_app $(TARGET_DIR)/usr/bin/demo_app
endef

$(eval $(generic-package))
