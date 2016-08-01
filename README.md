# xenbuilder-vagrant
Build box for XAPI on Debian with SaltStack based configs

This repo quickly sets up a VM where XAPI (and if needed the xenserver buildroot) can be used and replicated.

## Usage 
Usage: clone repo and type `vagrant up`. Requires a working vagrant setup.

## Updates
On update: you can just pull in the git repo updates, if you want to update the config for the vagrant box:

- call `salt-call state.highstate` from within the box
or
- call `vagrant provision` to have vagrant do it for you
or
- just `vagrant destroy` and `vagrant up` to delete everything and start fresh


## More information

It looks like Xen, Xen-API, Xenopsd etc. are all built from a common set of dependencies in xenserver-buildroot.
An alternative environment to build Xen parts in is the xenserver/xenserver-build-env which seems to be based on docker and existing packages for CentOS and other RPM distros. It's not suited for Debian at all, and it doesn't look like anyone is working on that either.

The Buildroot itself seems to use Planex to build packages out of the dependencies to be delivered with Xen itself on binary installation. The Planex tool can be built on Debian (as it happening in this repo) and used, but it might be better to skip it as it doesn't really have anything to do with Debian and isn't very cross-platform.

Most dependencies are ocaml related and have their own dependencies as well. So one Xen component might want to use a ocaml module which in turn wants to use a library.
