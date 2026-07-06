Class {
	#name : #Performance,
	#superclass : #Dictionary,
	#category : #'CoypuLive-Events'
}

{
	#category : #'*CoypuLive-Events'
}
Performance >> openLiveEditor
	"Open a CoypuLive editor connected to this performance"
	| editor |
	editor := CoyLiveEditor new.
	editor connectToPerformance: self.
	editor openInSpace
