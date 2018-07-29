#!/bin/bash -x
# Usage: force the fans to run under minimal speed 
# works on IBM IMM2 only, e.g. System X3630M4 
# 0x3a is netfn, aka. OEM command, 
# 0x07 is command,
# 0x01/02/03 is channel, aka. Fan ID, there're 3 groups of fans on X3630M4
# 0x00~FF is percent of speed
# 0x01 Unknown
/usr/bin/ipmitool raw 0x3a 0x07 0x01 0x00 0x01
/usr/bin/ipmitool raw 0x3a 0x07 0x02 0x00 0x01
/usr/bin/ipmitool raw 0x3a 0x07 0x03 0x00 0x01
