Class {
	#name : 'FlashEffectThemeTest',
	#superclass : 'TestCase',
	#category : 'Flash-Tests-Themes',
	#package : 'Flash-Tests-Themes'
}

{ #category : 'tests' }
FlashEffectThemeTest >> testAllThemesHavePillIds [
	FlashThemeRegistry availableThemes do: [ :theme |
		self assert: theme pillId isNotNil.
		self deny: theme name isEmpty.
		self assert: theme backgroundColor isNotNil.
		self assert: theme textColor isNotNil ]
]

{ #category : 'tests' }
FlashEffectThemeTest >> testChromaticThemeClassifies [
	| theme event |
	theme := FlashChromaticEffectTheme new.
	event := FlashMelodyEvent new soundName: 'bd'.
	self assert: (theme colorForEvent: event) equals: (Color fromHexString: '8A2BE2')
]

{ #category : 'tests' }
FlashEffectThemeTest >> testRegistryResolvesIds [
	self assert: (FlashThemeRegistry themeForPillId: #phosphor) class equals: FlashRanaEffectTheme.
	self assert: (FlashThemeRegistry themeForPillId: #neon) class equals: FlashNeonEffectTheme.
	self assert: (FlashThemeRegistry themeForPillId: #chromatic) class equals: FlashChromaticEffectTheme.
	self assert: (FlashThemeRegistry themeForPillId: #hyperwave) class equals: FlashHyperWaveEffectTheme
]

{ #category : 'tests' }
FlashEffectThemeTest >> testThemeMappingsBuildEffects [
	FlashThemeRegistry availableThemes do: [ :theme |
		theme mappings keysAndValuesDo: [ :category :config |
			self assert: (theme buildEffectFromConfig: config) isNotNil.
			self assert: category isNotNil ] ]
]