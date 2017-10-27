
Notes on phusion/baseimage usage, and customized images.
First, a tree-view of the customizations of baseimage, and what they offer.

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



There is no password for the user. To let the treebox user excercise its sudoers
rights either allow for no-password use, or set a password. One of these lines::

	echo "%supergroup  ALL=NOPASSWD:ALL" >>/etc/sudoers.d/treebox
	echo treebox:password | chpasswd

The ReadMe says to enable SSH, to add this script into /etc/my_init.d/::

	#!/bin/sh
	rm -f /etc/service/sshd/down
	ssh-keygen -P "" -t dsa -f /etc/ssh/ssh_host_dsa_key

Such a file could be mounted too.

Another way is to pass all the commands to the container. If we can reach ``sh``,
or ``bash`` in a container, than we can also pass in scripts using ``-c``. For
example this seems to start SSH::

  docker run -ti -P --rm phusion/baseimage:latest \
    /sbin/my_init -- sh -c 'rm /etc/service/sshd/down && \
      ssh-keygen -P "" -t dsa -f /etc/ssh/ssh_host_dsa_key && bash'

Starting like this leaves the terminal attached to a root login bash process
that keeps the container running. The service SSH will have been started, with
 a key so it could accept connections using DSA. For other types, other keys
will need to be generated as well.

So to use it and see if all is as expected, we should try to login. Except for
some things are missing still.

- baseimage does not expose 22, so the ``-P`` does not do anything
- we need an authorized_keys file with our public key added into the container

And then, there is no user in baseimage. We can login as root as a matter of
testing the container SSH service. But instead lets pick the customized treebox
variant, which has a ``treebox`` user with ssh and sudoers privileges built-in.

Users
  There is no standard user in baseimage, except for the regular debian and
  ubuntu system users and groups. Adding users can help securing your services,
  and also make the containers more accessible. For use as a real user
  environment, not just as a host for some stack or service.

  Besides, logging in to networked systems as root has always been frowned upon.
  Docker can be more secure, but I see it does not come like that by default.
  It needs to be enabled. And starting an ubuntu instance like above, still runs
  it as root. [#]_ It may not have privileges on your host system (yet), but it
  does not stop anything happening from inside the container would an external
  agent get in somehow.

So lets start treebox, with SSH enabled. But login using a key as treebox user.
The treebox build leaves the container state, so that it runs as the created
user. But that means if we were to run like that, we cannot acess most of the
system since it all belongs to root. We either need to mount at least the
configuration files so that treebox gets a password, or becomes a passwordless
sudoer. Or, we can start as root using docker, and turn into treebox user with
the phusion/baseimage /setuser python tooling.

Here is all the legwork needed to get this container running::

  test -e ~/.ssh/id_dsa.pub || ssh-keygen -t dsa
  mkdir -p container-ssh
  cp ~/.ssh/id_dsa.pub container-ssh/authorized_keys
  usr_grp=$( printf -- "$(docker run --rm bvberkum/treebox:dev sh -c 'id -u && id -g')" | tr '\n' ':' )
  chown -R $usr_grp container-ssh
  chmod -R go-rwx container-ssh
  docker run -p 5555:22 \
    -v $(pwd)/container-ssh:/home/treebox/.ssh -ti --rm --user root \
    bvberkum/treebox:dev /sbin/my_init -- sh -c '\
    ssh-keygen -P "" -t dsa -f /etc/ssh/ssh_host_dsa_key && \
    rm /etc/service/sshd/down && \
    service ssh restart && \
    bash'
  rm -rf container-ssh

Again, we are dropped into a root login terminal. But in another terminal::

  ssh -o UserKnownHostsFile=/etc/null treebox@localhost -p 5555

should now enter us right into the treebox user environment after confirmation
about the unknown host fingerprint. The only thing I did not add is a password
for treebox, or a NOPASSWD sudoers line. But you can see how this can get as
complicated as you want. You will note the usr_grp lookup in the script. That I
could have removed, since the first user/group on debian systems is 1000:1000.
But I left it in, since you may want to put some thought to the uid and gid.
Especially since these ids will need to be set as the owner/group of any mounted
files too, but which means that they may now also belong to some user and group
on the docker host system. Which can be a an entirely different
username/groupname depending on wether the host system OS and/or configuration
match.


TODO: remapping uid/gid is now possible. See https://docs.docker.com/engine/security/userns-remap/

TODO: to read a more into Linux security follow the first link in the above article (to https://docs.docker.com/engine/security/userns-remap/), or continue in docker docs: https://docs.docker.com/engine/security/security/

Curious about the groups and file ownership, I ran the following script in
``phusion/baseimage:0.9.22``::

	cat /etc/group | cut -d ':' -f 1 | while read gn; do echo $gn $( find / -group $gn 2>/dev/null | wc -l ) ; done


root 29251
daemon 0
bin 0
sys 0
adm 8
tty 1
disk 0
lp 0
mail 1
news 0
uucp 0
man 0
proxy 0
kmem 0
dialout 0
fax 0
voice 0
cdrom 0
floppy 0
tape 0
sudo 0
audio 0
dip 0
www-data 0
backup 0
operator 0
list 0
irc 0
src 0
gnats 0
shadow 6
utmp 4
video 0
sasl 0
plugdev 0
staff 3
games 0
users 0
nogroup 0
systemd-journal 0
systemd-timesync 0
systemd-network 0
systemd-resolve 0
systemd-bus-proxy 0
docker_env 2
crontab 2
ssh 1
treebox 0




.. [#] https://www.twistlock.com/2017/06/15/docker-secure-wrong-question-ask/
