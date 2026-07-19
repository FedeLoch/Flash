Class {
	#name : #FlashEditorEventListenerTest,
	#superclass : #TestCase,
	#category : #'Flash-Tests-Events'
}

{
	#category : #tests
}
FlashEditorEventListenerTest >> testGlobalAnnouncerIsSingleton [
	self assert: FlashEditorEventListener globalAnnouncer
		identicalTo: FlashEditorEventListener globalAnnouncer

]
{
	#category : #tests
}
FlashEditorEventListenerTest >> testStartListeningSetsFlag [
	| listener |
	listener := FlashEditorEventListener new.
	listener startListening.
	self assert: listener isListening.
	listener stopListening

]
{
	#category : #tests
}
FlashEditorEventListenerTest >> testStopListeningClearsFlag [
	| listener |
	listener := FlashEditorEventListener new.
	listener startListening.
	listener stopListening.
	self deny: listener isListening

]
{
	#category : #tests
}
FlashEditorEventListenerTest >> testOnMelodyEventReceivesAnnouncement [
	| listener received event |
	listener := FlashEditorEventListener new.
	received := nil.
	listener startListening.
	listener onMelodyEvent: [ :evt | received := evt ].
	event := FlashMelodyEvent new soundName: 'bd'; yourself.
	FlashEditorEventListener globalAnnouncer announce: event.
	self assert: received isNotNil.
	self assert: received soundName equals: 'bd'.
	listener stopListening

]
{
	#category : #tests
}
FlashEditorEventListenerTest >> testMultipleSubscribersAllReceiveEvents [
	| listener received1 received2 event |
	listener := FlashEditorEventListener new.
	received1 := nil. received2 := nil.
	listener startListening.
	listener onMelodyEvent: [ :evt | received1 := evt ].
	listener onMelodyEvent: [ :evt | received2 := evt ].
	event := FlashMelodyEvent new soundName: 'sn'; yourself.
	FlashEditorEventListener globalAnnouncer announce: event.
	self assert: received1 isNotNil.
	self assert: received2 isNotNil.
	listener stopListening
]
