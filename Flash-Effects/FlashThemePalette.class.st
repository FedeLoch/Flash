Class {
	#name : 'FlashThemePalette',
	#superclass : 'Object',
	#category : 'Flash-Effects',
	#package : 'Flash-Effects'
}

{ #category : 'accents' }
FlashThemePalette class >> accentAmber [
	^ Color fromHexString: 'FFB700'
]

{ #category : 'accents' }
FlashThemePalette class >> accentCyan [
	^ Color fromHexString: '00F2FF'
]

{ #category : 'accents' }
FlashThemePalette class >> accentLavender [
	^ Color fromHexString: '9D7BFF'
]

{ #category : 'accents' }
FlashThemePalette class >> accentMagenta [
	^ Color fromHexString: 'FF4A8D'
]

{ #category : 'accents' }
FlashThemePalette class >> accentPhosphor [
	^ Color fromHexString: '60FF99'
]

{ #category : 'accents' }
FlashThemePalette class >> accentWhite [
	^ Color fromHexString: 'F8F8F8'
]

{ #category : 'instance creation' }
FlashThemePalette class >> colorForNoteName: aString [
	| semitone colors |
	semitone := (FlashPitchParser midiForNote: aString) \\ 12.
	colors := self pitchCycle.
	^ colors at: ((semitone \\ colors size) + 1)
]

{ #category : 'instance creation' }
FlashThemePalette class >> colorForTrigger: aSymbol [
	aSymbol = #drum ifTrue: [ ^ self accentAmber ].
	aSymbol = #bass ifTrue: [ ^ self accentPhosphor ].
	^ self accentCyan
]

{ #category : 'accents' }
FlashThemePalette class >> pitchCycle [
	^ {
			self accentCyan.
			self accentMagenta.
			self accentPhosphor.
			self accentLavender.
			self accentAmber }
]

{ #category : 'accents' }
FlashThemePalette class >> surfaces [
	^ {
			self surface0.
			self surface1.
			self surface2.
			self surface3.
			self surface4 }
]

{ #category : 'accents' }
FlashThemePalette class >> surface0 [
	^ Color fromHexString: '0A0E14'
]

{ #category : 'accents' }
FlashThemePalette class >> surface1 [
	^ Color fromHexString: '11151C'
]

{ #category : 'accents' }
FlashThemePalette class >> surface2 [
	^ Color fromHexString: '161B22'
]

{ #category : 'accents' }
FlashThemePalette class >> surface3 [
	^ Color fromHexString: '1D232B'
]

{ #category : 'accents' }
FlashThemePalette class >> surface4 [
	^ Color fromHexString: '31353C'
]

{ #category : 'accents' }
FlashThemePalette class >> zenTextColor [
	^ Color fromHexString: 'E8EEF7'
]