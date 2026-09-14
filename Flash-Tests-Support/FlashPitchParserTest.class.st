Class {
	#name : 'FlashPitchParserTest',
	#superclass : 'TestCase',
	#category : 'Flash-Tests-Support',
	#package : 'Flash-Tests-Support'
}

{ #category : 'tests' }
FlashPitchParserTest >> testAccidentalBlackKeys [
	self assert: (FlashPitchParser midiForNote: 'Eb3') equals: 51.
	self assert: (FlashPitchParser midiForNote: 'Bb3') equals: 58
]

{ #category : 'tests' }
FlashPitchParserTest >> testC3Frequency [
	self assert: (FlashPitchParser frequencyForNote: 'C3') closeTo: 130.81 precision: 0.02
]

{ #category : 'tests' }
FlashPitchParserTest >> testC4Frequency [
	self assert: (FlashPitchParser frequencyForNote: 'C4') closeTo: 261.63 precision: 0.02
]

{ #category : 'tests' }
FlashPitchParserTest >> testMidiforNote [
	self assert: (FlashPitchParser midiForNote: 'C4') equals: 60.
	self assert: (FlashPitchParser midiForNote: 'A4') equals: 69.
	self assert: (FlashPitchParser midiForNote: 'C3') equals: 48
]

{ #category : 'tests' }
FlashPitchParserTest >> testPitchesForNotes [
	| pitches |
	pitches := FlashPitchParser pitchesForNotes: #( 'C3' 'Eb3' 'G3' 'Bb3' 'C4' ).
	self assert: pitches size equals: 5.
	self assert: pitches first name equals: 'C3'.
	self assert: pitches last name equals: 'C4'.
	self assert: (pitches last frequency closeTo: 261.63 precision: 0.02)
]