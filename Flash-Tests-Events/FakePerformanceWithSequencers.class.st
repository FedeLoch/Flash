Class {
	#name : #FakePerformanceWithSequencers,
	#superclass : #Object,
	#instVars : [
		'sequencers'
	],
	#category : #'Flash-Tests-Events'
}

{
	#category : #accessing
}
FakePerformanceWithSequencers >> sequencers [
	^ sequencers
]

{
	#category : #accessing
}
FakePerformanceWithSequencers >> sequencers: aCollection [
	sequencers := aCollection
]