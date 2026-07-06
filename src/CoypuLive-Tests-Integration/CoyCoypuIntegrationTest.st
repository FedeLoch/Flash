Class {
	#name : #CoyCoypuIntegrationTest,
	#superclass : #TestCase,
	#category : #'CoypuLive-Tests-Integration'
}

{
	#category : #tests
}
CoyCoypuIntegrationTest >> testPerformerRespondsToAnnouncePlayOf
	self assert: (Performer canUnderstand: #announcePlayOf:at:)

{
	#category : #tests
}
CoyCoypuIntegrationTest >> testPerformanceRespondsToOpenLiveEditor
	self assert: (Performance canUnderstand: #openLiveEditor)

{
	#category : #tests
}
CoyCoypuIntegrationTest >> testAnnouncePlayOfCreatesValidEvent
	| seq received |
	received := nil.
	CoyEditorEventListener globalAnnouncer
		when: CoyMelodyEvent do: [ :evt | received := evt ].
	seq := SequencerMono new.
	seq seqKey: #testIntegration.
	seq gates: #(1 0 1 0) asRhythm.
	seq notes: #(60 62 64 65).
	seq noteIndex: 0.
	seq dirtMessage: (Dictionary new at: 's' put: #('bd') asDirtArray; yourself).
	Performer new announcePlayOf: seq at: 0.
	self assert: received isNotNil.
	self assert: received sequencerKey equals: #testIntegration.
	CoyEditorEventListener globalAnnouncer unsubscribe: self

{
	#category : #tests
}
CoyCoypuIntegrationTest >> testEditorConnectsToPerformance
	| editor perf |
	editor := CoyLiveEditor new.
	perf := Performance uniqueInstance.
	editor connectToPerformance: perf.
	self assert: editor eventListener isNotNil.
	self assert: editor eventListener isListening.
	editor eventListener stopListening
