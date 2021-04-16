PAM_LIB_DIR ?= /lib/security
INSTALL ?= install
CFLAGS ?= -O2 -g -Wall -Wformat-security

CPPFLAGS += -DUSE_CRYPT_R -D_FILE_OFFSET_BITS=64
CFLAGS += -fPIC -fvisibility=hidden
LDFLAGS += -Wl,-x -shared

TITLE = pam_pwdfile
LIBSHARED = $(TITLE).so
LDLIBS = -lcrypt -lpam
LIBOBJ = $(TITLE).o


all: $(LIBSHARED)

$(LIBSHARED): $(LIBOBJ)
	$(CC) $(LDFLAGS) $(LIBOBJ) $(LDLIBS) -o $@

install: $(LIBSHARED)
	$(INSTALL) -m 0755 -d $(DESTDIR)$(PAM_LIB_DIR)
	$(INSTALL) -m 0755 $(LIBSHARED) $(DESTDIR)$(PAM_LIB_DIR)

clean:
	$(RM) *.o *.so

changelog-from-git: changelog
	{ git log --decorate $(shell head -1 changelog | cut -d\  -f2).. | vipe; echo; cat changelog; } | sponge changelog
