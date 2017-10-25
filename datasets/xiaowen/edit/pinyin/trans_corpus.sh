#!/bin/bash
:<<BLOCK
#cat metadata_PyinYin.csv |awk -F"|" '{split($2,a," ");for(i=1;i<=length(a);i++){gsub(/,/,"",a[i]);gsub(/\./,"",a[i]);dict[a[i]]=1}}END{for(i in dict)print i}' |sort >py_
cat ./py_ | awk -F"\t" '\
BEGIN{
	while(getline <"./pinyin_2_ipa" >0){
		split($0,a,"\t");
		dict[a[1]]=1
	}
}{
	if (!($1 in dict))
		print $0
}'>py2
BLOCK

#:<<BLOCK
cat metadata_PyinYin.csv | awk -F"|" ' BEGIN{
	while(getline < "./pinyin_2_ipa_fix" >0){
		split($0,b,"\t");
#dict[b[1]]=b[4]
		dict[b[1]]=b[2]
	}
}{
	gsub(/,/," , ",$0)
	gsub(/\./," . ",$0)
	split($2,a," ");
	printf $1"|";
	for(i=1;i<=length(a);i++){
		if(a[i] in dict){
			printf dict[a[i]]" "
		}else if(a[i]=="," ||a[i]=="." ){
			printf a[i]" "
		}else {
			printf "ERROR!!!!\t("
			printf a[i]
			print ")"
		}
	}
	print""
}'|awk '{gsub(/ , /,", ",$0);gsub(/ \. /,".",$0);print $0}' > metadata.csv
#BLOCK
