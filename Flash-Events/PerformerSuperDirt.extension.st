Class {
	#name : #PerformerSuperDirt,
	#superclass : #Performer,
	#category : #'Flash-Events'
}

{
	#category : #'*Flash-Events'
}
PerformerSuperDirt >> playNoteFor: aSequencer at: anIndex
	"Extension from Flash — wraps the original playNoteFor: to announce events"
	self announcePlayOf: aSequencer at: anIndex.
	^ self
