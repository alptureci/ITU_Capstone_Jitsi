#!/bin/bash

RECORDINGS_DIR=$1
OUTPUT_LOG='/home/jibri/recordings/finalize.out'
#OUTPUT_LOG='/tmp/finalize.out'

if ! [ -f OUTPUT_LOG ]; then
    echo "$OUTPUT_LOG doesn't exist!";
    echo "Creating $OUTPUT_LOG";
    echo "$OUTPUT_LOG file is created at $(date)";
fi

#echo "This is a dummy finalize script" > $OUTPUT_LOG
echo "New Recording added $(date)" > $OUTPUT_LOG
echo "The script was invoked with recordings directory $RECORDINGS_DIR." >> $OUTPUT_LOG
echo "You should put any finalize logic (renaming, uploading to a service" >> $OUTPUT_LOG
echo "or storage provider, etc.) in this script" >> $OUTPUT_LOG

#python3 /Users/atureci/Documents/ITU/SWE690_CapstoneProject/JitsiCodeBase/aws/push2aws.py -s p -f $RECORDINGS_DIR
python3 /var/www/capstone/code/aws/push2aws.py -s p -f $RECORDINGS_DIR

#cat $OUTPUT_LOG

exit 0
