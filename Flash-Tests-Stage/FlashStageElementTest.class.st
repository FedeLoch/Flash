Class {
	#name : 'FlashStageElementTest',
	#superclass : 'TestCase',
	#category : 'Flash-Tests-Stage',
	#package : 'Flash-Tests-Stage'
}

{ #category : 'tests' }
FlashStageElementTest >> testCanvasHasParticlesScanlinesAndPresetHeader [
	| canvas |
	canvas := FlashStageCanvasElement new.
	self assert: canvas particleCanvas notNil.
	self assert: canvas scanlines notNil.
	self assert: canvas backgroundLayer notNil.
	self assert: canvas presetButtons size equals: 4
]

{ #category : 'tests' }
FlashStageElementTest >> testHudExposesEditorAndOpacity [
	| hud |
	hud := FlashHudEditorElement new.
	self assert: hud editorWindow notNil.
	self assert: hud liveEditor notNil.
	hud hudOpacity: 0.5.
	self assert: hud opacity closeTo: 0.5 precision: 0.001.
	self assert: (hud opacityValueLabel text asString) equals: '50%'
]

{ #category : 'tests' }
FlashStageElementTest >> testHudMinimizeFoldsBody [
	| hud |
	hud := FlashHudEditorElement new.
	hud toggleMinimized.
	self deny: hud isEditorVisible.
	hud toggleMinimized.
	self assert: hud isEditorVisible
]

{ #category : 'tests' }
FlashStageElementTest >> testDockBringsMiniMatrixAndTransport [
	| dock |
	dock := FlashStageDockElement onWorkspace: FlashWorkspace new.
	self assert: dock miniMatrix notNil.
	self assert: dock transportToggleButton notNil.
	self assert: dock panicButton notNil.
	self assert: dock burstButton notNil.
	dock stepClock: 5.
	self assert: dock miniMatrix stepIndex equals: 5
]

{ #category : 'tests' }
FlashStageElementTest >> testScreenAssemblesParts [
	| screen |
	screen := FlashStageScreen new.
	self assert: screen stageCanvas notNil.
	self assert: screen stageHud notNil.
	self assert: screen stageDock notNil.
	self assert: screen children size equals: 3
]