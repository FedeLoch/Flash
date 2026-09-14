Class {
	#name : 'FlashCyberGridPresentation',
	#superclass : 'FlashStagePresentation',
	#category : 'Flash-Stage',
	#package : 'Flash-Stage'
}

{ #category : 'accessing' }
FlashCyberGridPresentation >> accentColor [
	^ (Color fromHexString: '#00F2FF') alpha: 1
]

{ #category : 'accessing' }
FlashCyberGridPresentation >> backgroundColor [
	^ (Color fromHexString: '#0A1220')
]

{ #category : 'accessing' }
FlashCyberGridPresentation >> id [
	^ #grid
]

{ #category : 'accessing' }
FlashCyberGridPresentation >> name [
	^ 'Cyber Grid'
]

{ #category : 'accessing' }
FlashCyberGridPresentation >> particleKind [
	^ #shockwave
]