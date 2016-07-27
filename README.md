# xenbuilder-vagrant
Build box for XAPI on Debian with SaltStack based configs

This repo quickly sets up a VM where XAPI (and if needed the xenserver buildroot) can be used and replicated.

Usage: clone repo and type `vagrant up`. Requires a working vagrant setup.

On update: you can just pull in the git repo updates, if you want to update the config for the vagrant box:

- call `salt-call state.highstate` from within the box
or
- call `vagrant provision` to have vagrant do it for you
or
- just `vagrant destroy` and `vagrant up` to delete everything and start fresh
