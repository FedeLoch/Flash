Class {
	#name : 'FlashEditorWorkflowTest',
	#superclass : 'TestCase',
	#category : 'Flash-Tests-Integration',
	#package : 'Flash-Tests-Integration'
}

{ #category : 'tests' }
FlashEditorWorkflowTest >> testDefaultThemeIsRana [
	| editor |
	editor := FlashLiveEditor new.
	self assert: (editor effectTheme isKindOf: FlashRanaEffectTheme)

]

{ #category : 'tests' }
FlashEditorWorkflowTest >> testEditorConnectsAndReceivesEvents [
	| editor received |
	editor := FlashLiveEditor new.
	received := nil.
	editor eventListener onMelodyEvent: [ :evt | received := evt ].
	editor eventListener startListening.
	FlashEditorEventListener globalAnnouncer announce:
		(FlashMelodyEvent new soundName: 'bd'; velocity: 0.9; yourself).
	self assert: received isNotNil.
	self assert: received soundName equals: 'bd'.
	editor eventListener stopListening

]

{ #category : 'tests' }
FlashEditorWorkflowTest >> testDrumEventTriggersFlashEffect [
	| editor event |
	editor := FlashLiveEditor new.
	event := FlashMelodyEvent new
		sequencerKey: #kick;
		soundName: 'bd';
		velocity: 0.9;
		yourself.
	editor handleMelodyEvent: event.
	self deny: editor activeEffects isEmpty.
	self assert: (editor activeEffects last isKindOf: FlashFlashEffect)

]

{ #category : 'tests' }
FlashEditorWorkflowTest >> testSnareEventTriggersFlashEffect [
	| editor event |
	editor := FlashLiveEditor new.
	event := FlashMelodyEvent new
		sequencerKey: #snare;
		soundName: 'sn';
		velocity: 0.8;
		yourself.
	editor handleMelodyEvent: event.
	self deny: editor activeEffects isEmpty.
	self assert: (editor activeEffects last isKindOf: FlashFlashEffect)

]

{ #category : 'tests' }
FlashEditorWorkflowTest >> testBassEventTriggersWaveEffect [
	| editor event |
	editor := FlashLiveEditor new.
	event := FlashMelodyEvent new
		sequencerKey: #bass;
		soundName: 'bass';
		velocity: 0.7;
		yourself.
	editor handleMelodyEvent: event.
	self deny: editor activeEffects isEmpty.
	self assert: (editor activeEffects last isKindOf: FlashWaveEffect)

]

{ #category : 'tests' }
FlashEditorWorkflowTest >> testLeadEventTriggersColorShiftEffect [
	| editor event |
	editor := FlashLiveEditor new.
	event := FlashMelodyEvent new
		sequencerKey: #lead;
		soundName: 'superpiano';
		velocity: 1.0;
		yourself.
	editor handleMelodyEvent: event.
	self deny: editor activeEffects isEmpty.
	self assert: (editor activeEffects last isKindOf: FlashColorShiftEffect)

]

{ #category : 'tests' }
FlashEditorWorkflowTest >> testHihatEventTriggersFlashEffect [
	| editor event |
	editor := FlashLiveEditor new.
	event := FlashMelodyEvent new
		sequencerKey: #hihat;
		soundName: 'hh';
		velocity: 0.6;
		yourself.
	editor handleMelodyEvent: event.
	self deny: editor activeEffects isEmpty.
	self assert: (editor activeEffects last isKindOf: FlashFlashEffect)

]

{ #category : 'tests' }
FlashEditorWorkflowTest >> testMultipleEventsAccumulateEffects [
	| editor |
	editor := FlashLiveEditor new.
	editor handleMelodyEvent: (FlashMelodyEvent new soundName: 'bd'; velocity: 0.9; yourself).
	editor handleMelodyEvent: (FlashMelodyEvent new soundName: 'bass'; velocity: 0.7; yourself).
	editor handleMelodyEvent: (FlashMelodyEvent new soundName: 'superpiano'; velocity: 1.0; yourself).
	self assert: editor activeEffects size equals: 3

]

{ #category : 'tests' }
FlashEditorWorkflowTest >> testSwitchToNeonTheme [
	| editor |
	editor := FlashLiveEditor new.
	editor effectTheme: FlashNeonEffectTheme new.
	self assert: (editor effectTheme isKindOf: FlashNeonEffectTheme)

]

{ #category : 'tests' }
FlashEditorWorkflowTest >> testNeonDrumTriggersPinkFlash [
	| editor event |
	editor := FlashLiveEditor new.
	editor effectTheme: FlashNeonEffectTheme new.
	event := FlashMelodyEvent new
		sequencerKey: #kick;
		soundName: 'bd';
		velocity: 0.9;
		yourself.
	editor handleMelodyEvent: event.
	self deny: editor activeEffects isEmpty.
	self assert: (editor activeEffects last isKindOf: FlashFlashEffect).
	self assert: editor activeEffects last color equals: (Color fromHexString: 'FF006E')

]

{ #category : 'tests' }
FlashEditorWorkflowTest >> testHandleMelodyEventAddsEffect [
	| editor effectBefore |
	editor := FlashLiveEditor new.
	effectBefore := editor activeEffects size.
	editor handleMelodyEvent: (FlashMelodyEvent new soundName: 'bd'; velocity: 0.5; yourself).
	self assert: editor activeEffects size equals: effectBefore + 1

]

{ #category : 'tests' }
FlashEditorWorkflowTest >> testEventVelocitySetsEffectIntensity [
	| editor event |
	editor := FlashLiveEditor new.
	event := FlashMelodyEvent new
		soundName: 'bd';
		velocity: 0.3;
		yourself.
	editor handleMelodyEvent: event.
	self deny: editor activeEffects isEmpty.
	self assert: (editor activeEffects last intensity closeTo: 0.3 precision: 0.01)

]
