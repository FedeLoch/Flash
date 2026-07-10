Class {
	#name : 'FlashEditorCompletionController',
	#superclass : 'Object',
	#instVars : [
		'completionEngine',
		'popupElement',
		'editor'
	],
	#category : 'Flash-Core',
	#package : 'Flash-Core'
}

{ #category : 'popup' }
FlashEditorCompletionController >> acceptSelected [
	self dismiss

]

{ #category : 'completion' }
FlashEditorCompletionController >> canAcceptSuggestion: aSuggestion forPartial: aPartialString [
	^ aSuggestion beginsWith: aPartialString

]

{ #category : 'accessing' }
FlashEditorCompletionController >> completionEngine [
	^ completionEngine

]

{ #category : 'popup' }
FlashEditorCompletionController >> dismiss [
	popupElement ifNotNil: [
		popupElement removeFromParent.
		popupElement := nil ]
]

{ #category : 'accessing' }
FlashEditorCompletionController >> editor [
	^ editor

]

{ #category : 'accessing' }
FlashEditorCompletionController >> editor: aFlashLiveEditor [
	editor := aFlashLiveEditor

]

{ #category : 'initialization' }
FlashEditorCompletionController >> initialize [
	super initialize.
	completionEngine := CompletionEngine new

]

{ #category : 'popup' }
FlashEditorCompletionController >> isPopupVisible [
	^ popupElement isNotNil and: [ popupElement space isNotNil ]

]

{ #category : 'accessing' }
FlashEditorCompletionController >> popupElement [
	^ popupElement

]

{ #category : 'popup' }
FlashEditorCompletionController >> showPopup: suggestions at: position [
	self dismiss.
	popupElement := BlElement new
		size: 200 @ (suggestions size * 20 min: 200);
		background: Color veryDarkGray;
		border: (BlBorder builder width: 1; paint: Color gray; build);
		yourself.
	editor ifNotNil: [ editor addChild: popupElement ]

]

{ #category : 'completion' }
FlashEditorCompletionController >> suggestionsForSource: aString atPosition: anInteger [
	| ast completionContext entries |
	[ ast := completionEngine parse: aString class: Object ]
		on: Error
		do: [ ^ #() ].
	completionContext := NECContext new
		ast: ast;
		position: anInteger;
		yourself.
	entries := completionContext entries.
	^ entries collect: [ :each | each contents ]

]

{ #category : 'popup' }
FlashEditorCompletionController >> triggerCompletionAt: cursorPosition [
	| text suggestions |
	editor ifNil: [ ^ self ].
	text := editor editor text asString.
	suggestions := self suggestionsForSource: text atPosition: cursorPosition.
	suggestions ifEmpty: [ ^ self ].
	self showPopup: suggestions at: cursorPosition

]
