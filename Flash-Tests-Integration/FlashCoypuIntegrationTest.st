Class {
	#name : #FlashCoypuIntegrationTest,
	#superclass : #TestCase,
	#category : #'Flash-Tests-Integration'
}

{
	#category : #tests
}
FlashCoypuIntegrationTest >> testPerformerRespondsToAnnouncePlayOf
	self assert: (Performer canUnderstand: #announcePlayOf:at:)

{
	#category : #tests
}
FlashCoypuIntegrationTest >> testPerformanceRespondsToOpenLiveEditor
	self assert: (Performance canUnderstand: #openLiveEditor)

{
	#category : #tests
}
FlashCoypuIntegrationTest >> testAnnouncePlayOfCreatesValidEvent
	| seq received |
	received := nil.
	FlashEditorEventListener globalAnnouncer
		when: FlashMelodyEvent do: [ :evt | received := evt ].
	seq := SequencerMono new.
	seq seqKey: #testIntegration.
	seq gates: #(1 0 1 0) asRhythm.
	seq notes: #(60 62 64 65).
	seq noteIndex: 0.
	seq dirtMessage: (Dictionary new at: 's' put: #('bd') asDirtArray; yourself).
	Performer new announcePlayOf: seq at: 0.
	self assert: received isNotNil.
	self assert: received sequencerKey equals: #testIntegration.
	FlashEditorEventListener globalAnnouncer unsubscribe: self

{
	#category : #tests
}
FlashCoypuIntegrationTest >> testEditorConnectsToPerformance
	| editor perf |
	editor := FlashLiveEditor new.
	perf := Performance uniqueInstance.
	editor connectToPerformance: perf.
	self assert: editor eventListener isNotNil.
	self assert: editor eventListener isListening.
	editor eventListener stopListening
