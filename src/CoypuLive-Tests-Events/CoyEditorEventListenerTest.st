Class {
	#name : #CoyEditorEventListenerTest,
	#superclass : #TestCase,
	#category : #'CoypuLive-Tests-Events'
}

{
	#category : #tests
}
CoyEditorEventListenerTest >> testGlobalAnnouncerIsSingleton
	self assert: CoyEditorEventListener globalAnnouncer
		identicalTo: CoyEditorEventListener globalAnnouncer

{
	#category : #tests
}
CoyEditorEventListenerTest >> testStartListeningSetsFlag
	| listener |
	listener := CoyEditorEventListener new.
	listener startListening.
	self assert: listener isListening.
	listener stopListening

{
	#category : #tests
}
CoyEditorEventListenerTest >> testStopListeningClearsFlag
	| listener |
	listener := CoyEditorEventListener new.
	listener startListening.
	listener stopListening.
	self deny: listener isListening

{
	#category : #tests
}
CoyEditorEventListenerTest >> testOnMelodyEventReceivesAnnouncement
	| listener received event |
	listener := CoyEditorEventListener new.
	received := nil.
	listener onMelodyEvent: [ :evt | received := evt ].
	event := CoyMelodyEvent new soundName: 'bd'; yourself.
	CoyEditorEventListener globalAnnouncer announce: event.
	self assert: received isNotNil.
	self assert: received soundName equals: 'bd'.
	listener stopListening

{
	#category : #tests
}
CoyEditorEventListenerTest >> testMultipleSubscribersAllReceiveEvents
	| listener received1 received2 event |
	listener := CoyEditorEventListener new.
	received1 := nil. received2 := nil.
	listener onMelodyEvent: [ :evt | received1 := evt ].
	listener onMelodyEvent: [ :evt | received2 := evt ].
	event := CoyMelodyEvent new soundName: 'sn'; yourself.
	CoyEditorEventListener globalAnnouncer announce: event.
	self assert: received1 isNotNil.
	self assert: received2 isNotNil.
	listener stopListening
