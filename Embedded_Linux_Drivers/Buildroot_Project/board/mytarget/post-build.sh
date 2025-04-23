#!/bin/sh
# Set up .xsession for Edges user
mkdir -p ${TARGET_DIR}/home/Edges
echo "exec fluxbox" > ${TARGET_DIR}/home/Edges/.xsession
chmod +x ${TARGET_DIR}/home/Edges/.xsession
chown 1000:1000 ${TARGET_DIR}/home/Edges/.xsession

# Configure nodm
echo "NODM_ENABLED=true" > ${TARGET_DIR}/etc/nodm.conf
echo "NODM_USER=Edges" >> ${TARGET_DIR}/etc/nodm.conf

# Minimal xorg.conf for PL111
cat > ${TARGET_DIR}/etc/X11/xorg.conf <<EOF
Section "Device"
    Identifier "PL111"
    Driver "fbdev"
EndSection
Section "Screen"
    Identifier "Screen0"
    Device "PL111"
EndSection
EOF

