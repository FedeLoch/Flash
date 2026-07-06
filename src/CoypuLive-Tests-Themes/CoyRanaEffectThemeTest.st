Class {
	#name : #CoyRanaEffectThemeTest,
	#superclass : #TestCase,
	#category : #'CoypuLive-Tests-Themes'
}

{
	#category : #tests
}
CoyRanaEffectThemeTest >> testNameIsRana
	self assert: CoyRanaEffectTheme new name equals: 'Rana'

{
	#category : #tests
}
CoyRanaEffectThemeTest >> testBackgroundIsBlack
	self assert: CoyRanaEffectTheme new backgroundColor equals: Color black

{
	#category : #tests
}
CoyRanaEffectThemeTest >> testTextColorIsPhosphorGreen
	| theme |
	theme := CoyRanaEffectTheme new.
	self assert: theme textColor equals: (Color fromHexString: '00FF41')

{
	#category : #tests
}
CoyRanaEffectThemeTest >> testDrumSoundMapsToFlash
	| theme event effect |
	theme := CoyRanaEffectTheme new.
	event := CoyMelodyEvent new soundName: 'bd'; yourself.
	effect := theme effectForEvent: event.
	self assert: (effect isKindOf: CoyFlashEffect)

{
	#category : #tests
}
CoyRanaEffectThemeTest >> testBassSoundMapsToWave
	| theme event effect |
	theme := CoyRanaEffectTheme new.
	event := CoyMelodyEvent new soundName: 'bass'; yourself.
	effect := theme effectForEvent: event.
	self assert: (effect isKindOf: CoyWaveEffect)

{
	#category : #tests
}
CoyRanaEffectThemeTest >> testLeadSoundMapsToColorShift
	| theme event effect |
	theme := CoyRanaEffectTheme new.
	event := CoyMelodyEvent new soundName: 'superpiano'; yourself.
	effect := theme effectForEvent: event.
	self assert: (effect isKindOf: CoyColorShiftEffect)

{
	#category : #tests
}
CoyRanaEffectThemeTest >> testAllSoundCategoriesHaveMappings
	| theme categories |
	theme := CoyRanaEffectTheme new.
	categories := #(#drum #bass #lead #pad #fx #sample).
	categories do: [ :cat |
		| event |
		event := CoyMelodyEvent new.
		event forceSoundCategory: cat.
		self assert: (theme effectForEvent: event) isNotNil ]
