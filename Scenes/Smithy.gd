extends Node2D

export var available_phonemes = ['a', 'ʟ', 'v', 'ɨ']

onready var timeline = $Timeline

var phoneme = preload("res://Scenes/Phoneme.tscn")
var window = JavaScript.get_interface('window');


func _ready():
	pass


func init():
	prepare_phonemes()


func prepare_phonemes():
	var phonemes = get_phonemes()
	var max_per_row = 10
	for i in range(len(phonemes)):
		var phoneme_filename = phonemes[i]['f']
		var phoneme_label = phonemes[i]['l']
		if not (phoneme_label in available_phonemes):
			continue
		var phoneme_inst = phoneme.instance()
		add_child(phoneme_inst)
		phoneme_inst.set_audio(phoneme_filename)
		phoneme_inst.position.x += randi() % 1024
		phoneme_inst.position.y += randi() % 400
		phoneme_inst.label.text = phoneme_label[0]

				

func sort_left_to_right(a, b):
	return b.global_position.x > a.global_position.x
		

func _on_Button_pressed():
	timeline.play()
	# don't wait, just send it to asr
	timeline.phonemes.sort_custom(self, 'sort_left_to_right')
	var files = []
	for phoneme in timeline.phonemes:
		files.append(phoneme.file)
	if window != null:
		print('processPhonemes called from godot ', str(files))		
		window.processPhonemes(str(files))
	else:
		print('mouth is null')


func _on_Timeline_on_complete():
	pass



func get_phonemes():
	return [
  {
	"l": "i",
	"f": "Close_front_unrounded_vowel"
  },
  {
	"l": "y",
	"f": "Close_front_rounded_vowel"
  },
  {
	"l": "ɨ",
	"f": "Close_central_unrounded_vowel"
  },
  {
	"l": "ʉ",
	"f": "Close_central_rounded_vowel"
  },
  {
	"l": "ɯ",
	"f": "Close_back_unrounded_vowel"
  },
  {
	"l": "u",
	"f": "Close_back_rounded_vowel"
  },
  {
	"l": "ɪ",
	"f": "Near-close_near-front_unrounded_vowel"
  },
  {
	"l": "ʏ",
	"f": "Near-close_near-front_rounded_vowel"
  },
  {
	"l": "ʊ",
	"f": "Near-close_near-back_rounded_vowel"
  },
  {
	"l": "e",
	"f": "Close-mid_front_unrounded_vowel"
  },
  {
	"l": "ø",
	"f": "Close-mid_front_rounded_vowel"
  },
  {
	"l": "ɘ",
	"f": "Close-mid_central_unrounded_vowel"
  },
  {
	"l": "ɵ",
	"f": "Close-mid_central_rounded_vowel"
  },
  {
	"l": "ɤ",
	"f": "Close-mid_back_unrounded_vowel"
  },
  {
	"l": "o",
	"f": "Close-mid_back_rounded_vowel"
  },
  {
	"l": "ə",
	"f": "Mid-central_vowel"
  },
  {
	"l": "ɛ",
	"f": "Open-mid_front_unrounded_vowel"
  },
  {
	"l": "œ",
	"f": "Open-mid_front_rounded_vowel"
  },
  {
	"l": "ɜ",
	"f": "Open-mid_central_unrounded_vowel"
  },
  {
	"l": "ɞ",
	"f": "Open-mid_central_rounded_vowel"
  },
  {
	"l": "ʌ",
	"f": "Open-mid_back_unrounded_vowel"
  },
  {
	"l": "ɔ",
	"f": "Open-mid_back_rounded_vowel"
  },
  {
	"l": "æ",
	"f": "Near-open_front_unrounded_vowel"
  },
  {
	"l": "ɐ",
	"f": "Near-open_central_unrounded_vowel"
  },
  {
	"l": "a",
	"f": "Open_front_unrounded_vowel"
  },
  {
	"l": "ä",
	"f": "Open_front_rounded_vowel"
  },
  {
	"l": "ɑ",
	"f": "Open_back_unrounded_vowel"
  },
  {
	"l": "ɒ",
	"f": "Open_back_rounded_vowel"
  },
  {
	"l": "p",
	"f": "Voiceless_bilabial_plosive"
  },
  {
	"l": "b",
	"f": "Voiced_bilabial_plosive"
  },
  {
	"l": "t",
	"f": "Voiceless_alveolar_plosive"
  },
  {
	"l": "d",
	"f": "Voiced_alveolar_plosive"
  },
  {
	"l": "ʈ",
	"f": "Voiceless_retroflex_plosive"
  },
  {
	"l": "ɖ",
	"f": "Voiced_retroflex_plosive"
  },
  {
	"l": "c",
	"f": "Voiceless_palatal_plosive"
  },
  {
	"l": "ɟ",
	"f": "Voiced_palatal_plosive"
  },
  {
	"l": "k",
	"f": "Voiceless_velar_plosive"
  },
  {
	"l": "g",
	"f": "Voiced_velar_plosive"
  },
  {
	"l": "q",
	"f": "Voiceless_uvular_plosive"
  },
  {
	"l": "ɢ",
	"f": "Voiced_uvular_plosive"
  },
  {
	"l": "ʔ",
	"f": "Glottal_stop"
  },
  {
	"l": "m",
	"f": "Bilabial_nasal"
  },
  {
	"l": "ɱ",
	"f": "Labiodental_nasal"
  },
  {
	"l": "n",
	"f": "Alveolar_nasal"
  },
  {
	"l": "ɳ",
	"f": "Retroflex_nasal"
  },
  {
	"l": "ɲ",
	"f": "Palatal_nasal"
  },
  {
	"l": "ŋ",
	"f": "Velar_nasal"
  },
  {
	"l": "ɴ",
	"f": "Uvular_nasal"
  },
  {
	"l": "ʙ",
	"f": "Bilabial_trill"
  },
  {
	"l": "r",
	"f": "Alveolar_trill"
  },
  {
	"l": "ʀ",
	"f": "Uvular_trill"
  },
  {
	"l": "ɾ",
	"f": "Alveolar_tap"
  },
  {
	"l": "ɽ",
	"f": "Retroflex_flap"
  },
  {
	"l": "ɸ",
	"f": "Voiceless_bilabial_fricative"
  },
  {
	"l": "β",
	"f": "Voiced_bilabial_fricative"
  },
  {
	"l": "f",
	"f": "Voiceless_labiodental_fricative"
  },
  {
	"l": "v",
	"f": "Voiced_labiodental_fricative"
  },
  {
	"l": "θ",
	"f": "Voiceless_dental_fricative"
  },
  {
	"l": "ð",
	"f": "Voiced_dental_fricative"
  },
  {
	"l": "s",
	"f": "Voiceless_alveolar_fricative"
  },
  {
	"l": "z",
	"f": "Voiced_alveolar_fricative"
  },
  {
	"l": "ʃ",
	"f": "Voiceless_postalveolar_fricative"
  },
  {
	"l": "ʒ",
	"f": "Voiced_postalveolar_fricative"
  },
  {
	"l": "ʂ",
	"f": "Voiceless_retroflex_fricative"
  },
  {
	"l": "ʐ",
	"f": "Voiced_retroflex_fricative"
  },
  {
	"l": "ç",
	"f": "Voiceless_palatal_fricative"
  },
  {
	"l": "ʝ",
	"f": "Voiced_palatal_fricative"
  },
  {
	"l": "x",
	"f": "Voiceless_velar_fricative"
  },
  {
	"l": "ɣ",
	"f": "Voiced_velar_fricative"
  },
  {
	"l": "χ",
	"f": "Voiceless_uvular_fricative"
  },
  {
	"l": "ʁ",
	"f": "Voiced_uvular_fricative"
  },
  {
	"l": "ħ",
	"f": "Voiceless_pharyngeal_fricative"
  },
  {
	"l": "ʕ",
	"f": "Voiced_pharyngeal_fricative"
  },
  {
	"l": "h",
	"f": "Voiceless_glottal_fricative"
  },
  {
	"l": "ɦ",
	"f": "Voiced_glottal_fricative"
  },
  {
	"l": "ɬ",
	"f": "Voiceless_alveolar_lateral_fricative"
  },
  {
	"l": "ɮ",
	"f": "Voiced_alveolar_lateral_fricative"
  },
  {
	"l": "ʋ",
	"f": "Labiodental_approximant"
  },
  {
	"l": "ɹ",
	"f": "Alveolar_approximant"
  },
  {
	"l": "ɻ",
	"f": "Retroflex_approximant"
  },
  {
	"l": "j",
	"f": "Palatal_approximant"
  },
  {
	"l": "ɰ",
	"f": "Voiced_velar_approximant"
  },
  {
	"l": "l",
	"f": "Alveolar_lateral_approximant"
  },
  {
	"l": "ɭ",
	"f": "Retroflex_lateral_approximant"
  },
  {
	"l": "ʎ",
	"f": "Palatal_lateral_approximant"
  },
  {
	"l": "ʟ",
	"f": "Velar_lateral_approximant"
  },
  {
	"l": "ʘ Bilabial",
	"f": "Bilabial_click"
  },
  {
	"l": "ɓ Bilabial",
	"f": "Voiced_bilabial_implosive"
  },
  {
	"l": "pʼ Bilabial",
	"f": "Bilabial_ejective_plosive"
  },
  {
	"l": "ǀ Dental",
	"f": "Dental_click"
  },
  {
	"l": "ɗ Dental/alveolar",
	"f": "Voiced_alveolar_implosive"
  },
  {
	"l": "tʼ Dental/alveolar",
	"f": "Alveolar_ejective_plosive"
  },
  {
	"l": "ǃ (Post)alveoalar",
	"f": "Postalveolar_click"
  },
  {
	"l": "ʄ Palatal",
	"f": "Voiced_palatal_implosive"
  },
  {
	"l": "kʼ Velar",
	"f": "Velar_ejective_plosive"
  },
  {
	"l": "ǂ Palatoalveolar",
	"f": "Palatoalveolar_click"
  },
  {
	"l": "ɠ Velar",
	"f": "Voiced_velar_implosive"
  },
  {
	"l": "sʼ Alveolar fricative",
	"f": "Alveolar_ejective_fricative"
  },
  {
	"l": "ǁ Alveolar lateral",
	"f": "Alveolar_lateral_click"
  },
  {
	"l": "ʛ Uvular",
	"f": "Voiced_uvular_implosive"
  },
  {
	"l": "ʍ Voiceless labial-velar fricative",
	"f": "Voiceless_labio-velar_fricative"
  },
  {
	"l": "w Voiced labial-velar approximant",
	"f": "Voiced_labio-velar_approximant"
  },
  {
	"l": "ɥ Voiced labial-palatal approximant",
	"f": "Labial-palatal_approximant"
  },
  {
	"l": "ʜ Voiceless epiglottal fricative",
	"f": "Voiceless_epiglottal_fricative"
  },
  {
	"l": "ʢ Voiced epiglottal fricative",
	"f": "Voiced_epiglottal_fricative"
  },
  {
	"l": "ʡ Epiglottal plosive",
	"f": "Voiceless_epiglottal_plosive"
  },
  {
	"l": "ɕ Voiceless alveolo-palatal fricative",
	"f": "Voiceless_alveolo-palatal_fricative"
  },
  {
	"l": "ʑ Voiced alveolo-palatal fricative",
	"f": "Voiced_alveolo-palatal_fricative"
  },
  {
	"l": "ɺ Alveolar lateral flap",
	"f": "Alveolar_lateral_flap"
  },
  {
	"l": "ɧ Simultaneous ʃ and x",
	"f": "Voiceless_dorso-palatal_velar_fricative"
  },
  {
	"l": "t͡s Voiceless alveolar affricate",
	"f": "Voiceless_alveolar_affricate"
  },
  {
	"l": "t͡ʃ Voiceless palato-alveolar affricate",
	"f": "Voiceless_palato-alveolar_affricate"
  },
  {
	"l": "t͡ɕ Voiceless alveolo-palatal affricate",
	"f": "Voiceless_alveolo-palatal_affricate"
  },
  {
	"l": "ʈ͡ʂ Voiceless retroflex affricate",
	"f": "Voiceless_retroflex_affricate"
  },
  {
	"l": "d͡z Voiced alveolar affricate",
	"f": "Voiced_alveolar_affricate"
  },
  {
	"l": "d͡ʒ Voiced post-alveolar affricate",
	"f": "Voiced_postalveolar_affricate"
  },
  {
	"l": "d͡ʑ Voiced alveolo-palatal affricate",
	"f": "Voiced_alveolo-palatal_affricate"
  },
  {
	"l": "ɖ͡ʐ Voiceless retroflex affricate",
	"f": "Voiced_retroflex_affricate"
  }
]

