Class {
	#name : 'FlashHyperWaveEffectTheme',
	#superclass : 'FlashEffectTheme',
	#category : 'Flash-Themes',
	#package : 'Flash-Themes'
}

{ #category : 'initialization' }
FlashHyperWaveEffectTheme >> initialize [
	super initialize.
	name := 'HyperWave'.
	pillId := #hyperwave.
	backgroundColor := Color fromHexString: '0A1220'.
	textColor := Color fromHexString: '70D6FF'.
	self initializeMappings.
	self initializeAccentColors

]

{ #category : 'initialization' }
FlashHyperWaveEffectTheme >> initializeAccentColors [
	accentColors at: #drum put: (Color fromHexString: 'FF4D6D').
	accentColors at: #snare put: (Color fromHexString: 'FF4D6D').
	accentColors at: #hihat put: (Color fromHexString: '70D6FF').
	accentColors at: #bass put: (Color fromHexString: 'FF9F1C').
	accentColors at: #lead put: (Color fromHexString: '70D6FF').
	accentColors at: #pad put: (Color fromHexString: '9D7BFF').
	accentColors at: #fx put: Color white.
	accentColors at: #sample put: Color white
]

{ #category : 'initialization' }
FlashHyperWaveEffectTheme >> initializeMappings [
	mappings at: #drum put: {
			(#effectClass -> FlashFlashEffect).
			(#config -> {
				 (#color -> (Color fromHexString: 'FF4D6D')).
				 (#intensity -> 0.9) } asDictionary) } asDictionary.
	mappings at: #snare put: {
			(#effectClass -> FlashPulseEffect).
			(#config -> {
				 (#color -> (Color fromHexString: 'FF4D6D')).
				 (#intensity -> 0.7) } asDictionary) } asDictionary.
	mappings at: #hihat put: {
			(#effectClass -> FlashGlowEffect).
			(#config -> {
				 (#color -> (Color fromHexString: '70D6FF')).
				 (#intensity -> 0.4) } asDictionary) } asDictionary.
	mappings at: #bass put: {
			(#effectClass -> FlashWaveEffect).
			(#config -> {
				 (#color -> (Color fromHexString: 'FF9F1C')).
				 (#intensity -> 0.7) } asDictionary) } asDictionary.
	mappings at: #lead put: {
			(#effectClass -> FlashColorShiftEffect).
			(#config -> {
				 (#color -> (Color fromHexString: '70D6FF')).
				 (#intensity -> 0.9) } asDictionary) } asDictionary.
	mappings at: #pad put: {
			(#effectClass -> FlashGlowEffect).
			(#config -> {
				 (#color -> (Color fromHexString: '9D7BFF')).
				 (#intensity -> 0.4) } asDictionary) } asDictionary.
	mappings at: #fx put: {
			(#effectClass -> FlashFlashEffect).
			(#config -> {
				 (#color -> Color white).
				 (#intensity -> 0.5) } asDictionary) } asDictionary.
	mappings at: #sample put: {
			(#effectClass -> FlashFlashEffect).
			(#config -> {
				 (#color -> Color white).
				 (#intensity -> 0.5) } asDictionary) } asDictionary
]