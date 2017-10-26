


phusion/baseimage
  treebox
    - Basic shell tools
    - Python (pip, virtualenv), Node (NVM, NPM), Ruby (full, gems), PHP (cli)
    - Super user
    - More (user) shell tooling

    sandbox
      - Docker installed

    node-sitefile:dev
      ..



Enable SSH: startup script into /etc/my_init.d/::

	#!/bin/sh
	rm -f /etc/service/sshd/down
	ssh-keygen -P "" -t dsa -f /etc/ssh/ssh_host_dsa_key

