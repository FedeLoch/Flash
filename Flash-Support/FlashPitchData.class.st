Class {
	#name : 'FlashPitchData',
	#superclass : 'Object',
	#instVars : [
		'name',
		'midi',
		'frequency',
		'color'
	],
	#category : 'Flash-Support',
	#package : 'Flash-Support'
}

{ #category : 'instance creation' }
FlashPitchData class >> name: aString midi: anInteger frequency: aNumber color: aColor [
	^ self new
		initializeName: aString
		midi: anInteger
		frequency: aNumber
		color: aColor
]

{ #category : 'accessing' }
FlashPitchData >> color [
	^ color
]

{ #category : 'accessing' }
FlashPitchData >> color: aColor [
	color := aColor
]

{ #category : 'accessing' }
FlashPitchData >> frequency [
	^ frequency
]

{ #category : 'initialization' }
FlashPitchData >> initializeName: aString midi: anInteger frequency: aNumber color: aColor [
	name := aString.
	midi := anInteger.
	frequency := aNumber.
	color := aColor
]

{ #category : 'accessing' }
FlashPitchData >> midi [
	^ midi
]

{ #category : 'accessing' }
FlashPitchData >> name [
	^ name
]

{ #category : 'printing' }
FlashPitchData >> printString [
	^ name , ':' , (frequency roundTo: 0.01) printString , 'Hz'
]