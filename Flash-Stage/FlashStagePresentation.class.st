Class {
	#name : 'FlashStagePresentation',
	#superclass : 'Object',
	#category : 'Flash-Stage',
	#package : 'Flash-Stage'
}

{ #category : 'instance creation' }
FlashStagePresentation class >> all [
	^ { FlashPhosphorPresentation new. FlashNeonPulsePresentation new. FlashCyberGridPresentation new. FlashAcidStormPresentation new }
]

{ #category : 'instance creation' }
FlashStagePresentation class >> presetForId: aSymbol [
	^ (self all detect: [ :p | p id = aSymbol ] ifNone: [ FlashPhosphorPresentation new ])
]

{ #category : 'applying' }
FlashStagePresentation >> applyTo: aFlashStageCanvasElement [
	aFlashStageCanvasElement backgroundLayer background: self backgroundColor.
	aFlashStageCanvasElement particleCanvas accentColor: self accentColor.
	aFlashStageCanvasElement scanlines tint: self accentColor
]

{ #category : 'accessing' }
FlashStagePresentation >> accentColor [
	self subclassResponsibility
]

{ #category : 'accessing' }
FlashStagePresentation >> backgroundColor [
	self subclassResponsibility
]

{ #category : 'accessing' }
FlashStagePresentation >> id [
	self subclassResponsibility
]

{ #category : 'accessing' }
FlashStagePresentation >> name [
	self subclassResponsibility
]

{ #category : 'accessing' }
FlashStagePresentation >> particleKind [
	self subclassResponsibility
]