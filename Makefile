DESTDIR=
DST_list=$(DESTDIR)/etc/apt/sources.list.d
DST_keyring=$(DESTDIR)/usr/share/keyrings

build: fks-archive-keyring.gpg
	true

clean:
	rm fks-archive-keyring.gpg || true

install:
	mkdir -p $(DST_list)
	mkdir -p $(DST_keyring)
	cp fks.list $(DST_list)/
	cp fks-archive-keyring.gpg $(DST_keyring)/

fks-archive-keyring.gpg: keys/fks.pub
	# make space for GPG temporary files and gpg-agent socket
	mkdir -p ~/.gnupg
	gpg --no-default-keyring --keyring ./$@ --trust-model always --import $<
	rm $@~

