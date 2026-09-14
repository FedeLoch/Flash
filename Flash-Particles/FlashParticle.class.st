Class {
	#name : 'FlashParticle',
	#superclass : 'Object',
	#instVars : [
		'position',
		'velocity',
		'kind',
		'color',
		'lifetimeMs',
		'ageMs',
		'size'
	],
	#category : 'Flash-Particles',
	#package : 'Flash-Particles'
}

{ #category : 'instance creation' }
FlashParticle class >> kind: aSymbol color: aColor position: aPoint lifetimeMs: anInteger [
	^ self new
		kind: aSymbol;
		color: aColor;
		position: aPoint;
		lifetimeMs: anInteger;
		yourself
]

{ #category : 'advancing' }
FlashParticle >> advanceByMilliseconds: anInteger [
	ageMs := ageMs + anInteger
]

{ #category : 'accessing' }
FlashParticle >> ageMs [
	^ ageMs
]

{ #category : 'accessing' }
FlashParticle >> color [
	^ color
]

{ #category : 'accessing' }
FlashParticle >> color: aColor [
	color := aColor
]

{ #category : 'initialization' }
FlashParticle >> initialize [
	super initialize.
	ageMs := 0.
	size := 6.
	velocity := 0 @ 0
]

{ #category : 'testing' }
FlashParticle >> isExpired [
	^ lifetimeMs isNotNil and: [ ageMs >= lifetimeMs ]
]

{ #category : 'accessing' }
FlashParticle >> kind [
	^ kind
]

{ #category : 'accessing' }
FlashParticle >> kind: aSymbol [
	kind := aSymbol
]

{ #category : 'accessing' }
FlashParticle >> lifetimeMs [
	^ lifetimeMs
]

{ #category : 'accessing' }
FlashParticle >> lifetimeMs: anInteger [
	lifetimeMs := anInteger
]

{ #category : 'querying' }
FlashParticle >> phase [
	lifetimeMs ifNil: [ ^ 0.0 ].
	lifetimeMs isZero ifTrue: [ ^ 1.0 ].
	^ (ageMs / lifetimeMs) min: 1.0
]

{ #category : 'accessing' }
FlashParticle >> position [
	^ position
]

{ #category : 'accessing' }
FlashParticle >> position: aPoint [
	position := aPoint
]

{ #category : 'advancing' }
FlashParticle >> step: anInteger [
	position := position + (velocity * anInteger).
	ageMs := ageMs + anInteger
]

{ #category : 'accessing' }
FlashParticle >> velocity [
	^ velocity
]

{ #category : 'accessing' }
FlashParticle >> velocity: aPoint [
	velocity := aPoint
]