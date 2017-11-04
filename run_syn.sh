#!/bin/bash
export CUDA_VISIBLE_DEVICES=''
#python3 synthesizer.py \
#			--initialize_path logs/xiaowen+nancy_2017-10-25_07-41-02 \
#			--data_path=datasets/xiaowen,datasets/nancy 
#--text_path "ttt" \
#--speaker_id 1 \

#export CUDA_VISIBLE_DEVICES=''
python3 synthesizer.py \
	--speaker_id=0 \
	--speaker_id2=1 \
	--load_path=logs/xiaowen+nancy_2017-10-25_07-41-02 \
	--text="uɔ˨˩˦ tsɯ˥˥ ɕyn˧˥ lɤ˧ ly˥˩ xwa˥˩ weɪ˨˩˦, ʂuɔ˥˥ tɕja˨˩˦ ʂan˥˥ pʰi˧˥ pʰeɪ˥˩ i˥˩ ɕjɛ˥˥ ʈʂɚ˧˥ peɪ˥˩ nɤŋ˧˥ kɤ˧˥ ʐɤ˥˩."
#BLOCK

