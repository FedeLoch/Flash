{
	#category : #'*Flash-Events'
}
Performance >> openLiveEditor
	"Open a Flash editor connected to this performance"
	| editor |
	editor := FlashLiveEditor new.
	editor connectToPerformance: self.
	editor openInSpace
