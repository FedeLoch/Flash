Class {
	#name : #CoyThemeEditorElementTest,
	#superclass : #TestCase,
	#category : #'CoypuLive-Tests-Themes'
}

{
	#category : #tests
}
CoyThemeEditorElementTest >> testInitializationCreatesSubElements
	| themeEditor |
	themeEditor := CoyThemeEditorElement new.
	self assert: themeEditor themeList isNotNil.
	self assert: themeEditor mappingEditor isNotNil.
	self assert: themeEditor previewArea isNotNil

{
	#category : #tests
}
CoyThemeEditorElementTest >> testAvailableThemesListsAllConcreteSubclasses
	| themeEditor themes |
	themeEditor := CoyThemeEditorElement new.
	themes := themeEditor availableThemes.
	self assert: (themes includes: CoyRanaEffectTheme).
	self assert: (themes includes: CoyNeonEffectTheme)

{
	#category : #tests
}
CoyThemeEditorElementTest >> testSelectThemeSetsCurrentTheme
	| themeEditor |
	themeEditor := CoyThemeEditorElement new.
	themeEditor selectTheme: CoyNeonEffectTheme new.
	self assert: (themeEditor currentTheme isKindOf: CoyNeonEffectTheme)

{
	#category : #tests
}
CoyThemeEditorElementTest >> testPreviewEffectTriggersAnimationInPreviewArea
	| themeEditor |
	themeEditor := CoyThemeEditorElement new.
	themeEditor currentTheme: CoyRanaEffectTheme new.
	themeEditor previewEffectForCategory: #drum.
	self assert: themeEditor previewArea children isNotEmpty

{
	#category : #tests
}
CoyThemeEditorElementTest >> testSerializeThemeToSTON
	| theme serialized deserialized |
	theme := CoyRanaEffectTheme new.
	serialized := STON toString: theme.
	deserialized := STON fromString: serialized.
	self assert: deserialized name equals: theme name.
	self assert: deserialized backgroundColor equals: theme backgroundColor
