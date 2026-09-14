Class {
	#name : 'FlashStageScreen',
	#superclass : 'BlElement',
	#instVars : [
		'stageCanvas',
		'stageHud',
		'stageDock'
	],
	#category : 'Flash-Stage',
	#package : 'Flash-Stage'
}

{ #category : 'initialization' }
FlashStageScreen >> buildScreen [
	self removeChildren.
	self layout: BlFrameLayout new.
	self extent: 1280 @ 800.
	self background: (Color fromHexString: '#0A0E14').

	stageCanvas constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	self addChild: stageCanvas.

	stageDock constraintsDo: [ :c |
		c frame horizontal alignCenterAt: 0.
		c frame vertical alignBottomAt: 8 ].
	self addChild: stageDock.

	stageHud constraintsDo: [ :c |
		c frame horizontal alignRightAt: 16.
		c frame vertical alignTopAt: 8 ].
	self addChild: stageHud
]

{ #category : 'initialization' }
FlashStageScreen >> initialize [
	super initialize.
	stageCanvas := FlashStageCanvasElement new.
	stageHud := FlashHudEditorElement new.
	stageDock := FlashStageDockElement onWorkspace: FlashWorkspace new.
	self buildScreen
]

{ #category : 'accessing' }
FlashStageScreen >> stageCanvas [
	^ stageCanvas
]

{ #category : 'accessing' }
FlashStageScreen >> stageCanvas: aFlashStageCanvasElement [
	stageCanvas := aFlashStageCanvasElement.
	self buildScreen
]

{ #category : 'accessing' }
FlashStageScreen >> stageDock [
	^ stageDock
]

{ #category : 'accessing' }
FlashStageScreen >> stageDock: aFlashStageDockElement [
	stageDock := aFlashStageDockElement.
	self buildScreen
]

{ #category : 'accessing' }
FlashStageScreen >> stageHud [
	^ stageHud
]

{ #category : 'accessing' }
FlashStageScreen >> stageHud: aFlashHudEditorElement [
	stageHud := aFlashHudEditorElement.
	self buildScreen
]