Class {
	#name : 'FlashWorkspaceTest',
	#superclass : 'TestCase',
	#category : 'Flash-Tests-Workspace',
	#package : 'Flash-Tests-Workspace'
}

{ #category : 'helpers' }
FlashWorkspaceTest >> fullCycleEventCount [
	| count workspace |
	workspace := FlashWorkspace new.
	count := 0.
	16 timesRepeat: [ count := count + workspace advanceClock size ].
	^ count
]

{ #category : 'tests' }
FlashWorkspaceTest >> testAcidEventMapsToBass [
	| workspace event |
	workspace := FlashWorkspace new.
	event := workspace eventForLane: #acid atStep: 0.
	self assert: event soundName equals: 'bass1'.
	self assert: event triggerKind equals: #bass
]

{ #category : 'tests' }
FlashWorkspaceTest >> testBpmClamped [
	| workspace |
	workspace := FlashWorkspace new.
	workspace bpm: 999.
	self assert: workspace bpm equals: 300.0.
	workspace bpm: 10.
	self assert: workspace bpm equals: 30.0
]

{ #category : 'tests' }
FlashWorkspaceTest >> testDefaultState [
	| workspace |
	workspace := FlashWorkspace new.
	self assert: workspace bpm equals: 138.0.
	self deny: workspace isRunning.
	self assert: (workspace laneKeys includes: #kick).
	self assert: (workspace laneKeys includes: #acid).
	self assert: (workspace laneKeys includes: #hihat)
]

{ #category : 'tests' }
FlashWorkspaceTest >> testFullCycleProducesExpectedBeats [
	self assert: self fullCycleEventCount equals: 21
]

{ #category : 'tests' }
FlashWorkspaceTest >> testKickEventMapsToDrum [
	| workspace event |
	workspace := FlashWorkspace new.
	event := workspace eventForLane: #kick atStep: 0.
	self assert: event soundName equals: 'bd'.
	self assert: event triggerKind equals: #drum
]

{ #category : 'tests' }
FlashWorkspaceTest >> testPanicClearsLog [
	| workspace |
	workspace := FlashWorkspace new.
	16 timesRepeat: [ workspace advanceClock ].
	self assert: workspace soundEventLog size equals: 21.
	workspace panic.
	self assert: workspace soundEventLog isEmpty
]

{ #category : 'tests' }
FlashWorkspaceTest >> testToggleRunning [
	| workspace |
	workspace := FlashWorkspace new.
	workspace toggleRunning.
	self assert: workspace isRunning.
	workspace toggleRunning.
	self deny: workspace isRunning
]