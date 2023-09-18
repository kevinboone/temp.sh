# temp.sh

Kevin Boone, September 2023

This is a simple script to display the temperatures in the various thermal
zones on a Linux system. It demonstrates reading files into variables, and
simple string formatting.

The output looks like this although, of course, it will differ according
to the installed hardware.

                zone   temp
              ------   -----
              acpitz   42
        x86_pkg_temp   43
         pch_skylake   46

Modern Linux systems collect thermal information from a number of different
sensors. Each has an directory entry in `/sys/class/thermal`, whose name is of
the form `thermal_zoneXXX`. Within each of these directories there is a
pseudofile `type`, which gives the name of the zone and `temp`, which gives the
temperature.

It is an oddity of this scheme that the file `temp` may exist, and may have
read permissions, but still not be readable. Any script that formats
temperature data needs to take this into account.

If the temperature can be read, it will be a five-digit number in millicelsius.
To convert this into an ordinary temperature, we just divide by 1000. That's
easy in this case -- we just dump the three bottom digits. This approach to
division only works if the temperatures are five digits long but, according to
the kernel documentation, they always are.

There is no consistency in the zone names. In general, `x86_pkg_temp` is the
CPU die temperature, and is probably the reading we are most concerned about.
`acpitz` is usually a sensor on the motherboard, close to the CPU, so it will
usually read just a little lower than the CPU temperature. All the other
sensors are hardware-specific, and little can be said about their
interpretation that is generally applicable. 


