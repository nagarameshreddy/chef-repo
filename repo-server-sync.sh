#!/bin/bash -e

# Expecting roles, environments, data_bags?

objects=$1
object=${objects/s/}

if ! egrep -q "^(roles|environments)$"<<<"$objects"; then
  echo "Usage: $0 roles|environments"
  exit 1
fi

if ! chef gem list knife-backup | grep -q knife-backup; then
  echo "ERROR: knife-backup gem is not installed, aborting..."
  exit 1
fi

# Use a temp directory for the objects backup
tmp_dir='/tmp/chef-export'
rm -rf $tmp_dir
mkdir -p $tmp_dir

# Download all the objects(i.e. roles) from the Chef server
knife backup export $objects -D $tmp_dir

if ! [ -d $objects ]; then
  echo "ERROR: Directory '$objects' missing in the current folder, aborting..."
  exit 1
fi

if ! [ -d "$tmp_dir/$objects" ]; then
  echo "ERROR: Directory '$tmp_dir/$objects' is missing, aborting..."
  exit 1
fi

mkdir -p "$tmp_dir/repo_pretty"
mkdir -p "$tmp_dir/server_pretty"

all_files=`ls -1 $objects`
for file in $all_files; do
  if [ -f $tmp_dir/$objects/$file ]; then
    # objects exist on the Chef server, checking if update is needed
    python -m json.tool $objects/$file > $tmp_dir/repo_pretty/$file
    python -m json.tool $tmp_dir/$objects/$file > $tmp_dir/server_pretty/$file

    if diff -q $tmp_dir/repo_pretty/$file $tmp_dir/server_pretty/$file > /dev/null; then
      echo "*** $object $file is up-to-date"
    else
      echo "*** $object $file is out-of-date"
      to_upload="$to_upload $file"
    fi

    # Deleting the file to see what's left in the end
    rm -f $tmp_dir/$objects/$file
  else
    echo "*** $object $file is missing on the Chef server"
    # File missing on the Chef server, adding
    to_upload="$to_upload $file"
  fi
done

if [ -n "$to_upload" ] ; then
  command="knife $object from file $to_upload"
  echo "*** Running: $command"
  $command
fi

all_files=`ls -1 $tmp_dir/$objects/`
for file in $all_files; do
  command="knife $object delete -y ${file/.json/}"
  echo "*** Running: $command"
  $command
done
