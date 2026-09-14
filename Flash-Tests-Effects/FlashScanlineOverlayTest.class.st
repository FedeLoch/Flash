Class {
	#name : 'FlashScanlineOverlayTest',
	#superclass : 'TestCase',
	#category : 'Flash-Tests-Effects',
	#package : 'Flash-Tests-Effects'
}

{ #category : 'tests' }
FlashScanlineOverlayTest >> testIsBlocElement [
	| overlay |
	overlay := FlashScanlineOverlay new.
	self assert: (overlay isKindOf: BlElement)
]

{ #category : 'tests' }
FlashScanlineOverlayTest >> testIsMouseTransparent [
	| overlay |
	overlay := FlashScanlineOverlay new.
	self deny: overlay shouldHandleMouseEvents
]