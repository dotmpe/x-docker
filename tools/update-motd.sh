#!/bin/sh

export PATH="${PATH:+$PATH:}/bin:/usr/bin:/usr/local/bin"

[ -r /etc/lsb-release ] && . /etc/lsb-release
if [ -z "$DISTRIB_DESCRIPTION" ] && [ -x /usr/bin/lsb_release ]; then
        # Fall back to using the very slow lsb_release utility
        DISTRIB_DESCRIPTION=$(lsb_release -s -d)
fi

date=`date`
load=`cat /proc/loadavg | awk '{print $1}'`
root_usage=`df -h / | awk '/\// {print $(NF-1)}'`
memory_usage=`free -m | awk '/Mem:/ { total=$2 } /buffers\/cache/ { used=$3 } END { printf("%3.1f%%", used/total*100)}'`
swap_usage=`free -m | awk '/Swap/ { printf("%3.1f%%", "exit !$2;$3/$2*100") }'`
users=`users | wc -w`
time=`uptime | grep -ohe 'up .*' | sed 's/,/\ hours/g' | awk '{ printf $2" "$3 }'`
processes=`ps aux | wc -l`
ip=`ifconfig $(route | grep default | awk '{ print $8 }') | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}'`


KERNEL_VERSION=$(uname -r)

[ -f /etc/motd.head ] && cat /etc/motd.head || true
printf "\n"
printf "Welcome on %s (%s %s %s %s)\n" "${DISTRIB_DESCRIPTION}" "$(uname -o)" "${KERNEL_VERSION}" "$(uname -m)" "$KERNEL_TITLE"
printf "\n"
printf "System information as of: %s\n" "$date"
printf "\n"
printf "System load:\t%s\t\tInt IP Address:\t%s %s\n" $load $ip
printf "Memory usage:\t%s\n" $memory_usage
printf "Usage on /:\t%s\t\tSwap usage:\t%s\n" $root_usage $swap_usage
printf "Local Users:\t%s\t\tProcesses:\t%s\n" $users $processes
printf "Image build:\t%s\tSystem uptime:\t%s\n" "${TREEBOX_BUILD_ID}" "$time"

printf "\n"
test -n "$IMAGE_SCM_COMMIT" ||
  printf "Image source:\t%s\n" "$IMAGE_SCM_COMMIT"
printf "\n"
test -f /etc/motd.tail && cat /etc/motd.tail || true
