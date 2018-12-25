# 原始数据质控(需安装：fastqc+Trimmomatic)
# 更新时间：2018\12\25(圣诞节写脚本.jpg)
#Start Directory: $indir
indir=/home/pgstu2/group2/rawdata
outdir=/home/pgstu2/group2
Trimmomatic=/home/pgstu2/group2/biotools/Trimmomatic-0.38
fastqc=/home/pgstu2/group2/biotools/FastQC/fastqc

mkdir /home/pgstu2/group2/fastqc_outdir
mkdir /home/pgstu2/group2/cleandata
cd /home/pgstu2/group2/fastqc_outdir
# 使用FastQC产生质控报告
time $fastqc $indir/*.fq -o fastqc_outdir/ 
# 使用Trimmomatic去除低质量数据
for i in 1 2 3 4 5 6
do
    java -jar $Trimmomatic/trimmomatic-0.38.jar PE \
    $indir/L${i}_R1.fastq.gz $indir/L${i}_R2.fastq.gz \
    $outdir/cleandata/L${i}.paired.1.fq.gz $indir/L${i}.unpaired.1.fq.gz \
    $outdir/cleandata/L${i}.paired.2.fq.gz $indir/L${i}.unpaired.2.fq.gz \
    ILLUMINACLIP:$Trimmomatic/adapters/TruSeq3-PE-2.fa:2:30:10:8:True \
    SLIDINGWINDOW:5:15 LEADING:5 TRAILING:5 MINLEN:50 && echo "** L${i} adapter removed **" &
done

