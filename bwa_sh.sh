# 用于BWA比对的脚本(需安装：bwa+samtools)
# 2018\11\29(已验证)

# 建立索引(以hg38为参考基因组为例)
time bwa index hg38.fa
# 比对过程(PE测序，分Lane按顺序跑)
# bwa_args:         -t 线程数
#                   -R 参考基因组
# samtools_args:    -b 将结果压缩为.bam格式
#                   -S 默认输入为.sam格式
#                   -  代表从pipe流出的数据
#                   -q minimum mapping quality
for i in {1..6};do
time bwa mem -t 10 -M /ref_path/hg38 \
/sample_path/L${i}_R1.fastp.fastq.gz \
/sample_path/L${i}_R2.fastp.fastq.gz \
| samtools view -S -b - -q 20 -o \
/result_path/KPGP-00001_L$i.hg38.bam
done
