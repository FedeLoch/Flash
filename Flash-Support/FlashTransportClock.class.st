Class {
	#name : 'FlashTransportClock',
	#superclass : 'Object',
	#instVars : [
		'bpm',
		'step',
		'isRunning',
		'quant',
		'swing',
		'tapTimes',
		'announcer'
	],
	#category : 'Flash-Support',
	#package : 'Flash-Support'
}

{ #category : 'accessing' }
FlashTransportClock >> announcer [
	announcer ifNil: [ announcer := Announcer new ].
	^ announcer
]

{ #category : 'transport' }
FlashTransportClock >> advance [
	step := (step + 1) \\ self stepCount.
	self announcer announce: (FlashStepEvent step: step clock: self).
	^ step
]

{ #category : 'accessing' }
FlashTransportClock >> bpm [
	^ bpm
]

{ #category : 'accessing' }
FlashTransportClock >> bpm: aNumber [
	bpm := aNumber
]

{ #category : 'initialization' }
FlashTransportClock >> initialize [
	super initialize.
	bpm := 138.0.
	step := 0.
	isRunning := false.
	quant := 4.
	swing := 0.0.
	tapTimes := OrderedCollection new
]

{ #category : 'testing' }
FlashTransportClock >> isRunning [
	^ isRunning
]

{ #category : 'subscription' }
FlashTransportClock >> onStep: aBlock [
	self announcer when: FlashStepEvent do: aBlock for: self
]

{ #category : 'timing' }
FlashTransportClock >> payloadDurationForStep: anInteger [
	| base |
	base := self stepDurationMilliseconds.
	anInteger even ifTrue: [ ^ base * (1.0 + swing) ].
	^ base
]

{ #category : 'accessing' }
FlashTransportClock >> quant [
	^ quant
]

{ #category : 'accessing' }
FlashTransportClock >> quant: anInteger [
	quant := anInteger
]

{ #category : 'transport' }
FlashTransportClock >> start [
	isRunning := true
]

{ #category : 'timing' }
FlashTransportClock >> stepCount [
	^ 16
]

{ #category : 'timing' }
FlashTransportClock >> stepDurationMilliseconds [
	^ (60.0 / bpm / quant) * 1000
]

{ #category : 'accessing' }
FlashTransportClock >> step [
	^ step
]

{ #category : 'accessing' }
FlashTransportClock >> step: anInteger [
	step := anInteger \\ self stepCount
]

{ #category : 'transport' }
FlashTransportClock >> stop [
	isRunning := false
]

{ #category : 'accessing' }
FlashTransportClock >> swing [
	^ swing
]

{ #category : 'accessing' }
FlashTransportClock >> swing: aFloat [
	swing := (aFloat max: 0.0) min: 1.0
]

{ #category : 'transport' }
FlashTransportClock >> tap [
	self tapAtMilliseconds: Time millisecondClockValue
]

{ #category : 'transport' }
FlashTransportClock >> tapAtMilliseconds: anInteger [
	| intervals safeTimes |
	tapTimes addLast: anInteger.
	[ tapTimes size > 4 ] whileTrue: [ tapTimes removeFirst ].
	tapTimes size < 2 ifTrue: [ ^ self ].
	safeTimes := tapTimes copy.
	intervals := (2 to: safeTimes size)
		collect: [ :i | (safeTimes at: i) - (safeTimes at: i - 1) ].
	intervals := intervals reject: [ :d | d <= 0 ].
	intervals ifEmpty: [ ^ self ].
	bpm := ((60000.0 / (intervals sum / intervals size)) max: 30.0) min: 300.0
]

{ #category : 'transport' }
FlashTransportClock >> resetTaps [
	tapTimes removeAll
]

{ #category : 'transport' }
FlashTransportClock >> toggleRunning [
	isRunning := isRunning not.
	^ isRunning
]

{ #category : 'accessing' }
FlashTransportClock >> tapTimes [
	^ tapTimes
]