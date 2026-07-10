{
	#category : #'*Flash-Events'
}
Performer >> announcePlayOf: aSequencer at: anIndex [
	"Extension from Flash — announces a melody event for visual effects"
	FlashEditorEventListener globalAnnouncer announce:
		(FlashMelodyEvent fromSequencer: aSequencer at: anIndex)
]
