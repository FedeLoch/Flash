Class {
	#name : 'FlashThemeRegistry',
	#superclass : 'Object',
	#category : 'Flash-Themes',
	#package : 'Flash-Themes'
}

{ #category : 'instance creation' }
FlashThemeRegistry class >> availableThemes [
	^ { FlashRanaEffectTheme new. FlashNeonEffectTheme new. FlashChromaticEffectTheme new. FlashHyperWaveEffectTheme new }
]

{ #category : 'instance creation' }
FlashThemeRegistry class >> themeClassForPillId: anObject [
	^ { FlashRanaEffectTheme. FlashNeonEffectTheme. FlashChromaticEffectTheme. FlashHyperWaveEffectTheme }
		detect: [ :each | each new pillId = anObject ]
		ifNone: [ FlashRanaEffectTheme ]
]

{ #category : 'instance creation' }
FlashThemeRegistry class >> themeForPillId: anObject [
	^ (self themeClassForPillId: anObject) new
]