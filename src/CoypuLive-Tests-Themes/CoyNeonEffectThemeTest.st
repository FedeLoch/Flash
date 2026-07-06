Class {
	#name : #CoyNeonEffectThemeTest,
	#superclass : #TestCase,
	#category : #'CoypuLive-Tests-Themes'
}

{
	#category : #tests
}
CoyNeonEffectThemeTest >> testNameIsNeon
	self assert: CoyNeonEffectTheme new name equals: 'Neon'

{
	#category : #tests
}
CoyNeonEffectThemeTest >> testBackgroundIsDeepIndigo
	self assert: CoyNeonEffectTheme new backgroundColor equals: (Color fromHexString: '0D0221')

{
	#category : #tests
}
CoyNeonEffectThemeTest >> testTextColorIsCyan
	self assert: CoyNeonEffectTheme new textColor equals: (Color fromHexString: '00F5FF')

{
	#category : #tests
}
CoyNeonEffectThemeTest >> testDrumMapsToFlashWithPink
	| theme event effect |
	theme := CoyNeonEffectTheme new.
	event := CoyMelodyEvent new soundName: 'bd'; yourself.
	effect := theme effectForEvent: event.
	self assert: (effect isKindOf: CoyFlashEffect).
	self assert: effect color equals: (Color fromHexString: 'FF006E')
