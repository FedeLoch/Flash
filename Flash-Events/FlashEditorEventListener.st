Class {
	#name : #FlashEditorEventListener,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'performance',
		'isListening'
	],
	#category : #'Flash-Events'
}

{
	#category : #accessing
}
FlashEditorEventListener class >> globalAnnouncer [
	^ FlashEditorEventListener classVarNamed: #GlobalAnnouncer ifAbsent: [
		self classVarNamed: #GlobalAnnouncer put: Announcer new ]

]
{
	#category : #initialization
}
FlashEditorEventListener >> initialize [
	super initialize.
	announcer := Announcer new.
	isListening := false

]
{
	#category : #accessing
}
FlashEditorEventListener >> announcer [
	^ announcer

]
{
	#category : #accessing
}
FlashEditorEventListener >> performance [
	^ performance

]
{
	#category : #accessing
}
FlashEditorEventListener >> performance: aPerformance [
	performance := aPerformance

]
{
	#category : #accessing
}
FlashEditorEventListener >> isListening [
	^ isListening

]
{
	#category : #'start/stop'
}
FlashEditorEventListener >> startListening [
	isListening ifTrue: [ ^ self ].
	isListening := true.
	self class globalAnnouncer when: FlashMelodyEvent send: #onMelodyEventAnnounced: to: self

]
{
	#category : #'start/stop'
}
FlashEditorEventListener >> stopListening [
	isListening ifFalse: [ ^ self ].
	isListening := false.
	self class globalAnnouncer unsubscribe: self

]
{
	#category : #subscription
}
FlashEditorEventListener >> onMelodyEvent: aBlock [
	announcer when: FlashMelodyEvent do: aBlock

]
{
	#category : #'event handling'
}
FlashEditorEventListener >> onMelodyEventAnnounced: aFlashMelodyEvent [
	announcer announce: aFlashMelodyEvent
]
