# BLAST/BLAT/USEARCH(CNGBdb)

## Test-demo

```
BLAST:
    makeblastdb -in DATABASE.fa -dbtype nucl
    blastn -query QUERY.fa -out NAME.blast -db DATABASE.fa -outfmt 6 -evalue 1e-6 -num_threads 10

BLAT:
    blat DATABASE.fa QUERY.fa -out=blast8 blatresult

USEARCH:
    usearch -usearch_global QUERY.fa -db DATABASE.fa -id 0.9 -blast6out hits.b6 \
            -strand plus -maxaccept 8 -maxrejects 256
```

