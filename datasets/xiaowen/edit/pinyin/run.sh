#!/bin/bash
python trans_pinyin2ipa.py
cat pinyin_2_ipa|awk -F"\t" 'BEGIN{while (getline <"./pinyin_fix" >0){split($0,a,"\t");dict[a[1]]=a[2]}}{if($1 in dict)printf dict[$1];else printf $1;print "\t"$2"\t"$3"\t"$4}'>pinyin_2_ipa_fix
sh trans_corpus.sh
