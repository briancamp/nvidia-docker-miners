# Name used to identify rig
export me="$(hostname -s | sed -r 's/[^0-9a-zA-Z]//g')"

# Append these default paths, incase we're running from an init
# that doesn't.
export PATH="$PATH":/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
