Class {
	#name : #FlashNeonEffectThemeTest,
	#superclass : #TestCase,
	#category : #'Flash-Tests-Themes'
}

{
	#category : #tests
}
FlashNeonEffectThemeTest >> testNameIsNeon
	self assert: FlashNeonEffectTheme new name equals: 'Neon'

{
	#category : #tests
}
FlashNeonEffectThemeTest >> testBackgroundIsDeepIndigo
	self assert: FlashNeonEffectTheme new backgroundColor equals: (Color fromHexString: '0D0221')

{
	#category : #tests
}
FlashNeonEffectThemeTest >> testTextColorIsCyan
	self assert: FlashNeonEffectTheme new textColor equals: (Color fromHexString: '00F5FF')

{
	#category : #tests
}
FlashNeonEffectThemeTest >> testDrumMapsToFlashWithPink
	| theme event effect |
	theme := FlashNeonEffectTheme new.
	event := FlashMelodyEvent new soundName: 'bd'; yourself.
	effect := theme effectForEvent: event.
	self assert: (effect isKindOf: FlashFlashEffect).
	self assert: effect color equals: (Color fromHexString: 'FF006E')
