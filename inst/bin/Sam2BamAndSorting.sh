#!/bin/bash

CmdEachSample = "$1"
Ncores = "$2"

samtools view -bS -@ $Ncores "CmdEachSample"Aligned.out.sam | samtools sort -@ $Ncores - "$CmdEachSample"STAR_out.sorted
