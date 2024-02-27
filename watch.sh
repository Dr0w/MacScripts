#!/bin/bash
# usage: watch.sh -n <sleep_duration> "<your_command>"

function update_terminal_size {
  cols=$(tput cols)
  rows=$(tput lines)
}

function truncate_command {
  echo "$1" | cut -c1-80
}

if [ "$#" -lt 3 ]; then
  echo "Usage: $0 -n <sleep_duration> \"<your_command>\""
  exit 1
fi

trap update_terminal_size SIGWINCH

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
  
  update_terminal_size

  truncated_command=$(truncate_command "$1")
  echo -n "Every $sleep_duration sec.: $truncated_command"

  tput cup 0 $((cols - 30))
  echo "$(date)"
  
  eval "$1"
  
  sleep "$sleep_duration"
done
