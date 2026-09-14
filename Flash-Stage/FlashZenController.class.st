Class {
	#name : 'FlashZenController',
	#superclass : 'Object',
	#instVars : [
		'isZen',
		'overlayContainers',
		'hudOpacity'
	],
	#category : 'Flash-Stage',
	#package : 'Flash-Stage'
}

{ #category : 'public' }
FlashZenController >> enterZen [
	isZen := true.
	overlayContainers do: [ :overlay | overlay opacity: 0 ]
]

{ #category : 'public' }
FlashZenController >> exitZen [
	isZen := false.
	overlayContainers do: [ :overlay | overlay opacity: hudOpacity ]
]

{ #category : 'accessing' }
FlashZenController >> hudOpacity [
	^ hudOpacity
]

{ #category : 'accessing' }
FlashZenController >> hudOpacity: aNumber [
	hudOpacity := aNumber
]

{ #category : 'initialization' }
FlashZenController >> initialize [
	isZen := false.
	hudOpacity := 1.0.
	overlayContainers := OrderedCollection new
]

{ #category : 'accessing' }
FlashZenController >> isZen [
	^ isZen
]

{ #category : 'public' }
FlashZenController >> parkOverlay: aBlElement [
	overlayContainers addIfNotPresent: aBlElement.
	aBlElement opacity: hudOpacity
]

{ #category : 'public' }
FlashZenController >> toggleZen [
	isZen
		ifTrue: [ self exitZen ]
		ifFalse: [ self enterZen ]
]