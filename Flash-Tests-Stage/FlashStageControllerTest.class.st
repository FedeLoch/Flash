Class {
	#name : 'FlashStageControllerTest',
	#superclass : 'TestCase',
	#category : 'Flash-Tests-Stage',
	#package : 'Flash-Tests-Stage'
}

{ #category : 'tests' }
FlashStageControllerTest >> testAdvanceClockMovesBarAndLoops [
	| controller firstStep |
	controller := FlashStageController new.
	controller initializeStage.
	firstStep := controller workspace transportClock step.
	controller advanceClock.
	self assert: controller dock stepValueLabel notNil.
	self assert: controller workspace transportClock step = ((firstStep + 1) \\ 16)
]

{ #category : 'tests' }
FlashStageControllerTest >> testInitializeStageAssemblesScreen [
	| controller |
	controller := FlashStageController new.
	controller initializeStage.
	self assert: controller canvas notNil.
	self assert: controller hud notNil.
	self assert: controller dock notNil.
	self assert: controller zen notNil.
	self assert: controller hud liveEditor notNil.
	self assert: (controller screen children anySatisfy: [ :c | c == controller canvas ]).
	self assert: (controller screen children anySatisfy: [ :c | c == controller dock ]).
	self assert: (controller screen children anySatisfy: [ :c | c == controller hud ])
]

{ #category : 'tests' }
FlashStageControllerTest >> testToggleZenDelegatesToZenController [
	| controller |
	controller := FlashStageController new.
	controller initializeStage.
	controller toggleZen.
	self assert: controller zen isZen.
	controller toggleZen.
	self deny: controller zen isZen
]

{ #category : 'tests' }
FlashStageControllerTest >> testActivatePresetWiresPresentationToCanvas [
	| controller |
	controller := FlashStageController new.
	controller initializeStage.
	controller activatePreset: #grid.
	self assert: controller canvas currentPresentation id equals: #grid.
	self assert: (controller dock sparkLabel text asString) equals: 'SPARK x4'
]