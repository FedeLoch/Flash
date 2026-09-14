Class {
	#name : 'FlashPhosphorPresentation',
	#superclass : 'FlashStagePresentation',
	#category : 'Flash-Stage',
	#package : 'Flash-Stage'
}

{ #category : 'accessing' }
FlashPhosphorPresentation >> accentColor [
	^ (Color fromHexString: '#60FF99') alpha: 1
]

{ #category : 'accessing' }
FlashPhosphorPresentation >> backgroundColor [
	^ (Color fromHexString: '#05231E')
]

{ #category : 'accessing' }
FlashPhosphorPresentation >> id [
	^ #phosphor
]

{ #category : 'accessing' }
FlashPhosphorPresentation >> name [
	^ 'Phosphor CRT'
]

{ #category : 'accessing' }
FlashPhosphorPresentation >> particleKind [
	^ #shower
]