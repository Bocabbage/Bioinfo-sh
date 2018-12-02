# 用于变异分析前处理的脚本(需安装：samtools+GATK4)
#2018\12\2(已验证)

# 排序
time samtools sort -@ 10 -O bam -o \
/results_path/Sequence.sorted.bam \
/results_path/Sequence.bam

# 标记PCR重复
time /Tools_path/gatk MarkDuplicates -I \
/results_path/Sequence.sorted.bam -O \
/results_path/Sequence.sorted.markdup.bam -M \
/results_path/Sequence.sorted.markdup_metrics.txt

# 创建比对索引
time samtools index /results_path/Sequence.sorted.markdup.bam