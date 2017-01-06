#!/usr/bin/Rscript

#Usage:

#R CMD INSTALL RNGS_0.1.0.tar.gz

#Rscript  Rscript ~/R/lib64/R/library/RNGS/bin/RNGS.r

  cat("Do you want to download SRA files?\n")

  input<-file('stdin', 'r')
  row <- readLines(input, n=1)

  print(row)

  if(row=="Yes") {

    cat("please defne the url:\n")

    input<-file('stdin', 'r')
    input.file.dir <- readLines(input, n=1)

    #input.file.dir=row

    cat("please defne the output file directory:\n")

    input<-file('stdin', 'r')
    output.file.dir <- readLines(input, n=1)

    #out.file.dir=row

    #cat("please defne genome name:\n")

    #input<-file('stdin', 'r')
    #genome <- readLines(input, n=1)

    R_lib=.libPaths()[1]

    cmd1="bsub -P bbc -J \"RunRNGS\" -o %J.RunRNGS.log -e %J.RunRNGS.err -W 72:00 -n 8 -q general -u aimin.yan@med.miami.edu"
    cmd2=paste0("wget -c -r -nd -np -L ",input.file.dir," ","-P ",output.file.dir)

    system(paste0(cmd1," ",cmd2))

#    cmd2=paste0()

#    system(cmd2)

    cat("Finished downloading SRA ...\n")

  }else{
        quit()
  }
