#!/bin/sh
# shell script to prepend i3status with more stuff

# This better be the same as the i3status update interval.
# Also hopefully 60 divides equally into it.
# TODO we can infer this if we're smarter.
INTERVAL=5 

# Typically WPM is the character per minute divided by 5.
WPM_THING=5

TMP_FILE=/tmp/cpm_count_$(uuidgen)

# TODO kill this when the script is killed
xinput test-xi2 | \grep RawKeyPress --line-buffered -A 2 | awk -f <(cat - <<-'EOD'
# Ignore the other 2 lines.
/ detail: 50 / {next} # Ignore Shifts
/ detail: 22 / {next} # Ignore Backspaces
/ detail: / {print ""; fflush(stdout)}
EOD
) > $TMP_FILE &

i3status | while :
do
        read line
        CHARS=$(wc -l < $TMP_FILE)
        > $TMP_FILE

        WPM=$(($CHARS * (60 / $INTERVAL) / $WPM_THING))

        echo "wpm $WPM | $line" || exit 1
done
