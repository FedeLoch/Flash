Class {
	#name : #FakeFlashSequencer,
	#superclass : #Object,
	#instVars : [
		'seqKey',
		'gates',
		'notes'
	],
	#category : #'Flash-Tests-Events'
}

{
	#category : #accessing
}
FakeFlashSequencer >> dirtMessage [
	^ Dictionary new at: 's' put: 'superpiano'; yourself
]

{
	#category : #accessing
}
FakeFlashSequencer >> gates [
	^ gates
]

{
	#category : #accessing
}
FakeFlashSequencer >> gates: anArray [
	gates := anArray
]

{
	#category : #accessing
}
FakeFlashSequencer >> notes [
	^ notes
]

{
	#category : #accessing
}
FakeFlashSequencer >> notes: anArray [
	notes := anArray
]

{
	#category : #accessing
}
FakeFlashSequencer >> seqKey [
	^ seqKey
]

{
	#category : #accessing
}
FakeFlashSequencer >> seqKey: aSymbol [
	seqKey := aSymbol
]