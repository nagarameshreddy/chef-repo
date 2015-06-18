#!/bin/bash -e

LOGDIR=/tmp/bootstrap_logs
INPUTFILE=$1

OLDIFS=$IFS
IFS=,

if [ ! -f $INPUTFILE ]; then
  echo "$INPUTFILE not found, aborting..."
  exit 1
fi

echo "*** Emptying log directory $LOGDIR"
rm -rf $LOGDIR
mkdir $LOGDIR

while read hostname environment runlist; do
  echo "*** Bootstrapping node $hostname, in environment $environment, with runlist $runlist" 
	knife bootstrap $hostname \
  -x "vagrant" -P "vagrant"  --sudo \
  -r "$runlist" \
  --environment $environmentv> $LOGDIR/$hostname.log 2>&1
done < $INPUTFILE
