Extension { #name : 'PerformerSuperDirt' }

{ #category : '*Flash-Events' }
PerformerSuperDirt >> playNoteFor: aSequencer [
	"Extension from Flash — wraps the original playNoteFor: to announce events"
	super playNoteFor: aSequencer.
	self announcePlayOf: aSequencer at: aSequencer noteIndex
]
