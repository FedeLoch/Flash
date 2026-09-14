Class {
	#name : 'FlashPitchParser',
	#superclass : 'Object',
	#category : 'Flash-Support',
	#package : 'Flash-Support'
}

{ #category : 'colors' }
FlashPitchParser class >> accentColors [
	^ #(
		(2.0e2 0.85 1.0)
		(1.0 0.29 0.55)
		(0.38 1.0 0.6)
		(0.45 0.96 1.0)
		(1.0 0.75 0.04)
	) collect: [ :rgb |
		Color r: (rgb at: 1) g: (rgb at: 2) b: (rgb at: 3) ]
]

{ #category : 'conversion' }
FlashPitchParser class >> frequencyForMidi: anInteger [
	^ 440.0 * (2 raisedTo: ((anInteger - 69) / 12.0))
]

{ #category : 'conversion' }
FlashPitchParser class >> frequencyForNote: aString [
	^ self frequencyForMidi: (self midiForNote: aString)
]

{ #category : 'private' }
FlashPitchParser class >> letterSemitone [
	^ Dictionary newFromPairs: { $C. 0. $D. 2. $E. 4. $F. 5. $G. 7. $A. 9. $B. 11 }
]

{ #category : 'conversion' }
FlashPitchParser class >> midiForNote: aString [
	| letter rest accidental octave |
	aString ifEmpty: [ ^ 0 ].
	letter := aString first.
	rest := aString allButFirst.
	accidental := 0.
	[ rest notEmpty and: [ (rest first = $b) or: [ rest first = $# ] ] ] whileTrue: [
		rest first = $b ifTrue: [ accidental := accidental - 1 ].
		rest first = $# ifTrue: [ accidental := accidental + 1 ].
		rest := rest allButFirst ].
	octave := rest notEmpty
		ifTrue: [ [ rest asInteger ] on: Error do: [ 4 ] ]
		ifFalse: [ 4 ].
	^ ((octave + 1) * 12) + (self semitoneForLetter: letter) + accidental
]

{ #category : 'conversion' }
FlashPitchParser class >> nameForMidi: anInteger [
	| semitone octave spellings |
	semitone := (anInteger \\ 12) + 1.
	octave := (anInteger // 12) - 1.
	spellings := #( 'C' 'Db' 'D' 'Eb' 'E' 'F' 'Gb' 'G' 'Ab' 'A' 'Bb' 'B' ).
	^ (spellings at: semitone) , octave printString
]

{ #category : 'conversion' }
FlashPitchParser class >> pitchesForNotes: anArray [
	| colors |
	colors := self accentColors.
	^ anArray withIndexCollect: [ :note :i |
		| midi freq |
		midi := self midiForNote: note.
		freq := self frequencyForMidi: midi.
		FlashPitchData name: note midi: midi frequency: freq color: (colors at: ((i - 1 \\ colors size) + 1)) ]
]

{ #category : 'private' }
FlashPitchParser class >> semitoneForLetter: aCharacter [
	^ (self letterSemitone at: aCharacter ifAbsent: [ 0 ])
]