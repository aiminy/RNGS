#!/bin/bash

infile="$1"
gtffile="$2"
qcDataDir="$3"

module load java/1.8.0_60

export _JAVA_OPTIONS="-Xmx36G"

java -jar /nethome/axy148/NGS_tools/QoRTs/QoRTs_1.1.8/QoRTs.jar QC --noGzipOutput --keepMultiMapped "$infile" "$gtffile" "$qcDataDir"
