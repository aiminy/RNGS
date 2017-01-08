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

    cat("Do you want to convert SRA files to fastq files?\n")

    input<-file('stdin', 'r')
    row <- readLines(input, n=1)

    print(row)

    if(row=="Yes") {

      cat("please give input SRA file:\n")

      input<-file('stdin', 'r')
      input.file.dir <- readLines(input, n=1)

      #input.file.dir=row

      cat("please define the output file directory for this conversion:\n")

      input<-file('stdin', 'r')
      output.file.dir <- readLines(input, n=1)

      R_lib=.libPaths()[1]

      cmd1="bsub -P bbc -J \"fastq-dump\" -o %J.fastq-dump.log -e %J.fastq-dump.err -W 72:00 -n 8 -q general -u aimin.yan@med.miami.edu"
      cmd2=paste0("fastq-dump --split-3 ",input.file.dir," ","-O ",output.file.dir)

      system(paste0(cmd1," ",cmd2))

      #cmd2=paste0()
      #system(cmd2)

      system("wait")
      cat("Finished converting SRA ...\n")

    }else{

      cat("Do you want to use STAR to perform alignment?\n")

      input<-file('stdin', 'r')
      row <- readLines(input, n=1)

      print(row)

      if(row=="Yes") {


        cat("Is your RNA-Seq data un-stranded?\n")

        input<-file('stdin', 'r')
        row <- readLines(input, n=1)

        if(row=="Yes"){
          strand="--outSAMstrandField introMotif"
        }else
        {
         strand=""
        }

        cat("please give input fastq file dir:\n")
        #/projects/scratch/bbc/GOSJ/ExampleData/
        input<-file('stdin', 'r')
        input.file.dir <- readLines(input, n=1)

        library(RNGS)
        re<-GetFastqFiles(input.file.dir)

        #print(class(re))
        #print(dim(re))
        #print(re)

         cat("please specify gene annotation file(GTF):\n")
         #/nethome/yxb173/Genome_Ref/Homo_sapiens/UCSC/hg38/Annotation/Genes/genes.gtf
         input<-file('stdin', 'r')
         input.gtf.file <- readLines(input, n=1)

         cat("please specify STARindex file :\n")
         #/nethome/yxb173/Genome_Ref/Homo_sapiens/UCSC/hg38/Sequence/STARIndex/
         input<-file('stdin', 'r')
         STAR.index.file <- readLines(input, n=1)


         cat("please define the output file directory for this alignment:\n")
         #/projects/scratch/bbc/GOSJ/ExampleData/
         input<-file('stdin', 'r')
         output.file.dir <- readLines(input, n=1)
        #
        # R_lib=.libPaths()[1]

         cat("please define the number of core to be used:\n")
         #8
         input<-file('stdin', 'r')
         Ncores <- readLines(input, n=1)


          cmd1="bsub -P bbc -J \"STAR-alignment\" -o %J.STAR-alignment.log -e %J.STAR-alignment.err -W"
          cmd2="72:00 -n 8 -q bigmem -R 'rusage[mem=36864] span[hosts=1]' -u aimin.yan@med.miami.edu"

          cmd3=paste("STAR",strand,"--genomeLoad NoSharedMemory --runThreadN",Ncores,"--sjdbGTFfile",collapse = " ")
          cmd4=paste(input.gtf.file,"--outFileNamePrefix",paste0(output.file.dir,"/STAR_"),"--genomeDir",STAR.index.file,collapse = " ")

          for(i in 1:dim(re)[1]){
           cmd5=paste("--readFilesIn",re[i,1],re[i,2],collapse = " ")
           system(paste(cmd1,cmd2,cmd3,cmd4,cmd5,collapse = " "))
          }

        # #cmd2=paste0()
        # #system(cmd2)
        #
        # system("wait")
        # cat("Finished converting SRA ...\n")

      }else{
           quit()}
    }

  }
