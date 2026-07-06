Class {
	#name : #FlashThemeEditorElementTest,
	#superclass : #TestCase,
	#category : #'Flash-Tests-Themes'
}

{
	#category : #tests
}
FlashThemeEditorElementTest >> testInitializationCreatesSubElements
	| themeEditor |
	themeEditor := FlashThemeEditorElement new.
	self assert: themeEditor themeList isNotNil.
	self assert: themeEditor mappingEditor isNotNil.
	self assert: themeEditor previewArea isNotNil

{
	#category : #tests
}
FlashThemeEditorElementTest >> testAvailableThemesListsAllConcreteSubclasses
	| themeEditor themes |
	themeEditor := FlashThemeEditorElement new.
	themes := themeEditor availableThemes.
	self assert: (themes includes: FlashRanaEffectTheme).
	self assert: (themes includes: FlashNeonEffectTheme)

{
	#category : #tests
}
FlashThemeEditorElementTest >> testSelectThemeSetsCurrentTheme
	| themeEditor |
	themeEditor := FlashThemeEditorElement new.
	themeEditor selectTheme: FlashNeonEffectTheme new.
	self assert: (themeEditor currentTheme isKindOf: FlashNeonEffectTheme)

{
	#category : #tests
}
FlashThemeEditorElementTest >> testPreviewEffectTriggersAnimationInPreviewArea
	| themeEditor |
	themeEditor := FlashThemeEditorElement new.
	themeEditor currentTheme: FlashRanaEffectTheme new.
	themeEditor previewEffectForCategory: #drum.
	self assert: themeEditor previewArea children isNotEmpty

{
	#category : #tests
}
FlashThemeEditorElementTest >> testSerializeThemeToSTON
	| theme serialized deserialized |
	theme := FlashRanaEffectTheme new.
	serialized := STON toString: theme.
	deserialized := STON fromString: serialized.
	self assert: deserialized name equals: theme name.
	self assert: deserialized backgroundColor equals: theme backgroundColor
