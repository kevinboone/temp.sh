#!/bin/bash
#
# A simple script to display the temperatures in the various thermal zones on
#   a Linux system. This script demonstrates reading files into variables,
#   and simple string formatting.
#
# Copyright (c)2023 Kevin Boone, GPL v3.0
#

SCT=/sys/class/thermal
printf "%20s   %s\n" zone temp
printf "%20s   %s\n" ------ -----
# We loop over the various thermal_zoneXXX entries.
for zone in `find $SCT -name thermal_zone* -exec basename {} \; `
do
    # Read thermal_zoneXXX/type and thermal_zoneXXX/temp into variables
    type=$(</$SCT/$zone/type)
    temp=$(<$SCT/$zone/temp)
    # $temp could be empty if the file temp could not be read -- this
    #   does actually happen (even if the file exists and has permissions).
    # We could use 'read' here, if we actually wanted to differentiate 
    #   between a read error, and a valid empty response. In this application,
    #   there is no valid empty response, so we don't need to worry about
    #   that complication.
    # If temp can be read, it will be a five-digit number in millicelcius
    if [ ! -z $temp ]; then 
      # Extract the whole-number part of the temperature -- that is,
      #   take the first two digits (and thus divide by 1000)
      temp=${temp:0:2}
      # Print the results, with padding to align them
      printf "%20s   %s\n" $type $temp
    fi
done
