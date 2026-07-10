Class {
	#name : #FlashNeonEffectTheme,
	#superclass : #FlashEffectTheme,
	#category : #'Flash-Themes'
}

{
	#category : #initialization
}
FlashNeonEffectTheme >> initialize [
	super initialize.
	name := 'Neon'.
	backgroundColor := Color fromHexString: '0D0221'.
	textColor := Color fromHexString: '00F5FF'.
	self initializeMappings.
	self initializeAccentColors

]
{
	#category : #initialization
}
FlashNeonEffectTheme >> initializeMappings [
	mappings at: #drum put: {
		#effectClass -> FlashFlashEffect.
		#config -> { #color -> (Color fromHexString: 'FF006E'). #intensity -> 0.9 }
	} asDictionary.
	mappings at: #snare put: {
		#effectClass -> FlashPulseEffect.
		#config -> { #color -> (Color fromHexString: 'FF006E'). #intensity -> 0.7 }
	} asDictionary.
	mappings at: #hihat put: {
		#effectClass -> FlashGlowEffect.
		#config -> { #color -> (Color fromHexString: 'FF006E'). #intensity -> 0.3 }
	} asDictionary.
	mappings at: #bass put: {
		#effectClass -> FlashWaveEffect.
		#config -> { #color -> (Color fromHexString: '3A86FF'). #intensity -> 0.7 }
	} asDictionary.
	mappings at: #lead put: {
		#effectClass -> FlashColorShiftEffect.
		#config -> { #color -> (Color fromHexString: 'FFBE0B'). #intensity -> 0.8 }
	} asDictionary.
	mappings at: #pad put: {
		#effectClass -> FlashGlowEffect.
		#config -> { #color -> (Color fromHexString: '8338EC'). #intensity -> 0.4 }
	} asDictionary.
	mappings at: #fx put: {
		#effectClass -> FlashFlashEffect.
		#config -> { #color -> (Color fromHexString: '00F5FF'). #intensity -> 0.5 }
	} asDictionary.
	mappings at: #sample put: {
		#effectClass -> FlashFlashEffect.
		#config -> { #color -> (Color fromHexString: '00F5FF'). #intensity -> 0.5 }
	} asDictionary.

]
{
	#category : #initialization
}
FlashNeonEffectTheme >> initializeAccentColors [
	accentColors at: #drum put: (Color fromHexString: 'FF006E').
	accentColors at: #snare put: (Color fromHexString: 'FF006E').
	accentColors at: #hihat put: (Color fromHexString: 'FF006E').
	accentColors at: #bass put: (Color fromHexString: '3A86FF').
	accentColors at: #lead put: (Color fromHexString: 'FFBE0B').
	accentColors at: #pad put: (Color fromHexString: '8338EC').
	accentColors at: #fx put: (Color fromHexString: '00F5FF').
	accentColors at: #sample put: (Color fromHexString: '00F5FF')
]
