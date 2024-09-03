#!/usr/bin/env bash
bk="backup-lojas-antonio";
wdir="home/adenauer";
echo "  " >> /$wdir/$bk/$bk.log;
echo "  " >> /$wdir/$bk/$bk.log;
echo "=================" >> /$wdir/$bk/$bk.log;
date  >> /$wdir/$bk/$bk.log;
if !(rsync -e "ssh -p <porta>" --archive --update --delete --stats <usuario>@<servidor>:/var/www/html /$wdir/$bk/ > /$wdir/$bk/$bk.tmp)
then
echo "Backup nao realizado" >> /$wdir/$bk/$bk.log;
else
#Remove os backups com mais de 5 dias
for d in /$wdir/$bk/versoes; do
  find $d -type f -mtime +5 -exec rm --force '{}' \;
done
cat /$wdir/$bk/$bk.tmp >> /$wdir/$bk/$bk.log;
rm /$wdir/$bk/$bk.tmp
echo " " >> /$wdir/$bk/$bk.log;
echo "Fim rsync:  " >> /$wdir/$bk/$bk.log;
date  >> /$wdir/$bk/$bk.log;
tar -czf /$wdir/$bk/versoes/bkp-lojas-antonio-`date +%Y.%m.%d_%H.%M.%S`.tar.gz /$wdir/$bk/html &>> /$wdir/$bk/$bk.log;
echo " " >> /$wdir/$bk/$bk.log;
echo "Fim criacao versoes:  " >> /$wdir/$bk/$bk.log;
date  >> /$wdir/$bk/$bk.log;
fi
cat /$wdir/$bk/$bk.log | tail -300 > /$wdir/$bk/temp.txt;
mv /$wdir/$bk/temp.txt /$wdir/$bk/$bk.log;
