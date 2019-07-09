# BLAST/BLAT/USEARCH(CNGBdb)

## Test-demo

```
BLAST:
    makeblastdb -in DATABASE.fa -dbtype nucl
    blastn -query QUERY.fa -out NAME.blast -db DATABASE.fa -outfmt 6 -evalue 1e-6 -num_threads 10

BLAT:
    blat DATABASE.fa QUERY.fa -out=blast8 blatresult

USEARCH:
    usearch11.0.667_i86linux32 -usearch_global QUERY.fa -db DATABASE.fa -id 0.9 -blast6out hits.b6 \
            -strand plus -maxaccepts 8 -maxrejects 256
```

