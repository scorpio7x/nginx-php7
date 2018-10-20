#! /bin/sh

### BEGIN INIT INFO
# Provides:          nginx
# Required-Start:    $all
# Required-Stop:     $all
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: starts the nginx web server
# Description:       starts nginx using start-stop-daemon
### END INIT INFO

PATH=/sbin:/bin
DAEMON=/usr/local/nginx/sbin/nginx
PID=/usr/local/nginx/logs/nginx.pid
NAME=nginx
DESC=nginx

test -x $DAEMON || exit 0

# Include nginx defaults if available
if [ -f /etc/default/nginx ] ; then
        . /etc/default/nginx
fi

set -e

case "$1" in
  start)
        echo -n "Starting $DESC: "
		if ! test -e $PID; then
			start-stop-daemon --start --quiet --exec $DAEMON
			sleep 1
		fi
        echo "							[Running]"
		echo -n
        ;;
  stop)
        echo -n "Stopping $DESC: "
		if test -e $PID; then
			start-stop-daemon --stop --quiet --exec $DAEMON
			sleep 1
		fi
        echo "							[Stopped]"
		echo -n
        ;;
  restart|reload)
        echo -n "Restarting $DESC: "
		
		if test -e $PID; then
			start-stop-daemon --stop --quiet --exec $DAEMON
		fi
		
		sleep 1
		start-stop-daemon --start --quiet --exec $DAEMON
        echo "							[Reloaded]"
		echo -n
        ;;
  force-reload)
		echo -n "Restarting $DESC: "
		
		if test -e $PID; then
			kill $(cat $PID)
		fi
		
		sleep 1
		start-stop-daemon --start --quiet --exec $DAEMON
        echo "							[Reloaded]"
		echo -n
		;;
  status)
		echo -n
		ps waux | grep nginx
		;;
      *)
            N=/etc/init.d/$NAME
            echo "Usage: $N {start|stop|restart|reload|force-reload|status}" >&2
            exit 1
            ;;
    esac

    exit 0
