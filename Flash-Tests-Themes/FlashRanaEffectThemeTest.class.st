Class {
	#name : #FlashRanaEffectThemeTest,
	#superclass : #TestCase,
	#category : #'Flash-Tests-Themes'
}

{
	#category : #tests
}
FlashRanaEffectThemeTest >> testNameIsRana [
	self assert: FlashRanaEffectTheme new name equals: 'Rana'

]
{
	#category : #tests
}
FlashRanaEffectThemeTest >> testBackgroundIsDeepPhosphor [
	self assert: FlashRanaEffectTheme new backgroundColor equals: (Color fromHexString: '05231E')

]
{
	#category : #tests
}
FlashRanaEffectThemeTest >> testTextColorIsPhosphorGreen [
	| theme |
	theme := FlashRanaEffectTheme new.
	self assert: theme textColor equals: (Color fromHexString: '60FF99')

]
{
	#category : #tests
}
FlashRanaEffectThemeTest >> testDrumSoundMapsToFlash [
	| theme event effect |
	theme := FlashRanaEffectTheme new.
	event := FlashMelodyEvent new soundName: 'bd'; yourself.
	effect := theme effectForEvent: event.
	self assert: (effect isKindOf: FlashFlashEffect)

]
{
	#category : #tests
}
FlashRanaEffectThemeTest >> testBassSoundMapsToWave [
	| theme event effect |
	theme := FlashRanaEffectTheme new.
	event := FlashMelodyEvent new soundName: 'bass'; yourself.
	effect := theme effectForEvent: event.
	self assert: (effect isKindOf: FlashWaveEffect)

]
{
	#category : #tests
}
FlashRanaEffectThemeTest >> testLeadSoundMapsToColorShift [
	| theme event effect |
	theme := FlashRanaEffectTheme new.
	event := FlashMelodyEvent new soundName: 'superpiano'; yourself.
	effect := theme effectForEvent: event.
	self assert: (effect isKindOf: FlashColorShiftEffect)

]
{
	#category : #tests
}
FlashRanaEffectThemeTest >> testAllSoundCategoriesHaveMappings [
	| theme categories |
	theme := FlashRanaEffectTheme new.
	categories := #(#drum #bass #lead #pad #fx #sample).
	categories do: [ :cat |
		| event |
		event := FlashMelodyEvent new.
		event forceSoundCategory: cat.
		self assert: (theme effectForEvent: event) isNotNil ]
]
