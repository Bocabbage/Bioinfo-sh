# 注释变异结果(需安装:SnpEff/annovar)
# 更新时间：2018\12\12(已验证)
# 更新时间：2018\12\27(增加查看SNP变异总结列表)
# 工作目录：/home/pgstu2/group2
snpEff=/home/pgstu2/group2/biotools/snpEff
annovar=/home/pgstu2/group2/biotools/annovar
vcf=/home/pgstu2/group2/cleanvcf


# SnpSift 添加变异分类Tag
# .varType内容与.vcf基本相同，仅添加变异分类信息
time java -jar $snpEff/SnpSift.jar \
varType $vcf/KPGP.HC.filter.dbSNP.vcf.gz > \
$vcf/KPGP.HC.filter.dbSNP.varType 

# Annovar 注释vcf
# 利用GWAS数据库对检测到变异进行注释
# .annovar文件为变异分类信息
# ex1.hg19_gwasCatalog为注释结果

# 变异分类
time $annovar/convert2annovar.pl -format vcf4old \
$vcf/KPGP.HC.filter.dbSNP.vcf > \
$vcf/KPGP.HC.filter.dbSNP.annovar 
# 下载GWAS注释数据库
#time perl $annovar/annotate_variation.pl -downdb \
#-buildver hg19 \
#-webfrom annovar \
#refGene humandb/
time $annovar/annotate_variation.pl \
-build hg19 \
-downdb gwasCatalog humandb/ 
# 结果存储目录
mkdir annotate_result
cd annotate_result
# 得到ex1.hg19_gwasCatalog即为注释结果
time $annovar/annotate_variation.pl \
-regionanno -build hg19 \
-out ex1 -dbtype gwasCatalog \
$vcf/KPGP.HC.filter.dbSNP.annovar humandb/

# 查看得到的注释结果总结：
#cut -f 2 ex1.hg19_gwasCatalog | sort | uniq -c | sort -k1 -n -r | less

