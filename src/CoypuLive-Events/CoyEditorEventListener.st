Class {
	#name : #CoyEditorEventListener,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'performance',
		'isListening'
	],
	#category : #'CoypuLive-Events'
}

{
	#category : #accessing
}
CoyEditorEventListener class >> globalAnnouncer
	^ CoyEditorEventListener classVarNamed: #GlobalAnnouncer ifAbsent: [
		self classVarNamed: #GlobalAnnouncer put: Announcer new ]

{
	#category : #initialization
}
CoyEditorEventListener >> initialize
	super initialize.
	announcer := Announcer new.
	isListening := false

{
	#category : #accessing
}
CoyEditorEventListener >> announcer
	^ announcer

{
	#category : #accessing
}
CoyEditorEventListener >> performance
	^ performance

{
	#category : #accessing
}
CoyEditorEventListener >> performance: aPerformance
	performance := aPerformance

{
	#category : #accessing
}
CoyEditorEventListener >> isListening
	^ isListening

{
	#category : #'start/stop'
}
CoyEditorEventListener >> startListening
	isListening ifTrue: [ ^ self ].
	isListening := true.
	self class globalAnnouncer when: CoyMelodyEvent send: #onMelodyEventAnnounced: to: self

{
	#category : #'start/stop'
}
CoyEditorEventListener >> stopListening
	isListening ifFalse: [ ^ self ].
	isListening := false.
	self class globalAnnouncer unsubscribe: self

{
	#category : #subscription
}
CoyEditorEventListener >> onMelodyEvent: aBlock
	announcer when: CoyMelodyEvent do: aBlock

{
	#category : #'event handling'
}
CoyEditorEventListener >> onMelodyEventAnnounced: aCoyMelodyEvent
	announcer announce: aCoyMelodyEvent
