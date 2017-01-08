GetFastqFiles<-function(input.fastq.file.dir) {

   print(input.fastq.file.dir)

   re<-cbind(paste0(input.fastq.file.dir,dir(input.fastq.file.dir,pattern = "_1.fastq")),
   paste0(input.fastq.file.dir,dir(input.fastq.file.dir,pattern = "_2.fastq")))

   return(re)

}
