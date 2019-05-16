# 用于BWA比对的脚本(需安装：bwa+samtools)
# 更新时间：2018\11\29(已验证)
# 更新时间：2018\12\15 变量替代、建立目录使其成为流程模块，完善注释
reference=/home/pgstu1/group0/reference/index/hg19.fasta
outdir=/home/pgstu2/group2/output
bwa=/home/tools/bwa
samtools=/home/tools/samtools


#Start Directory: $outdir/cleandata
mkdir bwa_results
# 建立索引(以hg38为参考基因组为例)
time bwa index $reference
# 比对过程(PE测序，分Lane按顺序跑)
# bwa_args:         -t 线程数
#                   -R 参考基因组
#                   -M Mark shorter split hits as secondary (for Picard compatibility).
# samtools_args:    -b 将结果压缩为.bam格式
#                   -S 默认输入为.sam格式
#                   -  代表从pipe流出的数据
#                   -q minimum mapping quality
for i in {1..6};do
time $bwa mem -t \
-R "@RG\tID:Lane${i}\tLB:00001\tSM:KPGP\tPL:ILLUMINA" \
-t 10 -M $reference \
$outdir/cleandata/L${i}.paired.1.fq.gz \
$outdir/cleandata/L${i}.paired.2.fq.gz \
| $samtools view -S -b - -q 20 -o \
$outdir/bwa_results/KPGP-00001_L$i.hg19.bam
done
