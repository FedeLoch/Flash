Class {
	#name : #CoyLiveEditor,
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
	#category : #'CoypuLive-Editor'
}

{
	#category : #initialization
}
CoyLiveEditor >> initialize
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
CoyLiveEditor >> initializeEditor
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
CoyLiveEditor >> initializeEffectLayer
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
CoyLiveEditor >> initializeEventListener
	eventListener := CoyEditorEventListener new.
	eventListener onMelodyEvent: [ :event | self handleMelodyEvent: event ]

{
	#category : #initialization
}
CoyLiveEditor >> initializeCodeEvaluator
	codeEvaluator := CoyEditorCodeEvaluator new
		editor: self;
		context: codeContext;
		yourself

{
	#category : #initialization
}
CoyLiveEditor >> initializeCompletionController
	completionController := CoyEditorCompletionController new editor: self

{
	#category : #accessing
}
CoyLiveEditor >> editor
	^ editor

{
	#category : #accessing
}
CoyLiveEditor >> effectLayer
	^ effectLayer

{
	#category : #accessing
}
CoyLiveEditor >> effectTheme
	^ effectTheme

{
	#category : #accessing
}
CoyLiveEditor >> effectTheme: aCoyEffectTheme
	effectTheme := aCoyEffectTheme.
	effectTheme applyToEditor: self

{
	#category : #accessing
}
CoyLiveEditor >> eventListener
	^ eventListener

{
	#category : #accessing
}
CoyLiveEditor >> activeEffects
	^ activeEffects

{
	#category : #accessing
}
CoyLiveEditor >> codeContext
	^ codeContext

{
	#category : #accessing
}
CoyLiveEditor >> codeContext: anObject
	codeContext := anObject.
	codeEvaluator context: anObject

{
	#category : #accessing
}
CoyLiveEditor >> codeEvaluator
	^ codeEvaluator

{
	#category : #accessing
}
CoyLiveEditor >> completionController
	^ completionController

{
	#category : #'event handling'
}
CoyLiveEditor >> handleMelodyEvent: aCoyMelodyEvent
	effectTheme ifNil: [ ^ self ].
	effectTheme effectForEvent: aCoyMelodyEvent ifConfigured: [ :effect |
		effect applyTo: self withEvent: aCoyMelodyEvent.
		activeEffects add: effect.
		self cleanupFinishedEffects ]

{
	#category : #'event handling'
}
CoyLiveEditor >> cleanupFinishedEffects
	activeEffects copy do: [ :effect |
		effect isFinished ifTrue: [ activeEffects remove: effect ] ]

{
	#category : #'event handling'
}
CoyLiveEditor >> onOpenedInSpace
	super onOpenedInSpace.
	eventListener startListening

{
	#category : #'event handling'
}
CoyLiveEditor >> onClosedInSpace
	super onClosedInSpace.
	eventListener stopListening.
	activeEffects do: [ :each | each stop ].
	activeEffects removeAll

{
	#category : #evaluation
}
CoyLiveEditor >> doIt
	codeEvaluator evaluateSelection

{
	#category : #evaluation
}
CoyLiveEditor >> printIt
	codeEvaluator printSelection

{
	#category : #evaluation
}
CoyLiveEditor >> inspectIt
	codeEvaluator inspectSelection

{
	#category : #evaluation
}
CoyLiveEditor >> debugIt
	codeEvaluator debugSelection

{
	#category : #'connecting'
}
CoyLiveEditor >> connectToPerformance: aPerformance
	eventListener performance: aPerformance.
	eventListener startListening
