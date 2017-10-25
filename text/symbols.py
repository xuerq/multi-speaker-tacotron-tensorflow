'''
Defines the set of symbols used in text input to the model.

The default is a set of ASCII characters that works well for English or text that has been run
through Unidecode. For other data, you can modify _characters. See TRAINING_DATA.md for details.
'''
#from jamo import h2j, j2h
#from jamo.jamo import _jamo_char_to_hcj

#from .korean import ALL_SYMBOLS, PAD, EOS

PAD = '_'
EOS = '~'
PUNC = '!\'(),-.:;?'
SPACE = ' '
IPA_en = 'ŋθˈɑæˌɔɚðɛɪDFɹKLMNPRSʃTʊʌabʒdefghijklmnopstʤuvʧwz'
IPA_cn = 'ʰŋœɑɔɕəɚɛɤɥɪ˥˦˧˨ɯ˩ɻʂʈʊʐaefijklmnopstuwxy'
NORM = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'

symbols = NORM + PAD + EOS + PUNC + SPACE + IPA_en + IPA_cn
#symbols = ALL_SYMBOLS

