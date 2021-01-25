Current idea: python script takes stdin as input, stdin contains newline for every keystroke.
(xinput test 13 | awk '/press/ {print $0}')
count newlines from ipnut (while true; input() (increment counter) ?)
Python script invokes i3status and monitors output.
every time i3status gives new output, prepend the wpm based on number of inputs() (above) and echo to stdout.

