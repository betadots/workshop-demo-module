#!/bin/sh

echo $PT_ausgabe > /tmp/test
cat /tmp/test
rm -f /tmp/test
