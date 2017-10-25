#!/bin/bash
#:<<BLOCK
#step 1 : find oov
cat alignment.json |\
awk -F": " 'BEGIN{
	while (getline <"CMU.in.IPA.txt" >0){
		split($0,a,"	")
		dict[a[1]]=a[2]
	}
}{\
	gsub("^\"","",$2);
	gsub(" \",","",$2);
	gsub(" \"","",$2);
	print tolower($2)
	gsub(/-/," ",$2)
	split($2,a," ")
	for(i=1;i<=length(a);i++){
		word = tolower(a[i])
		if(word in dict)
			printf dict[word]" "
		else if(match(word,",$")){
			gsub(/,$/,"",word)
			if(word in dict){
				printf dict[word]", "
			}
		}else if(match(word,/\.$/)){
			gsub(/\.$/,"",word)
			if(word in dict){
				printf dict[word]". "
			}
		}else if(match(word,/\?$/)){
			gsub(/\?$/,"",word)
			if(word in dict){
				printf dict[word]"? "
			}
		}else if(match(word,/\!$/)){
			gsub(/\!$/,"",word)
			if(word in dict){
				printf dict[word]"? "
			}
		}else if(match(word,/;$/)){
			gsub(/;$/,"",word)
			if(word in dict){
				printf dict[word]"; "
			}
		}else
			printf "【"word"】 "
			
	}
	print ""
}'| grep -o "【[^】]*】" |sort -u  |sed "s/【//" |sed "s/】//" >cmu.oov
#BLOCK
#step 2 : trans oov to ipa
cat 5153.dict |sed "s/  /\t/" |\
awk -F"\t" 'BEGIN{
	while(getline <"./cmu2ipa.dict" >0){
		gsub(//,"",$0)
		split($0,a,"\t");
		dict[a[1]]=a[2]
#print (a[1],a[2])
	}
}{
	printf tolower($1)"\t";
	split($2,a," ");
#print("length ",length(a))
	for(i=1;i<=length(a);i++){
#printf("["a[i]"]")
		if(a[i] in dict){
			printf dict[a[i]]
		}else{
			print "ERROR!!!!";
		}
	}
	print ""
}' > "CMU.in.IPA.plus.txt"
#step 3 : retrans full text to ipa
cat alignment.json |\
awk -F": " 'BEGIN{
	while (getline <"CMU.in.IPA.txt" >0){
		split($0,a,"	")
		dict[a[1]]=a[2]
	}
	while (getline <"CMU.in.IPA.plus.txt" >0){
		split($0,a,"	")
		dict[a[1]]=a[2]
	}
}{\
	gsub("^\"","",$2);
	gsub(" \",","",$2);
	gsub(" \"","",$2);
	printf $1": \""
	gsub(/-/," ",$2)
	split($2,a," ")
	for(i=1;i<=length(a);i++){
		word = tolower(a[i])
		if(word in dict)
			printf dict[word]" "
		else if(match(word,",$")){
			gsub(/,$/,"",word)
			if(word in dict){
				printf dict[word]", "
			}
		}else if(match(word,/\.$/)){
			gsub(/\.$/,"",word)
			if(word in dict){
				printf dict[word]". "
			}
		}else if(match(word,/\?$/)){
			gsub(/\?$/,"",word)
			if(word in dict){
				printf dict[word]"? "
			}
		}else if(match(word,/\!$/)){
			gsub(/\!$/,"",word)
			if(word in dict){
				printf dict[word]"? "
			}
		}else if(match(word,/;$/)){
			gsub(/;$/,"",word)
			if(word in dict){
				printf dict[word]"; "
			}
		}else
			printf "【"word"】 "
			
	}
	print "\","
}' >alignment.ipa.json
