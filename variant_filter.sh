# 用于.vcf(.gz)文件硬过滤(需安装：GATK4 SnpSift)
# 更新时间：2018\12\18(已验证)
# 更新时间：2018\12\19(增加SnpSift注释vcf的内容：注释rs号)
gatk=/home/pgstu1/group0/database/gatk-4.0.11.0/gatk
snpEff=/home/pgstu2/group2/snpEff
resource=/home/pgstu1/group0/Data/gatk
results=/home/pgstu2/group2
# 由于对SNP和INDEL的硬过滤标准不同，需先拆分过滤再合并
# Filter标准：
# QD(QualByDepth)：单位深度的变异质量值
# FS(FisherStrand)：Fisher检验p-value转换值
# SOR(StrandOddsRatio)：链特异性校正
# MQ(RMSMappingQuality)：该位点上的read的比对质量值的均方根


# 从.vcf中提取SNP
time $gatk SelectVariants \
-select-type SNP \
-V $resource/KPGP.HC.vcf.gz \
-O $results/KPGP.HC.snp.vcf.gz
# 对SNP进行硬过滤
time $gatk VariantFiltration \
-V $results/KPGP.HC.snp.vcf.gz \
--filter-expression "QD < 2.0 || MQ < 40.0 || FS > 60.0 || SOR > 3.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0" \
--filter-name "Filter" \
-O $results/KPGP.HC.snp.filter.vcf.gz
# 从.vcf中提取Indel
time $gatk SelectVariants \
-select-type INDEL \
-V $resource/KPGP.HC.vcf.gz \
-O $results/KPGP.HC.indel.vcf.gz
# 对Indel进行硬过滤
time $gatk VariantFiltration \
-V $results/KPGP.HC.indel.vcf.gz \
--filter-expression "QD < 2.0 || FS > 200.0 || SOR > 10.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0" \
--filter-name "Filter" \
-O $results/KPGP.HC.indel.filter.vcf.gz
# 合并过滤结果
time $gatk MergeVcfs \
-I $results/KPGP.HC.indel.filter.vcf.gz \
-I $results/KPGP.HC.snp.filter.vcf.gz \
-O $results/KPGP.HC.filter.vcf.gz

# 下载dbSNP库参考内容
cd $results
mkdir ref
cd ref

wget ftp://ftp.ncbi.nih.gov/snp/organisms/human_9606_b150_GRCh37p13/VCF/\
All_20170710.vcf.gz

wget ftp://ftp.ncbi.nih.gov/snp/organisms/human_9606_b150_GRCh37p13/VCF/\
All_20170710.vcf.gz.tbi

gzip -d $results/KPGP.HC.filter.vcf.gz

# rs号注释
time java -jar $snpEff/SnpSift.jar \
annotate $results/ref/All_20170710.vcf.gz \
$results/KPGP.HC.filter.vcf \
> $results/KPGP.HC.filter.dbSNP.vcf &