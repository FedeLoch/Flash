Class {
	#name : 'FlashNeonPulsePresentation',
	#superclass : 'FlashStagePresentation',
	#category : 'Flash-Stage',
	#package : 'Flash-Stage'
}

{ #category : 'accessing' }
FlashNeonPulsePresentation >> accentColor [
	^ (Color fromHexString: '#FF4A8D') alpha: 1
]

{ #category : 'accessing' }
FlashNeonPulsePresentation >> backgroundColor [
	^ (Color fromHexString: '#150A18')
]

{ #category : 'accessing' }
FlashNeonPulsePresentation >> id [
	^ #neon
]

{ #category : 'accessing' }
FlashNeonPulsePresentation >> name [
	^ 'Neon Pulse'
]

{ #category : 'accessing' }
FlashNeonPulsePresentation >> particleKind [
	^ #spark
]