DESTDIR=
DST_list=$(DESTDIR)/etc/apt/sources.list.d
DST_keyring=$(DESTDIR)/usr/share/keyrings

KEY_URL=https://build.opensuse.org/projects/home:mkoutny:fykos/public_key

build: fks-archive-keyring.gpg
	true

clean:
	rm fks-archive-keyring.gpg fks.pub || true

install:
	mkdir -p $(DST_list)
	mkdir -p $(DST_keyring)
	cp fks.list $(DST_list)/
	cp fks-archive-keyring.gpg $(DST_keyring)/

fks-archive-keyring.gpg: fks.pub
	gpg --no-default-keyring --keyring ./$@ --trust-model always --import $<
	rm $@~

fks.pub:
	wget -O $@ $(KEY_URL)

