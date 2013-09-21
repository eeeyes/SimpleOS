#!/bin/bash


source constants.sh
echo "%define MESSAGE \"${MESSAGE}\"" > auto.inc
echo "%define SYS_LEN_SECTORS  $(( ($SYS_LEN_BYTES)/512 )) " >> auto.inc
echo "%define SYS_LEN_BYTES $(( SYS_LEN_BYTES ))" >> auto.inc
