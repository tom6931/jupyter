#!/bin/bash
# run.sh: Run BLAST from its docker image.
#
# Author: Christiam Camacho (camacho@ncbi.nlm.nih.gov)
# Created: Mon 10 Jun 2019 12:18:33 PM EDT

set -euo pipefail
shopt -s nullglob

PLASMIDS_DB=Plasmids_562
AMR_GENE=MH168512.fsa
BLAST_RESULTS=MH168512.out

curl -sO https://ftp.ncbi.nlm.nih.gov/blast/demo/${PLASMIDS_DB}.fsa

docker run --rm -v `pwd`:/blast/blastdb:rw -w /blast/blastdb \
    ncbi/blast \
    makeblastdb -in ${PLASMIDS_DB}.fsa -dbtype nucl -parse_seqids -taxid 562 \
    -out ${PLASMIDS_DB}

curl -sO https://ftp.ncbi.nlm.nih.gov/blast/demo/${AMR_GENE}

docker run --rm -v `pwd`:/blast/blastdb:rw -w /blast/blastdb \
    ncbi/blast \
    blastn -db ${PLASMIDS_DB} -query ${AMR_GENE} -max_target_seqs 5000 \
    -out ${BLAST_RESULTS} \
    -outfmt "6 qseqid sseqid stitle pident qcovs length mismatch gapopen qstart qend sstart send qframe sframe frames evalue bitscore qseq sseq"

head ${BLAST_RESULTS}

curl -sO https://raw.githubusercontent.com/fomightez/sequencework/master/blast-utilities/blast_to_df.py

virtualenv -ppython3 .venv 
source .venv/bin/activate
pip install pandas

python3 blast_to_df.py ${BLAST_RESULTS}

python3 -e 'import pandas as pd; df = pd.read_pickle("BLAST_pickled_df.pkl"); df.head(); '

python3 -e 'import pandas as pd; df = pd.read_pickle("BLAST_pickled_df.pkl"); df["sseqid"].count(); '
