Class {
	#name : 'FlashRanaEffectTheme',
	#superclass : 'FlashEffectTheme',
	#category : 'Flash-Themes',
	#package : 'Flash-Themes'
}

{ #category : 'initialization' }
FlashRanaEffectTheme >> initialize [
	super initialize.
	name := 'Rana'.
	backgroundColor := Color black.
	textColor := Color fromHexString: '00FF41'.
	self initializeMappings.
	self initializeAccentColors

]

{ #category : 'initialization' }
FlashRanaEffectTheme >> initializeAccentColors [
	accentColors at: #drum put: (Color fromHexString: '00FF41').
	accentColors at: #snare put: (Color fromHexString: 'FFB000').
	accentColors at: #hihat put: (Color fromHexString: '39FF14').
	accentColors at: #bass put: (Color fromHexString: '00CC33').
	accentColors at: #lead put: (Color fromHexString: '00FFFF').
	accentColors at: #pad put: (Color fromHexString: '33FF33').
	accentColors at: #fx put: Color white.
	accentColors at: #sample put: Color white
]

{ #category : 'initialization' }
FlashRanaEffectTheme >> initializeMappings [

	mappings at: #drum put: {
			(#effectClass -> FlashFlashEffect).
			(#config -> {
				 (#color -> (Color fromHexString: '00FF41')).
				 (#intensity -> 0.9) } asDictionary) } asDictionary.
	mappings at: #snare put: {
			(#effectClass -> FlashPulseEffect).
			(#config -> {
				 (#color -> (Color fromHexString: 'FFB000')).
				 (#intensity -> 0.8) } asDictionary) } asDictionary.
	mappings at: #hihat put: {
			(#effectClass -> FlashGlowEffect).
			(#config -> {
				 (#color -> (Color fromHexString: '39FF14')).
				 (#intensity -> 0.3) } asDictionary) } asDictionary.
	mappings at: #bass put: {
			(#effectClass -> FlashWaveEffect).
			(#config -> {
				 (#color -> (Color fromHexString: '00CC33')).
				 (#intensity -> 0.6) } asDictionary) } asDictionary.
	mappings at: #lead put: {
			(#effectClass -> FlashColorShiftEffect).
			(#config -> {
				 (#color -> (Color fromHexString: '00FFFF')).
				 (#intensity -> 0.8) } asDictionary) } asDictionary.
	mappings at: #pad put: {
			(#effectClass -> FlashGlowEffect).
			(#config -> {
				 (#color -> (Color fromHexString: '33FF33')).
				 (#intensity -> 0.15) } asDictionary) } asDictionary.
	mappings at: #fx put: {
			(#effectClass -> FlashBorderFlashEffect).
			(#config -> {
				 (#color -> Color white).
				 (#intensity -> 0.5) } asDictionary) } asDictionary.
	mappings at: #sample put: {
			(#effectClass -> FlashBorderFlashEffect).
			(#config -> {
				 (#color -> Color white).
				 (#intensity -> 0.5) } asDictionary) } asDictionary
]
