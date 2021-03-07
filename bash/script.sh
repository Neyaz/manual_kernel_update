#!/usr/bin/env bash

lockfile=/tmp/lockfile

function generate_report () {
  nginx_log="cat $1"
  ip_list_limit=$2
  url_list_limit=$3
  report=./report.txt
  last_line_num=$(wc -l $1 | awk '{print $1}')

  if [[ -e "./last_parsed_line_num" ]]; then
    last_parsed_line=$(cat ./last_parsed_line_num)
    if [[ "$last_parsed_line" = "$last_line_num" ]]; then
      echo "Log file is already parsed."
      exit 2
    else
      nginx_log="tail --lines=+$last_parsed_line $1"
    fi
  fi

  echo "### Report ###" > report

  echo -e "\nTop X IPs:" >> report
  $nginx_log | awk '{print "  " $1}' | sort -nr | uniq -c | sort -rn | head -n $ip_list_limit >> report
  echo "" >> report

  echo "Top Y URL Address:" >> report
  $nginx_log | awk '{print $7}' | sort | uniq -c | sort -nr | head -n $url_list_limit >> report
  echo "" >> report

  echo -e "All errors list:" >> report
  $nginx_log | awk '($9 !~ /200|301/) && $6 ~ /GET|POST|HEAD/' | awk '{print "    "$1" "$4" "$5" "$6" "$7" "$8" "$9}' >> report
  echo "" >> report

  echo -e "\nRequests grouped by CODE:" >> report
  all_codes=$($nginx_log | awk '{print $9}' | sort -u | grep -v -)
  for i in $all_codes; do
    code_count=$($nginx_log | awk '{ print $9}' | grep $i | wc -l; )
    echo "    Code $i requests count - $code_count" >> report
  done;

  echo $last_line_num > ./last_parsed_line_num
}

if [[ -e "$lockfile" ]]; then
  echo "Failed to acquire lockfile: $lockfile."
else
  > $lockfile
  trap 'rm -f "$lockfile" report; exit $?' INT TERM EXIT

  while [ "$#" -gt 0 ]; do
    case "$1" in
      -i) inputfile="$2"; shift 2;;
      -il) iplimit="$2"; shift 2;;
      -ul) urllimit="$2"; shift 2;;

      --inputfile=*) inputfile="${1#*=}"; shift 1;;
      --iplimit=*) iplimit="${1#*=}"; shift 1;;
      --urllimit=*) urllimit="${1#*=}"; shift 1;;
      --email=*) email="${1#*=}"; shift 1;;
      --inputfile|--iplimit|--urllimit|--email) echo "$1 requires an argument" >&2; exit 1;;

      -*) echo "unknown option: $1" >&2; exit 1;;
      *) handle_argument "$1"; shift 1;;
    esac
  done
  
  generate_report $inputfile $iplimit $urllimit
  mail -s "Nginx report" $email < report

  rm -f "$lockfile" report
  trap - INT TERM EXIT
fi
