# 数据BQSR 产生变异分析结果(需安装：GATK4+samtools)
# 更新时间：2018\12\25
#Start Directory: $outdir/cleandata
samtools=/home/pgstu2/group2/biotools/samtools
gatk=/home/pgstu2/group2/biotools/gatk-4.0.11.0/gatk
reference=/home/pgstu1/group0/reference/index/hg19.fasta
outdir=/home/pgstu2/group2/output

# BQSR
time $gatk BaseRecalibrator \
-R $reference \
-I ${outdir}/cleandata/KPGP-00001.hg19.sorted.markdup.bam \
--known-sites $GATK_bundle/1000G_phase1.indels.hg19.sites.vcf \
--known-sites $GATK_bundle/Mills_and_1000G_gold_standard.indels.hg19.sites.vcf \
--known-sites $GATK_bundle/dbsnp_138.hg19.vcf \
-O ${outdir}/cleandata/KPGP-00001.hg19.sorted.markdup.recal_data.table && \
echo "** $KPGP-00001.hg19.sorted.markdup.recal_data.table done **"

time $gatk ApplyBQSR \
--bqsr-recal-file ${outdir}/cleandata/KPGP-00001.hg19.sorted.markdup.recal_data.table \
-R $reference \
-I ${outdir}/cleandata/KPGP-00001.hg19.sorted.markdup.bam \
-O ${outdir}/cleandata/KPGP-00001.hg19.sorted.markdup.BQSR.bam && \
echo "** ApplyBQSR done **"

# 产生变异文件(.vcf)
time samtools index ${outdir}/cleandata/KPGP-00001.hg19.sorted.markdup.BQSR.bam
mkdir $outdir/gatk

for i in chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8
do
    time $gatk HaplotypeCaller \
    -R $reference \
    -I ${outdir}/cleandata/KPGP-00001.hg19.sorted.markdup.BQSR.bam \
    -L $i \
    -O ${outdir}/gatk/KPGP-00001.hg19.HC.${i}.vcf.gz && echo "** KPGP-00001.hg19.HC.${i}.vcf.gz done **" &
done && wait
for i in chr9 chr10 chr11 chr12 chr13 chr14 chr15 chr16
do
    time $gatk HaplotypeCaller \
    -R $reference \
    -I ${outdir}/cleandata/KPGP-00001.hg19.sorted.markdup.BQSR.bam \
    -L $i \
    -O ${outdir}/gatk/KPGP-00001.hg19.HC.${i}.vcf.gz && echo "** KPGP-00001.hg19.HC.${i}.vcf.gz done **" &
done && wait
for i in chr17 chr18 chr19 chr20 chr21 chr22 chrX chrY
do
    time $gatk HaplotypeCaller \
    -R $reference \
    -I ${outdir}/cleandata/KPGP-00001.hg19.sorted.markdup.BQSR.bam \
    -L $i \
    -O ${outdir}/gatk/KPGP-00001.hg19.HC.${i}.vcf.gz && echo "** KPGP-00001.hg19.HC.${i}.vcf.gz done **" &
done && wait

chrom=( chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10 chr11 chr12 chr13 chr14 chr15 chr16 chr17 chr18 chr19 chr20 chr21 chr22 chrX chrY )
merge_vcfs=""
for i in ${chrom[@]}
do
    merge_vcfs = ${merge_vcfs}" -I ${outdir}/gatk/$KPGP-00001.HC.${i}.vcf.gz "
done
time $gatk MergeVcfs ${merge_vcfs} \
-O ${outdir}/gatk/KPGP.HC.vcf.gz && echo "** MergeVcfs done **"

