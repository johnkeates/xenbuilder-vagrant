install-build-essential:
  pkg.installed:
    - name: build-essential

install-git-client:
  pkg.installed:
    - name: git

# Start planex deps
#========================================================================

install-python-setuptools:
  pkg.installed:
    - name: python-setuptools

install-python-argcomplete:
  pkg.installed:
    - name: python-argcomplete

install-dh-make:
  pkg.installed:
    - name: dh-make


get-planex-source:
  file.managed:
    - name: /tmp/planex_0.7.2.orig.tar.gz # yes 7.2 is the name
    - source: https://github.com/xenserver/planex/archive/v0.7.3.tar.gz # yes 7.3 is the source
    - source_hash: md5=422f69a9f6bbd383e50a7612a96808bb

unpack-planex-source:
  archive.extracted:
    - name: /tmp/
    - keep: True
    - source: /tmp/planex_0.7.2.orig.tar.gz # yes 7.2 is the name
    - source_hash: md5=422f69a9f6bbd383e50a7612a96808bb
    - archive_format: tar
    - if_missing: /tmp/planex-0.7.3/ # yes 7.3 is the source

# FIXME: fix archive.extracted's keep bool so we don't have to fetch again
get-planex-source-again-because-keep-didnt-work:
  file.managed:
    - name: /tmp/planex_0.7.2.orig.tar.gz # yes 7.2 is the name
    - source: https://github.com/xenserver/planex/archive/v0.7.3.tar.gz # yes 7.3 is the source
    - source_hash: md5=422f69a9f6bbd383e50a7612a96808bb

dpkg-build-package:
  cmd.run:
    - name: dpkg-buildpackage -d; true
    - cwd: /tmp/planex-0.7.3/
    - creates: /tmp/python-planex_0.7.2-1_all.deb


install-homecooked-planex:
  pkg.installed:
    - sources:
      - python-planex: /tmp/python-planex_0.7.2-1_all.deb

#  End planex deps
#========================================================================

# Start xenbuildroot deps
#========================================================================

get-xen-buildroot:
    git.latest:
      - user: vagrant
      - name: https://github.com/xenserver/buildroot.git
      - target: /home/vagrant/buildroot
      - require:
        - pkg: git

buildroot-dependencies:
  pkg.installed:
    - pkgs:
      - php5-fpm
      - php5-cli
      - php5-curl
      - camlp4
      - cowdancer
      - debian-keyring
      - debootstrap
      - devscripts
      - dh-python
      - diffstat
      - distro-info-data
      - dput
      - equivs
      - gir1.2-glib-2.0
      - hardening-includes
      - ledit
      - libapt-pkg-perl
      - libarchive-zip-perl
      - libclass-inspector-perl
      - libclone-perl
      - libcommon-sense-perl
      - libconvert-binhex-perl
      - libcrypt-ssleay-perl
      - libdbus-glib-1-2
      - libdigest-hmac-perl
      - libdistro-info-perl
      - libemail-valid-perl
      - libexporter-lite-perl
      - libfile-basedir-perl
      - libgirepository-1.0-1
      - libio-pty-perl
      - libio-sessiondata-perl
      - libio-socket-inet6-perl
      - libio-stringy-perl
      - libipc-run-perl
      - libjson-perl
      - libjson-xs-perl
      - liblist-moreutils-perl
      - libmime-tools-perl
      - libmpdec2
      - libncurses5-dev
      - libnet-dns-perl
      - libnet-domain-tld-perl
      - libnet-ip-perl
      - libossp-uuid-perl
      - libossp-uuid16
      - libparse-debcontrol-perl
      - libperlio-gzip-perl
      - libpython3-stdlib
      - libpython3.4-minimal
      - libpython3.4-stdlib
      - libsoap-lite-perl
      - libsocket6-perl
      - libtask-weaken-perl
      - libtext-levenshtein-perl
      - libtie-ixhash-perl
      - libtinfo-dev
      - libxmlrpc-lite-perl
      - lintian
      - ocaml-base-nox
      - ocaml-compiler-libs
      - ocaml-interp
      - ocaml-findlib
      - patchutils
      - pbuilder
      - python3
      - python3-apt
      - python3-chardet
      - python3-dbus
      - python3-debian
      - python3-gi
      - python3-magic
      - python3-minimal
      - python3-pkg-resources
      - python3-six
      - python3-software-properties
      - python3.4
      - python3.4-minimal
      - strace
      - t1utils
      - unattended-upgrades
      - unzip
      - wdiff

      - camlp4
      - camlp4-extra
      - gawk
      - libncurses5-dev
      - libsigsegv2
      - libtinfo-dev
      - m4
      - ocaml-base-nox
      - ocaml-compiler-libs
      - ocaml-interp
      - ocaml-native-compilers
      - ocaml-nox
      - libcothreads-ocaml-dev

      # Package requirements according to the configure script
      - cowbuilder
      - python-rpm
      - curl
      - ocaml-nox
      - apt-utils
      - gdebi-core
      - software-properties-common

      # Debian packages already here
      - oasis
      - ocamlify
      - ocamlmod
      - libnl-3-200
      - libodn-ocaml
      - libodn-ocaml-dev
      - ocaml-findlib
      - libfindlib-ocaml

      # Dependencies for the above
      - libodn-ocaml
      - liboasis-ocaml
      - libtype-conv-camlp4-dev
      - libodn-ocaml-dev
      - liboasis-ocaml-dev


      # XAPI
      - libcmdliner-ocaml-dev
      - omake


# End xenbuildroot deps
#========================================================================


# Start symlinks to fix MAKEFILE bugs
#========================================================================
# ocaml-findlib-symlink:
#   file.symlink:
#     # The link we're creating
#     - name: /home/vagrant/buildroot/_build/SRPMS/ocaml-findlib_1.5.5-1.dsc
#     # The target the link points to
#     - target: /home/vagrant/buildroot/SRPMS/ocaml-findlib_1.5.5-1.dsc
#     - makedirs: True # we have to create dirs if they don't exist yet
#     - user: vagrant # because that's the user we will build as

# ++++++++++++++
# ++++++++++++++

# This doesn't seem to do it, instead, after the first make, symlink everything!
# ++++++++++++++
# Execute: ln -s /home/vagrant/buildroot/SRPMS/* /home/vagrant/buildroot/_build/SRPMS/
# ++++++++++++++
# ERrors about existing items are fine.

# ++++++++++++++
# ++++++++++++++
#ocaml-findlib_1.5.5-1.dsc -> ../../SRPMS/ocaml-findlib_1.5.5-1.dsc



# End symlinks to fix MAKEFILE bugs
#========================================================================
