Class {
	#name : #FlashEffectThemeTest,
	#superclass : #TestCase,
	#category : #'Flash-Tests-Themes'
}

{
	#category : #tests
}
FlashEffectThemeTest >> testEffectForEventReturnsEffectInstance
	| theme event effect |
	theme := FlashRanaEffectTheme new.
	event := FlashMelodyEvent new soundName: 'bd'; yourself.
	effect := theme effectForEvent: event.
	self assert: effect isNotNil.
	self assert: (effect isKindOf: FlashVisualEffect)

{
	#category : #tests
}
FlashEffectThemeTest >> testEffectForUnknownSoundReturnsFallback
	| theme event effect |
	theme := FlashRanaEffectTheme new.
	event := FlashMelodyEvent new soundName: 'totallyUnknownXYZ'; yourself.
	effect := theme effectForEvent: event.
	self assert: effect isNotNil.
	self assert: (effect isKindOf: FlashVisualEffect)

{
	#category : #tests
}
FlashEffectThemeTest >> testColorForEventReturnsColor
	| theme event color |
	theme := FlashRanaEffectTheme new.
	event := FlashMelodyEvent new soundName: 'bd'; yourself.
	color := theme colorForEvent: event.
	self assert: (color isKindOf: Color)

{
	#category : #tests
}
FlashEffectThemeTest >> testAllThemeSubclassesHaveAName
	FlashEffectTheme allSubclasses do: [ :cls |
		cls isAbstract ifFalse: [
			| theme |
			theme := cls new.
			self assert: theme name isNotNil.
			self deny: theme name isEmpty ] ]

{
	#category : #tests
}
FlashEffectThemeTest >> testAllThemeSubclassesHaveBackgroundColor
	FlashEffectTheme allSubclasses do: [ :cls |
		cls isAbstract ifFalse: [
			| theme |
			theme := cls new.
			self assert: (theme backgroundColor isKindOf: Color) ] ]
