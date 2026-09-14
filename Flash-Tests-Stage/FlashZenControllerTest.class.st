Class {
	#name : 'FlashZenControllerTest',
	#superclass : 'TestCase',
	#category : 'Flash-Tests-Stage',
	#package : 'Flash-Tests-Stage'
}

{ #category : 'tests' }
FlashZenControllerTest >> testEnterZenHidesParkedOverlays [
	| zen overlay |
	zen := FlashZenController new.
	overlay := BlElement new.
	zen parkOverlay: overlay.
	zen enterZen.
	self assert: zen isZen.
	self assert: overlay opacity equals: 0
]

{ #category : 'tests' }
FlashZenControllerTest >> testExitZenRestoresParkedOpacity [
	| zen overlay |
	zen := FlashZenController new.
	zen hudOpacity: 0.3.
	overlay := BlElement new.
	zen parkOverlay: overlay.
	zen enterZen.
	zen exitZen.
	self deny: zen isZen.
	self assert: overlay opacity closeTo: 0.3 precision: 0.001
]

{ #category : 'tests' }
FlashZenControllerTest >> testParkOverlayDefaultsToFullOpacity [
	| zen overlay |
	zen := FlashZenController new.
	overlay := BlElement new.
	zen parkOverlay: overlay.
	self assert: overlay opacity equals: 1.0
]

{ #category : 'tests' }
FlashZenControllerTest >> testToggleZenFlipsState [
	| zen |
	zen := FlashZenController new.
	zen toggleZen.
	self assert: zen isZen.
	zen toggleZen.
	self deny: zen isZen
]