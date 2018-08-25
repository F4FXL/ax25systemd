#makefile for ax25systemd
prerequisites:
	@apt -y install ax25-tools ax25-apps

install:
	@/bin/cp -rf "ax25.service" "/lib/systemd/system/ax25.service"	
	@/bin/cp -rf "axup" "/usr/sbin/"
	@/bin/chmod +x "/usr/sbin/axup"
	@/bin/cp "ax25.default" "/etc/default/ax25"
	@/bin/mkdir "/usr/share/kissinit"
	@/bin/cp "kissinit/nordlink_1k2" "/usr/share/kissinit/"
	@/bin/chmod +x "/usr/share/kissinit/nordlink_1k2"
	@/bin/cp "kissinit/ej50u" "/usr/share/kissinit/"
	@/bin/chmod +x "/usr/share/kissinit/ej50u"
	@#
	@systemctl daemon-reload
	@systemctl enable ax25
	@echo " "
	@echo "Installed. Edit /etc/default/ax25 and /etc/ax25/axports if needed. When done editing those files, run \"service ax25 start\" to start the service"
