# 用于变异分析前处理的脚本(需安装：samtools+GATK4)
# 更新时间：2018\12\2(已验证)
# 更新时间：2018\12\15 模块化
# 更新时间：2018\12\25 
# 存疑1：samtools merge or gatk-MergeSamFiles
# 存疑2：samtools merge与排序/去重的先后顺序问题
reference=/home/pgstu1/group0/reference/index/hg19.fasta
outdir=/home/pgstu2/group2/output
samtools=/home/tools/samtools
gatk=/home/pgstu2/group2/biotools/gatk-4.0.11.0/gatk

#Start Directory: $outdir/cleandata
mkdir temp

# 排序
for i in {1..6};do
time $samtools sort -@ 10 -O bam -o \
$outdir/cleandata/KPGP-00001_L$i.hg19.sorted.bam \
$outdir/cleandata/KPGP-00001_L$i.hg19.bam
done

# 标记PCR重复
for i in {1..6};do
time $gatk MarkDuplicates -I \
$outdir/cleandata/KPGP-00001_L$i.hg19.sorted.bam -O \
$outdir/cleandata/KPGP-00001_L$i.hg19.sorted.markdup.bam -M \
$outdir/cleandata/KPGP-00001_L$i.hg19.sorted.markdup_metrics.txt
done

cd $outdir/cleandata

# Merge
$samtools merge KPGP-00001.hg19.sorted.markdup.bam \
KPGP-00001_L1.hg19.sorted.markdup.bam \
KPGP-00001_L2.hg19.sorted.markdup.bam \
KPGP-00001_L3.hg19.sorted.markdup.bam \
KPGP-00001_L4.hg19.sorted.markdup.bam \
KPGP-00001_L5.hg19.sorted.markdup.bam \
KPGP-00001_L6.hg19.sorted.markdup.bam

# 创建比对索引
$samtools index KPGP-00001.hg19.sorted.markdup.bam