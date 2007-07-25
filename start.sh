#!/bin/sh
appname="$1"
script="${2:-${appname}}"
datadir=/var/log/milter
exec >>${datadir}/${appname}.log 2>&1
if test -s ${datadir}/${script}.py; then
  cd %{datadir} # use version in log dir if it exists for debugging
else
  cd /usr/lib/pymilter
fi

cd /var/log/milter
exec >>${appname}.log 2>&1
python2.4 ${appname}.py &
echo $! >/var/run/milter/${appname}.pid