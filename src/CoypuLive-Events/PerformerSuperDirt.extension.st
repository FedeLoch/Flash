Class {
	#name : #PerformerSuperDirt,
	#superclass : #Performer,
	#category : #'CoypuLive-Events'
}

{
	#category : #'*CoypuLive-Events'
}
PerformerSuperDirt >> playNoteFor: aSequencer at: anIndex
	"Extension from CoypuLive — wraps the original playNoteFor: to announce events"
	<originalMethod>
	self announcePlayOf: aSequencer at: anIndex.
	^ self
