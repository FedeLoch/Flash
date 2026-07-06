Class {
	#name : #FlashLiveEditor,
	#superclass : #BlElement,
	#instVars : [
		'editor',
		'codeContext',
		'effectTheme',
		'eventListener',
		'effectLayer',
		'activeEffects',
		'codeEvaluator',
		'completionController'
	],
	#category : #'Flash-Core'
}

{
	#category : #initialization
}
FlashLiveEditor >> initialize
	super initialize.
	self layout: BlFrameLayout new.
	self size: 600 @ 400.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	activeEffects := OrderedCollection new.
	codeContext := nil.
	self initializeEditor.
	self initializeEffectLayer.
	self initializeEventListener.
	self initializeCodeEvaluator.
	self initializeCompletionController

{
	#category : #initialization
}
FlashLiveEditor >> initializeEditor
	editor := AlbEditor new.
	editor constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	editor editorElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	self addChild: editor

{
	#category : #initialization
}
FlashLiveEditor >> initializeEffectLayer
	effectLayer := BlElement new.
	effectLayer background: Color transparent.
	effectLayer constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	effectLayer mouseTransparent: true.
	self addChild: effectLayer

{
	#category : #initialization
}
FlashLiveEditor >> initializeEventListener
	eventListener := FlashEditorEventListener new.
	eventListener onMelodyEvent: [ :event | self handleMelodyEvent: event ]

{
	#category : #initialization
}
FlashLiveEditor >> initializeCodeEvaluator
	codeEvaluator := FlashEditorCodeEvaluator new
		editor: self;
		context: codeContext;
		yourself

{
	#category : #initialization
}
FlashLiveEditor >> initializeCompletionController
	completionController := FlashEditorCompletionController new editor: self

{
	#category : #accessing
}
FlashLiveEditor >> editor
	^ editor

{
	#category : #accessing
}
FlashLiveEditor >> effectLayer
	^ effectLayer

{
	#category : #accessing
}
FlashLiveEditor >> effectTheme
	^ effectTheme

{
	#category : #accessing
}
FlashLiveEditor >> effectTheme: aFlashEffectTheme
	effectTheme := aFlashEffectTheme.
	effectTheme applyToEditor: self

{
	#category : #accessing
}
FlashLiveEditor >> eventListener
	^ eventListener

{
	#category : #accessing
}
FlashLiveEditor >> activeEffects
	^ activeEffects

{
	#category : #accessing
}
FlashLiveEditor >> codeContext
	^ codeContext

{
	#category : #accessing
}
FlashLiveEditor >> codeContext: anObject
	codeContext := anObject.
	codeEvaluator context: anObject

{
	#category : #accessing
}
FlashLiveEditor >> codeEvaluator
	^ codeEvaluator

{
	#category : #accessing
}
FlashLiveEditor >> completionController
	^ completionController

{
	#category : #'event handling'
}
FlashLiveEditor >> handleMelodyEvent: aFlashMelodyEvent
	effectTheme ifNil: [ ^ self ].
	effectTheme effectForEvent: aFlashMelodyEvent ifConfigured: [ :effect |
		effect applyTo: self withEvent: aFlashMelodyEvent.
		activeEffects add: effect.
		self cleanupFinishedEffects ]

{
	#category : #'event handling'
}
FlashLiveEditor >> cleanupFinishedEffects
	activeEffects copy do: [ :effect |
		effect isFinished ifTrue: [ activeEffects remove: effect ] ]

{
	#category : #'event handling'
}
FlashLiveEditor >> onOpenedInSpace
	super onOpenedInSpace.
	eventListener startListening

{
	#category : #'event handling'
}
FlashLiveEditor >> onClosedInSpace
	super onClosedInSpace.
	eventListener stopListening.
	activeEffects do: [ :each | each stop ].
	activeEffects removeAll

{
	#category : #evaluation
}
FlashLiveEditor >> doIt
	codeEvaluator evaluateSelection

{
	#category : #evaluation
}
FlashLiveEditor >> printIt
	codeEvaluator printSelection

{
	#category : #evaluation
}
FlashLiveEditor >> inspectIt
	codeEvaluator inspectSelection

{
	#category : #evaluation
}
FlashLiveEditor >> debugIt
	codeEvaluator debugSelection

{
	#category : #'connecting'
}
FlashLiveEditor >> connectToPerformance: aPerformance
	eventListener performance: aPerformance.
	eventListener startListening
