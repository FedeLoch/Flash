Class {
	#name : 'FlashSequencerLane',
	#superclass : 'Object',
	#instVars : [
		'key',
		'name',
		'gates',
		'notes'
	],
	#category : 'Flash-Support',
	#package : 'Flash-Support'
}

{ #category : 'instance creation' }
FlashSequencerLane class >> key: aSymbol gates: anArray notes: anArray2 name: aString [
	^ self new
		key: aSymbol;
		gates: anArray;
		notes: anArray2;
		name: aString;
		yourself
]

{ #category : 'querying' }
FlashSequencerLane >> gateAt: anIndex [
	gates ifNil: [ ^ false ].
	gates isEmpty ifTrue: [ ^ false ].
	^ (gates at: ((anIndex - 1 \\ gates size) + 1)) isZero not
]

{ #category : 'accessing' }
FlashSequencerLane >> gates [
	^ gates
]

{ #category : 'accessing' }
FlashSequencerLane >> gates: anArray [
	gates := anArray
]

{ #category : 'testing' }
FlashSequencerLane >> isActiveAt: anIndex [
	^ self gateAt: anIndex
]

{ #category : 'accessing' }
FlashSequencerLane >> key [
	^ key
]

{ #category : 'accessing' }
FlashSequencerLane >> key: aSymbol [
	key := aSymbol
]

{ #category : 'accessing' }
FlashSequencerLane >> name [
	^ name
]

{ #category : 'accessing' }
FlashSequencerLane >> name: aString [
	name := aString
]

{ #category : 'querying' }
FlashSequencerLane >> noteAt: anIndex [
	notes ifNil: [ ^ 60 ].
	notes isEmpty ifTrue: [ ^ 60 ].
	^ notes at: ((anIndex - 1 \\ notes size) + 1)
]

{ #category : 'accessing' }
FlashSequencerLane >> notes [
	^ notes
]

{ #category : 'accessing' }
FlashSequencerLane >> notes: anArray [
	notes := anArray
]