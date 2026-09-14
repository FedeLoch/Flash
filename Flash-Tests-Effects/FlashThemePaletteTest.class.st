Class {
	#name : 'FlashThemePaletteTest',
	#superclass : 'TestCase',
	#category : 'Flash-Tests-Effects',
	#package : 'Flash-Tests-Effects'
}

{ #category : 'tests' }
FlashThemePaletteTest >> testAccentColorsAreDistinct [
	self deny: FlashThemePalette accentCyan equals: FlashThemePalette accentMagenta.
	self deny: FlashThemePalette accentCyan equals: FlashThemePalette accentPhosphor
]

{ #category : 'tests' }
FlashThemePaletteTest >> testColorForTrigger [
	self assert: (FlashThemePalette colorForTrigger: #drum) equals: FlashThemePalette accentAmber.
	self assert: (FlashThemePalette colorForTrigger: #bass) equals: FlashThemePalette accentPhosphor.
	self assert: (FlashThemePalette colorForTrigger: #synth) equals: FlashThemePalette accentCyan
]

{ #category : 'tests' }
FlashThemePaletteTest >> testSurfacesAreMonotonic [
	| surfaces |
	surfaces := FlashThemePalette surfaces.
	self assert: surfaces size equals: 5.
	2 to: surfaces size do: [ :i |
		self assert: (surfaces at: i) luminance > (surfaces at: i - 1) luminance ]
]