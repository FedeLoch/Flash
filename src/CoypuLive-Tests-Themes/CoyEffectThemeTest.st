Class {
	#name : #CoyEffectThemeTest,
	#superclass : #TestCase,
	#category : #'CoypuLive-Tests-Themes'
}

{
	#category : #tests
}
CoyEffectThemeTest >> testEffectForEventReturnsEffectInstance
	| theme event effect |
	theme := CoyRanaEffectTheme new.
	event := CoyMelodyEvent new soundName: 'bd'; yourself.
	effect := theme effectForEvent: event.
	self assert: effect isNotNil.
	self assert: (effect isKindOf: CoyVisualEffect)

{
	#category : #tests
}
CoyEffectThemeTest >> testEffectForUnknownSoundReturnsFallback
	| theme event effect |
	theme := CoyRanaEffectTheme new.
	event := CoyMelodyEvent new soundName: 'totallyUnknownXYZ'; yourself.
	effect := theme effectForEvent: event.
	self assert: effect isNotNil.
	self assert: (effect isKindOf: CoyVisualEffect)

{
	#category : #tests
}
CoyEffectThemeTest >> testColorForEventReturnsColor
	| theme event color |
	theme := CoyRanaEffectTheme new.
	event := CoyMelodyEvent new soundName: 'bd'; yourself.
	color := theme colorForEvent: event.
	self assert: (color isKindOf: Color)

{
	#category : #tests
}
CoyEffectThemeTest >> testAllThemeSubclassesHaveAName
	CoyEffectTheme allSubclasses do: [ :cls |
		cls isAbstract ifFalse: [
			| theme |
			theme := cls new.
			self assert: theme name isNotNil.
			self deny: theme name isEmpty ] ]

{
	#category : #tests
}
CoyEffectThemeTest >> testAllThemeSubclassesHaveBackgroundColor
	CoyEffectTheme allSubclasses do: [ :cls |
		cls isAbstract ifFalse: [
			| theme |
			theme := cls new.
			self assert: (theme backgroundColor isKindOf: Color) ] ]
