Class {
	#name : 'FlashParticleEngine',
	#superclass : 'Object',
	#instVars : [
		'particles',
		'maxParticles'
	],
	#category : 'Flash-Particles',
	#package : 'Flash-Particles'
}

{ #category : 'accessing' }
FlashParticleEngine >> activeParticles [
	self collectExpired.
	^ particles
]

{ #category : 'private' }
FlashParticleEngine >> addParticle: aFlashParticle [
	particles add: aFlashParticle.
	[ particles size <= maxParticles ]
		whileFalse: [ particles removeFirst ]
]

{ #category : 'accessing' }
FlashParticleEngine >> clear [
	particles := OrderedCollection new
]

{ #category : 'private' }
FlashParticleEngine >> collectExpired [
	particles removeAllSuchThat: [ :p | p isExpired ]
]

{ #category : 'initialization' }
FlashParticleEngine >> initialize [
	super initialize.
	particles := OrderedCollection new.
	maxParticles := 250
]

{ #category : 'accessing' }
FlashParticleEngine >> maxParticles [
	^ maxParticles
]

{ #category : 'querying' }
FlashParticleEngine >> size [
	^ self activeParticles size
]

{ #category : 'spawning' }
FlashParticleEngine >> spawnForEvent: aFlashMelodyEvent [
	self spawnForEvent: aFlashMelodyEvent at: (700 @ 160)
]

{ #category : 'spawning' }
FlashParticleEngine >> spawnForEvent: aFlashMelodyEvent at: aPoint [
	aFlashMelodyEvent triggerKind = #drum
		ifTrue: [ self spawnShockwaveFor: aFlashMelodyEvent at: aPoint ]
		ifFalse: [
			aFlashMelodyEvent triggerKind = #bass
				ifTrue: [ self spawnSparkFor: aFlashMelodyEvent ]
				ifFalse: [ self spawnShowerFor: aFlashMelodyEvent ] ]
]

{ #category : 'spawning' }
FlashParticleEngine >> spawnShowerFor: aFlashMelodyEvent [
	| baseX color |
	baseX := aFlashMelodyEvent normalizedPitch * 900 + 60.
	color := Color fromHexString: '#00F2FF'.
	1 to: 20 do: [ :j |
		self addParticle: (FlashParticle kind: #shower color: color position: (baseX + (j * 7) @ (60 + (j * 4))) lifetimeMs: (380 + (j * 9)))
			velocity: ((j even ifTrue: [ 1.2 ] ifFalse: [ -1.2 ]) @ 0.7) ]
]

{ #category : 'spawning' }
FlashParticleEngine >> spawnSparkFor: aFlashMelodyEvent [
	| spread color |
	spread := aFlashMelodyEvent noteValue \\ 40.
	color := Color fromHexString: '#FFB700'.
	1 to: 14 do: [ :j |
		self addParticle: (FlashParticle kind: #spark color: color position: (spread * 18 + (j * 6) @ 460) lifetimeMs: (300 + (j * 7)))
			velocity: ((j - 7) * 0.4 @ -3.4) ]
]

{ #category : 'spawning' }
FlashParticleEngine >> spawnShockwaveFor: aFlashMelodyEvent at: aPoint [
	| color velocityScale |
	color := Color fromHexString: '#60FF99'.
	velocityScale := (aFlashMelodyEvent velocity ifNil: [ 0.8 ]) * 3.
	1 to: 16 do: [ :j |
		| angle dx dy |
		angle := Float pi * 2 * j / 16.
		dx := angle cos * velocityScale.
		dy := angle sin * velocityScale.
		self addParticle: (FlashParticle kind: #shockwave color: color position: (aPoint x + dx @ (aPoint y + dy)) lifetimeMs: (360 + (j * 6)))
			velocity: (dx @ dy) ]
]

{ #category : 'advancing' }
FlashParticleEngine >> stepByMilliseconds: anInteger [
	particles do: [ :p | p step: anInteger ].
	self collectExpired
]

{ #category : 'private' }
FlashParticleEngine >> addParticle: aFlashParticle velocity: aPoint [
	aFlashParticle velocity: aPoint.
	self addParticle: aFlashParticle
]