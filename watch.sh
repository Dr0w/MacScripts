#!/bin/bash
# usage: watch.sh -n <sleep_duration> "<your_command>"

if [ "$#" -lt 3 ]; then
  echo "Usage: $0 -n <sleep_duration> \"<your_command>\""
  exit 1
fi

while getopts "n:" opt; do
  case $opt in
    n)
      sleep_duration="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      echo "Usage: $0 -n <sleep_duration> \"<your_command>\""
      exit 1
      ;;
  esac
done

shift $((OPTIND-1))

while :
do
  clear
  date
  eval "$1"
  sleep "$sleep_duration"
done
