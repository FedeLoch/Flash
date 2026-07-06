Class {
	#name : #FlashLiveEditorTest,
	#superclass : #TestCase,
	#category : #'Flash-Tests-Core'
}

{
	#category : #tests
}
FlashLiveEditorTest >> testInitializationCreatesAlbEditor
	| liveEditor |
	liveEditor := FlashLiveEditor new.
	self assert: liveEditor editor isNotNil.
	self assert: (liveEditor editor isKindOf: AlbEditor)

{
	#category : #tests
}
FlashLiveEditorTest >> testInitializationCreatesEffectLayer
	| liveEditor |
	liveEditor := FlashLiveEditor new.
	self assert: liveEditor effectLayer isNotNil.
	self assert: (liveEditor effectLayer isKindOf: BlElement)

{
	#category : #tests
}
FlashLiveEditorTest >> testActiveEffectsStartsEmpty
	| liveEditor |
	liveEditor := FlashLiveEditor new.
	self assert: liveEditor activeEffects isEmpty

{
	#category : #tests
}
FlashLiveEditorTest >> testSetEffectTheme
	| liveEditor theme |
	liveEditor := FlashLiveEditor new.
	theme := FlashRanaEffectTheme new.
	liveEditor effectTheme: theme.
	self assert: liveEditor effectTheme equals: theme.
	self assert: liveEditor background paint color equals: Color black

{
	#category : #tests
}
FlashLiveEditorTest >> testHandleMelodyEventTriggersEffect
	| liveEditor theme event |
	liveEditor := FlashLiveEditor new.
	theme := FlashRanaEffectTheme new.
	liveEditor effectTheme: theme.
	event := FlashMelodyEvent new soundName: 'bd'; velocity: 0.8; yourself.
	liveEditor handleMelodyEvent: event.
	self deny: liveEditor activeEffects isEmpty

{
	#category : #tests
}
FlashLiveEditorTest >> testCleanupRemovesFinishedEffects
	| liveEditor effect |
	liveEditor := FlashLiveEditor new.
	effect := FlashFlashEffect new.
	effect beFinished.
	liveEditor activeEffects add: effect.
	liveEditor cleanupFinishedEffects.
	self assert: liveEditor activeEffects isEmpty

{
	#category : #tests
}
FlashLiveEditorTest >> testEditorHasChildElements
	| liveEditor |
	liveEditor := FlashLiveEditor new.
	self assert: (liveEditor children includes: liveEditor editor).
	self assert: (liveEditor children includes: liveEditor effectLayer)
