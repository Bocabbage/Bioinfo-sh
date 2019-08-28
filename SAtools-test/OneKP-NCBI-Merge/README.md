# OneKP/NCBI Merge



## 概述

​	本项目为对CNGBdb中的OneKP数据进行整理，并整合入部分NCBI的植物CDS、Protein数据作为补充，并以为后续物种鉴定及多序列比对用BLAST开发提供测试和应用数据。针对OneKP数据，其官方维护的[网页](https://wiki.cyverse.org/wiki/display/iptol/Sample+names+to+be+changed)中提到了目前数据库中存在一些有待整理的内容，在本项目中也一并考虑并进行订正，最终形成一个命名方式统一的、可用性更高的数据库。



## 原始数据构成

- OneKP-Project:  1,462个CDS样本数据库 + 1422个Protein样本数据库
- NCBI: 引入([Soltis D E, et al. 2018](https://bsapubs.onlinelibrary.wiley.com/doi/full/10.1002/ajb2.1071))中与OneKP-ID有对应关系的样本数据



## Header格式

#### OneKP-Data

```
# CDS
>gnl|onekp|[4chars'ONEKP_ID]-[Seq_ID]-[Species_Name]

# Prot (the same as the CDS)
>gnl|onekp|[4chars'ONEKP_ID]-[Seq_ID]-[Species_Name]
```

#### NCBI-data

```
# CDS
>lcl|[NC_ID]_cds_[NP_ID]-[Species_Name] { [annotation1] ... }

# Prot
>lcl|[NC_ID]_prot_[NP_ID]-[Species_Name] { [annotation1] ... }
```



## OneKP中的数据待整理项

​	OneKP样本中存在一些数据错误、样本杂乱的问题，需要进行数据的清洗整理。

- **存在样本污染或其他原因导致的一个样本数据中含有两个以上的物种信息**

  |      | Current Best Name | Name Used in Files       | Comment                                                      |
  | :--: | ----------------- | ------------------------ | ------------------------------------------------------------ |
  | NWQC | mixed species     | Plagiochila_asplenioides | Plagiochila asplenioides and Fissidens   adianthoides found in voucher |
  | CHJJ | Frullania spp.    | Lejeuneaceae_sp.         | mixed: Frullania inflata (majority) and some   F. Eboracensis found in voucher |
  |      | ...               | ...                      | ...                                                          |



- **基于对序列数据的观察而进行了重分类的样本**

  |      | Current Best Name  | Name Used in Files      | Comments                                  |
  | ---- | ------------------ | ----------------------- | ----------------------------------------- |
  | BMJR | Adiantum raddianum | Adiantum_tenerum        | revised from chloroplast marker sequences |
  | JQFK | Picochlorum atomus | Nannochloropsis_oculata | synonym confusion in original name        |
  |      | ...                | ...                     | ...                                       |

  

- **重新装配错误数据导致的数据弃用**

  OneKP中有部分数据被检测出assembly错误后进行了重新重新装配，仅有seq-id在3000000-3999999范围内的数据可用。

  |      | Species Name           | Additional Description |
  | ---- | ---------------------- | ---------------------- |
  | GDUD | Chloromonas reticulata | B                      |
  | FMRU | Zygnema sp.            | 2 samples combined     |
  |      | ...                    | ...                    |

  

- **未确认原因的重命名 (Please contact Eric Carpenter if you know what happened)**

  |      | Current Best Name       | Name Used in Files    | Comments |
  | ---- | ----------------------- | --------------------- | -------- |
  | LNER | Casuarina equisetifolia | Casuarina_glauca      |          |
  | IOVS | Pseudotsuga wilsoniana  | Pseudotsuga_menziesii |          |
  | ZXJO | Parahemionitis arifolia | Hemionitis_arifolia   |          |

  

- **同义物种命名词替换**

  |      | Current Best Name              | Name Used in Files         | Comments |
  | ---- | ------------------------------ | -------------------------- | -------- |
  | DCDT | Gaga arizonica                 | Cheilanthes_arizonica      |          |
  | LSLA | Euphorbia mesembryanthemifolia | Chamaseyce_mesebyranthemum |          |
  |      | ...                            | ...                        | ...      |

  

- **数据提供者进行命名替换**

  |      | Current Best Name       | Name Used in Files    | Comments |
  | ---- | ----------------------- | --------------------- | -------- |
  | WTJG | Ophioglossum petiolatum | Ophioglossum_vulgatum |          |
  | ZQYU | Phlebodium pseudoaureum | Polypodium_plectolens |          |
  |      | ...                     | ...                   | ...      |

  

- **Sample names中出现了细微变动**

  |      | Current Best Name   | Name Used in Files  | Comments |
  | ---- | ------------------- | ------------------- | -------- |
  | NWMY | Kadsura heteroclita | Kadsura_heteroclite |          |
  | HUGU | Boerhavia dominii   | Boerhavia_dominnii  |          |
  |      | ...                 | ...                 | ...      |

  

## 数据处理流程

