Class {
	#name : 'FlashStagePresentationTest',
	#superclass : 'TestCase',
	#category : 'Flash-Tests-Stage',
	#package : 'Flash-Tests-Stage'
}

{ #category : 'tests' }
FlashStagePresentationTest >> testAllReturnsFourDistinctPresets [
	self assert: FlashStagePresentation all size equals: 4.
	self assert: (FlashStagePresentation all collect: [ :p | p id ]) asSet size equals: 4
]

{ #category : 'tests' }
FlashStagePresentationTest >> testApplyToCanvasSwitchesBackgroundAndAccent [
	| canvas presentation |
	canvas := FlashStageCanvasElement new.
	presentation := FlashStagePresentation presetForId: #acid.
	canvas applyPresentation: presentation.
	self assert: canvas currentPresentation id equals: #acid.
	self assert: canvas backgroundLayer background paint color equals: (Color fromHexString: '#0E0F14').
	self assert: canvas particleCanvas accentColor equals: (Color fromHexString: '#FFB700')
]

{ #category : 'tests' }
FlashStagePresentationTest >> testPresetForIdUnknownFallsBackToPhosphor [
	self assert: (FlashStagePresentation presetForId: #nope) id equals: #phosphor
]

{ #category : 'tests' }
FlashStagePresentationTest >> testPresetsExposeExpectedNames [
	self assert: (FlashStagePresentation presetForId: #phosphor) name equals: 'Phosphor CRT'.
	self assert: (FlashStagePresentation presetForId: #neon) name equals: 'Neon Pulse'.
	self assert: (FlashStagePresentation presetForId: #grid) name equals: 'Cyber Grid'.
	self assert: (FlashStagePresentation presetForId: #acid) name equals: 'Acid Storm'
]