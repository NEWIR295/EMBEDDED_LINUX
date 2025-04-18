EDGES_DRIVERS_VERSION = 1.0
EDGES_DRIVERS_SITE = $(TOPDIR)/package/edges-drivers
EDGES_DRIVERS_SITE_METHOD = local
EDGES_DRIVERS_LICENSE = GPL-2.0
EDGES_DRIVERS_LICENSE_FILES = COPYING
EDGES_DRIVERS_MODULE_SUBDIRS = .

define EDGES_DRIVERS_INSTALL_TARGET_CMDS
    $(INSTALL) -d -m 0755 $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra/
    $(INSTALL) -D -m 0755 $(@D)/led_driver.ko $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra/
    $(INSTALL) -D -m 0755 $(@D)/switch_driver.ko $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra/
    $(INSTALL) -D -m 0644 $(@D)/modules.order $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/
    $(INSTALL) -D -m 0644 $(@D)/Module.symvers $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/
endef

$(eval $(kernel-module))
$(eval $(generic-package))
