# -*- coding:utf-8 -*-
import sys
import re
import os
f_ipa = open("ipa",'r')
f_ipa2 = open("ipa2",'w')
f_dict = open("ipa_dict",'w')

#####################################step 1
dict = {}
line = f_ipa.readline()
while line:  
  line=line.strip('\n').strip('\r')
  line, number = re.subn("5\t","0\t", line)
  op_line=line+"\t"
  for c in (line).split('\t')[1].decode('utf-8'):
    op_line += c.encode('utf-8')+" "

  op_line, number = re.subn("˥ ˥","5 5", op_line)
  op_line, number = re.subn("˧ ˥","3 5", op_line)
  op_line, number = re.subn("˨ ˩ ˦","2 1 4", op_line)
  op_line, number = re.subn("˥ ˩","5 1", op_line)
  op_line, number = re.subn(" ˧","", op_line)
  op_line, number = re.subn(" $","", op_line)
  op_line+="\n"
  #sys.stdout.write(op_line)
  f_ipa2.write(op_line)
  for c in (op_line).split('\t')[2].decode('utf-8'):
    if(c!=" " and c!="\t" and c!="\n"):
      dict[c.encode('utf-8')]='1'
  line = f_ipa.readline()  

#####################################step 2
dict_ipa_ascii={}
idx_L='A'
for c in dict:
  if((c>='a' and c<='z')or(c>='0' and c<='9')):
    dict_ipa_ascii[c]=c
    f_dict.write(c+"\t"+c+"\n")
  else:
    dict_ipa_ascii[c]=idx_L
    f_dict.write(c+"\t"+idx_L+"\n")
    idx_L=chr(ord(idx_L)+1)
f_ipa.close()  
f_ipa2.close()
f_dict.close()  

#####################################step 3
f_ipa2 = open("ipa2",'r')
f_ipa3 = open("pinyin_2_ipa",'w')
line = f_ipa2.readline()
while line:  
  line=line.strip('\n').strip('\r')
  ipa_ascii=""
  for c in (line).split('\t')[2].decode('utf-8'):
    if(c!=" "):
      ipa_ascii += dict_ipa_ascii[c.encode('utf-8')]
  output=line+"\t"+ipa_ascii+"\n"
  f_ipa3.write(output)

  line = f_ipa2.readline()  

f_ipa2.close()
f_ipa3.close()
