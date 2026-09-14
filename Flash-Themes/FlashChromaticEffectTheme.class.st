Class {
	#name : 'FlashChromaticEffectTheme',
	#superclass : 'FlashEffectTheme',
	#category : 'Flash-Themes',
	#package : 'Flash-Themes'
}

{ #category : 'initialization' }
FlashChromaticEffectTheme >> initialize [
	super initialize.
	name := 'Chromatic'.
	pillId := #chromatic.
	backgroundColor := Color fromHexString: '0E0F14'.
	textColor := Color fromHexString: 'F8F8F8'.
	self initializeMappings.
	self initializeAccentColors

]

{ #category : 'initialization' }
FlashChromaticEffectTheme >> initializeAccentColors [
	accentColors at: #drum put: (Color fromHexString: '8A2BE2').
	accentColors at: #snare put: (Color fromHexString: '8A2BE2').
	accentColors at: #hihat put: (Color fromHexString: '00F2FF').
	accentColors at: #bass put: (Color fromHexString: '60FF99').
	accentColors at: #lead put: (Color fromHexString: 'FF4A8D').
	accentColors at: #pad put: (Color fromHexString: '9D7BFF').
	accentColors at: #fx put: (Color fromHexString: 'FFB700').
	accentColors at: #sample put: Color white
]

{ #category : 'initialization' }
FlashChromaticEffectTheme >> initializeMappings [
	mappings at: #drum put: {
			(#effectClass -> FlashFlashEffect).
			(#config -> {
				 (#color -> (Color fromHexString: '8A2BE2')).
				 (#intensity -> 0.9) } asDictionary) } asDictionary.
	mappings at: #snare put: {
			(#effectClass -> FlashPulseEffect).
			(#config -> {
				 (#color -> (Color fromHexString: '8A2BE2')).
				 (#intensity -> 0.7) } asDictionary) } asDictionary.
	mappings at: #hihat put: {
			(#effectClass -> FlashGlowEffect).
			(#config -> {
				 (#color -> (Color fromHexString: '00F2FF')).
				 (#intensity -> 0.35) } asDictionary) } asDictionary.
	mappings at: #bass put: {
			(#effectClass -> FlashWaveEffect).
			(#config -> {
				 (#color -> (Color fromHexString: '60FF99')).
				 (#intensity -> 0.7) } asDictionary) } asDictionary.
	mappings at: #lead put: {
			(#effectClass -> FlashColorShiftEffect).
			(#config -> {
				 (#color -> (Color fromHexString: 'FF4A8D')).
				 (#intensity -> 0.8) } asDictionary) } asDictionary.
	mappings at: #pad put: {
			(#effectClass -> FlashGlowEffect).
			(#config -> {
				 (#color -> (Color fromHexString: '9D7BFF')).
				 (#intensity -> 0.4) } asDictionary) } asDictionary.
	mappings at: #fx put: {
			(#effectClass -> FlashBorderFlashEffect).
			(#config -> {
				 (#color -> (Color fromHexString: 'FFB700')).
				 (#intensity -> 0.5) } asDictionary) } asDictionary.
	mappings at: #sample put: {
			(#effectClass -> FlashBorderFlashEffect).
			(#config -> {
				 (#color -> Color white).
				 (#intensity -> 0.5) } asDictionary) } asDictionary
]