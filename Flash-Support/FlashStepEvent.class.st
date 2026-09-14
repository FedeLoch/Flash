Class {
	#name : 'FlashStepEvent',
	#superclass : 'Announcement',
	#instVars : [
		'step',
		'clock'
	],
	#category : 'Flash-Support',
	#package : 'Flash-Support'
}

{ #category : 'instance creation' }
FlashStepEvent class >> step: anInteger clock: aFlashTransportClock [
	^ self new
		step: anInteger;
		clock: aFlashTransportClock;
		yourself
]

{ #category : 'accessing' }
FlashStepEvent >> clock [
	^ clock
]

{ #category : 'accessing' }
FlashStepEvent >> clock: anObject [
	clock := anObject
]

{ #category : 'accessing' }
FlashStepEvent >> step [
	^ step
]

{ #category : 'accessing' }
FlashStepEvent >> step: anInteger [
	step := anInteger
]