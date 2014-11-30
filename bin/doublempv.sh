#!/bin/sh

# example how to output video on multiple windows in sync.
# might be even more useful in combination with vo ggi
# to distribute the video arbitrarily

dir=/tmp/$$
count=$1
shift

if test 0"$count" -lt 1; then
  echo "At least 1 slave instance must be used."
  echo ""
  echo "Usage:"
  echo "./mplmult.sh n mplayer-opts"
  echo "n              number of MPlayer instances that display the video"
  echo "mplayer-opts   anything you would specify to mplayer,"
  echo "               more than one file will usually not work"
  exit 1
fi

mkdir -m 700 $dir
if test $? -ne 0; then
  echo "Could not create temp dir!"
  exit 1
fi

mkfifo $dir/stream.yuv
i=1
fifo_list=""
while test $i -le $count; do
  fifo_list="$dir/mp$i $fifo_list"
  i=$(($i+1))
done

mkfifo $fifo_list
(cat $dir/stream.y4m | tee $fifo_list > /dev/null ) &

echo "==SLAVES========================"

for fifo in $fifo_list; do
  # -benchmark is neccessary so that it will not do any timing.
  # the master instance already takes care of it and not specifying
  # it will break A-V sync.
  # mplayer -nocache -quiet -benchmark "$fifo" > /dev/null 2>&1 &
  mpv --quiet --cache=no --untimed "$fifo" &
done

echo "==MASTER========================"

mplayer -nocache -fixed-vo -vo yuv4mpeg:file=$dir/stream.yuv "$@"
# mpv -o $dir/stream.y4m  "$@"


rm -rf $dir




# pid=$$
#
# cd /tmp
# mkdir $pid
# cd $pid
#
# mkfifo stream.yuv
# mkfifo mp1
# mkfifo mp2
#
# (cat stream.yuv | tee mp1 > mp2 ) &
# mplayer -nocache -quiet  mp1 & 
# mplayer -nocache -quiet  mp2 &
# mplayer -nocache -vo yuv4mpeg $*
#
# cd ..
# rm -rf $pid

#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!11

# pipes_path=/tmp/$$
#
# mkdir $pipes_path
#
# mkfifo $pipes_path/stream.yuv
# mkfifo $pipes_path/mp1
# mkfifo $pipes_path/mp2
#
# (cat $pipes_path/stream.yuv | tee $pipes_path/mp1 > $pipes_path/mp2 ) &
# mplayer -nocache -quiet  $pipes_path/mp1 & 
# mplayer -nocache -quiet -$pipes_path/mp2 &
# mplayer -nocache -vo yuv4mpeg $*
#
# rm -rf $pipes_path

#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!11

# set -e
#
# dir=/tmp/$$
# count=$1
# shift
#
# if test 0"$count" -lt 1; then
#   echo "At least 1 slave instance must be used."
#   exit 1
# fi
#
# mkdir -m 700 $dir
# if test $? -ne 0; then
#   echo "Could not create temp dir!"
#   exit 1
# fi
#
# mkfifo $dir/stream.yuv
# i=1
# fifo_list=""
# while test $i -le $count; do
#   fifo_list="$dir/mp$i $fifo_list"
#   let i=$i+1
# done
#
# mkfifo $fifo_list
# (cat $dir/stream.yuv | tee $fifo_list > /dev/null ) &
#
# for fifo in $fifo_list; do
#   mplayer -nocache -quiet -benchmark "$fifo" > /dev/null 2>&1 &
# done
#
# mplayer -nocache -vo yuv4mpeg:file=$dir/stream.yuv "$@"
#
#
# rm -rf $dir

#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!11


