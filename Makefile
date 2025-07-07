PRINTSERVER_VER=`cat release_number.txt`
MAKESELF_VER=2.4.2

makeself-$(MAKESELF_VER)/makeself.sh:
	wget --quiet https://github.com/megastep/makeself/releases/download/release-$(MAKESELF_VER)/makeself-$(MAKESELF_VER).run
	sh ./makeself-$(MAKESELF_VER).run
	rm makeself-$(MAKESELF_VER).run

printserver-install-$(PRINTSERVER_VER).run: makeself-$(MAKESELF_VER)/makeself.sh install.sh hosts-localhost site.yml $(wildcard roles/**/*)
	mkdir -p rpi-print-server
	cp -r hosts-localhost install.sh roles site.yml rpi-print-server/.
	makeself-$(MAKESELF_VER)/makeself.sh --notemp rpi-print-server printserver-install-$(PRINTSERVER_VER).run "Installing setup scripts" ./install.sh

.PHONY: clean package release

clean:
	rm -rf rpi-print-server printserver-install-*.run

package: printserver-install-$(PRINTSERVER_VER).run

release: package
	git tag r$(PRINTSERVER_VER)
	git push origin
	curl -X POST -H "Accept: application/vnd.github.v3+json" \
	https://api.github.com/repos/ke4roh/rpi-print-server/releases \
	-d '{"tag_name":"'r$(PRINTSERVER_VER)'"}'
	expr $(PRINTSERVER_VER) + 1 >release_number.txt
