#makefile for ax25systemd
.PHONY prerequisites:
prerequisites:
	@apt -y install ax25-tools ax25-apps

.PHONY install:
install: prerequisites
	@/bin/cp -f "ax25@.service" "/lib/systemd/system/"
	@/bin/cp -f "axup" "/usr/sbin/"
	@/bin/chmod +x "/usr/sbin/axup"
	@/bin/cp -f "axdown" "/usr/sbin"
	@/bin/chmod +x "/usr/sbin/axdown"
	@/bin/mkdir -p "/etc/ax25/interfaces.d/"
	@/bin/cp "ax25.default" "/etc/ax25/interfaces.d/default"
	@/bin/mkdir -p "/usr/share/kissinit"
	@/bin/cp "kissinit/nordlink_1k2" "/usr/share/kissinit/"
	@/bin/chmod +x "/usr/share/kissinit/nordlink_1k2"
	@/bin/cp "kissinit/ej50u" "/usr/share/kissinit/"
	@/bin/chmod +x "/usr/share/kissinit/ej50u"
	@#
	@systemctl daemon-reload
	@echo " "
	@echo "Installed. Edit/Add intrfaces in /etc/ax25/interfaces.d/ and /etc/ax25/axports as needed."
	@echo "When done editing these files, run \"systemctl enable ax25@interfacefile && service ax25@interfacefile start\" to start the corresponding interface"

.PHONY uninstall:
uninstall:
	@service ax25@ stop || true
	@systemctl disable ax25@ || true
	@systemctl daemon-reload
	@/bin/rm "/lib/systemd/system/ax25@.service"
	@/bin/rm "/usr/sbin/axup"
	@/bin/rm "/usr/sbin/axdown"
	@/bin/rm -rf "/usr/share/kissinit/"
	@/bin/rm -rf "/etc/ax25/interfaces.d/"
	@echo " "
	@echo "Uninstalled !"
