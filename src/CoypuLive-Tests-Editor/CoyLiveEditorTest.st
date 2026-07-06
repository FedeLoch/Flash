Class {
	#name : #CoyLiveEditorTest,
	#superclass : #TestCase,
	#category : #'CoypuLive-Tests-Editor'
}

{
	#category : #tests
}
CoyLiveEditorTest >> testInitializationCreatesAlbEditor
	| liveEditor |
	liveEditor := CoyLiveEditor new.
	self assert: liveEditor editor isNotNil.
	self assert: (liveEditor editor isKindOf: AlbEditor)

{
	#category : #tests
}
CoyLiveEditorTest >> testInitializationCreatesEffectLayer
	| liveEditor |
	liveEditor := CoyLiveEditor new.
	self assert: liveEditor effectLayer isNotNil.
	self assert: (liveEditor effectLayer isKindOf: BlElement)

{
	#category : #tests
}
CoyLiveEditorTest >> testActiveEffectsStartsEmpty
	| liveEditor |
	liveEditor := CoyLiveEditor new.
	self assert: liveEditor activeEffects isEmpty

{
	#category : #tests
}
CoyLiveEditorTest >> testSetEffectTheme
	| liveEditor theme |
	liveEditor := CoyLiveEditor new.
	theme := CoyRanaEffectTheme new.
	liveEditor effectTheme: theme.
	self assert: liveEditor effectTheme equals: theme.
	self assert: liveEditor background paint color equals: Color black

{
	#category : #tests
}
CoyLiveEditorTest >> testHandleMelodyEventTriggersEffect
	| liveEditor theme event |
	liveEditor := CoyLiveEditor new.
	theme := CoyRanaEffectTheme new.
	liveEditor effectTheme: theme.
	event := CoyMelodyEvent new soundName: 'bd'; velocity: 0.8; yourself.
	liveEditor handleMelodyEvent: event.
	self deny: liveEditor activeEffects isEmpty

{
	#category : #tests
}
CoyLiveEditorTest >> testCleanupRemovesFinishedEffects
	| liveEditor effect |
	liveEditor := CoyLiveEditor new.
	effect := CoyFlashEffect new.
	effect beFinished.
	liveEditor activeEffects add: effect.
	liveEditor cleanupFinishedEffects.
	self assert: liveEditor activeEffects isEmpty

{
	#category : #tests
}
CoyLiveEditorTest >> testEditorHasChildElements
	| liveEditor |
	liveEditor := CoyLiveEditor new.
	self assert: (liveEditor children includes: liveEditor editor).
	self assert: (liveEditor children includes: liveEditor effectLayer)
