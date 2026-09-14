Class {
	#name : 'FlashAcidStormPresentation',
	#superclass : 'FlashStagePresentation',
	#category : 'Flash-Stage',
	#package : 'Flash-Stage'
}

{ #category : 'accessing' }
FlashAcidStormPresentation >> accentColor [
	^ (Color fromHexString: '#FFB700') alpha: 1
]

{ #category : 'accessing' }
FlashAcidStormPresentation >> backgroundColor [
	^ (Color fromHexString: '#0E0F14')
]

{ #category : 'accessing' }
FlashAcidStormPresentation >> id [
	^ #acid
]

{ #category : 'accessing' }
FlashAcidStormPresentation >> name [
	^ 'Acid Storm'
]

{ #category : 'accessing' }
FlashAcidStormPresentation >> particleKind [
	^ #shower
]