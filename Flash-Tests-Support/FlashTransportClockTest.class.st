Class {
	#name : 'FlashTransportClockTest',
	#superclass : 'TestCase',
	#category : 'Flash-Tests-Support',
	#package : 'Flash-Tests-Support'
}

{ #category : 'tests' }
FlashTransportClockTest >> testAdvanceAnnouncesStepEvent [
	| clock received |
	clock := FlashTransportClock new.
	received := nil.
	clock onStep: [ :e | received := e ].
	clock advance.
	self assert: received isNotNil.
	self assert: received step equals: 1
]

{ #category : 'tests' }
FlashTransportClockTest >> testAdvanceWrapsAtSixteen [
	| clock |
	clock := FlashTransportClock new.
	clock step: 15.
	clock advance.
	self assert: clock step equals: 0
]

{ #category : 'tests' }
FlashTransportClockTest >> testInitialState [
	| clock |
	clock := FlashTransportClock new.
	self assert: clock bpm equals: 138.0.
	self assert: clock step equals: 0.
	self deny: clock isRunning
]

{ #category : 'tests' }
FlashTransportClockTest >> testStartStopToggle [
	| clock |
	clock := FlashTransportClock new.
	clock start.
	self assert: clock isRunning.
	clock stop.
	self deny: clock isRunning.
	clock toggleRunning.
	self assert: clock isRunning
]

{ #category : 'tests' }
FlashTransportClockTest >> testStepDurationSixteenthAt138 [
	| clock |
	clock := FlashTransportClock new.
	self assert: clock stepDurationMilliseconds closeTo: 108.7 precision: 0.5
]

{ #category : 'tests' }
FlashTransportClockTest >> testSwingShiftsOddSteps [
	| clock |
	clock := FlashTransportClock new.
	clock swing: 0.2.
	self assert: (clock payloadDurationForStep: 4) closeTo: 130.43 precision: 0.5.
	self assert: (clock payloadDurationForStep: 3) equals: clock stepDurationMilliseconds
]

{ #category : 'tests' }
FlashTransportClockTest >> testTapTempoComputesBpm [
	| clock |
	clock := FlashTransportClock new.
	clock tapAtMilliseconds: 1000.
	clock tapAtMilliseconds: 1500.
	clock tapAtMilliseconds: 2000.
	self assert: clock bpm closeTo: 120 precision: 1.
	clock resetTaps.
	self assert: clock tapTimes isEmpty
]