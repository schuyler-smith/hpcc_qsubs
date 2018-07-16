#!/bin/bash

usage(){
cat << EOF
USAGE: int.sh <integer>

EOF
}

while getopts ":ht" OPTION; do
     case $OPTION in
         h)
            usage
            exit 1
            ;;
         t)
            time=1
            ;;
         :)
			echo "Option -$OPTARG requires an argument." >&2
      		exit 1
			;;
         ?) echo "Invalid option: -$OPTARG\\nUse \"sh $0 -h\" to see usage and list of legal arguments." >&2
            exit 1
            ;;
     esac
done

shift $((OPTIND -1))

time=$1
while [ -z "$time" ]
do read -p "How many hours do you need?:  " time
done


echo "qsub -I -l nodes=1:ppn=20,mem=64gb,walltime=$time:00:00 -N myjob"
qsub -I -l nodes=1:ppn=20,mem=64gb,walltime=$time:00:00 -N myjob -M sdsmith@iastate.edu -m abe -A colej


