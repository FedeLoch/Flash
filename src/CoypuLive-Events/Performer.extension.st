Class {
	#name : #Performer,
	#superclass : #Object,
	#category : #'CoypuLive-Events'
}

{
	#category : #'*CoypuLive-Events'
}
Performer >> announcePlayOf: aSequencer at: anIndex
	"Extension from CoypuLive — announces a melody event for visual effects"
	CoyEditorEventListener globalAnnouncer announce:
		(CoyMelodyEvent fromSequencer: aSequencer at: anIndex)
