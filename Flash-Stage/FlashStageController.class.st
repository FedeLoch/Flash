Class {
	#name : 'FlashStageController',
	#superclass : 'Object',
	#instVars : [
		'workspace',
		'screen',
		'canvas',
		'hud',
		'dock',
		'zen'
	],
	#category : 'Flash-Stage',
	#package : 'Flash-Stage'
}

{ #category : 'actions' }
FlashStageController >> activatePreset: aSymbol [
	| presentation |
	presentation := FlashStagePresentation presetForId: aSymbol.
	canvas applyPresentation: presentation.
	dock sparkDensity: (presentation particleKind = #shockwave ifTrue: [ 4 ] ifFalse: [ 2 ])
]

{ #category : 'events' }
FlashStageController >> advanceClock [
	| events flashed count |
	events := workspace advanceClock.
	canvas presetPulseFor: events.
	dock stepClock: workspace transportClock step.
	dock updateBpm.
	dock vuLevels: (Array with: 0.7 with: 0.9).
	count := 0.
	flashed := false.
	events do: [ :e |
		flashed := true.
		dock tickerText: (e soundName , ' @ ' , e triggerKind printString) ].
	flashed ifFalse: [ dock tickerText: (dock workspace soundEventLog size printString , ' events in log') ].
	^ events size
]

{ #category : 'accessing' }
FlashStageController >> canvas [
	^ canvas
]

{ #category : 'accessing' }
FlashStageController >> dock [
	^ dock
]

{ #category : 'accessing' }
FlashStageController >> hud [
	^ hud
]

{ #category : 'initialization' }
FlashStageController >> initializeStage [
	workspace := FlashWorkspace new.
	canvas := FlashStageCanvasElement new.
	hud := FlashHudEditorElement new.
	dock := FlashStageDockElement onWorkspace: workspace.
	zen := FlashZenController new.

	zen hudOpacity: 0.2.
	zen parkOverlay: hud.
	zen parkOverlay: dock.

	dock burstAction: [ self burst ].
	screen := FlashStageScreen new
		stageCanvas: canvas;
		stageHud: hud;
		stageDock: dock;
		yourself
]

{ #category : 'actions' }
FlashStageController >> panic [
	workspace panic.
	dock tickerText: 'PANIC — live session halted'
]

{ #category : 'accessing' }
FlashStageController >> screen [
	^ screen
]

{ #category : 'actions' }
FlashStageController >> toggleZen [
	zen toggleZen
]

{ #category : 'actions' }
FlashStageController >> burst [
	dock sparkDensity: 8.
	dock tickerText: 'BURST — particle storm'.
	dock flashMasterBeat
]

{ #category : 'accessing' }
FlashStageController >> workspace [
	^ workspace
]

{ #category : 'accessing' }
FlashStageController >> zen [
	^ zen
]