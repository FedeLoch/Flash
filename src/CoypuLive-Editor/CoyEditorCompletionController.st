Class {
	#name : #CoyEditorCompletionController,
	#superclass : #Object,
	#instVars : [
		'completionEngine',
		'popupElement',
		'editor'
	],
	#category : #'CoypuLive-Editor'
}

{
	#category : #initialization
}
CoyEditorCompletionController >> initialize
	super initialize.
	completionEngine := CompletionEngine new

{
	#category : #accessing
}
CoyEditorCompletionController >> editor
	^ editor

{
	#category : #accessing
}
CoyEditorCompletionController >> editor: aCoyLiveEditor
	editor := aCoyLiveEditor

{
	#category : #accessing
}
CoyEditorCompletionController >> popupElement
	^ popupElement

{
	#category : #accessing
}
CoyEditorCompletionController >> completionEngine
	^ completionEngine

{
	#category : #popup
}
CoyEditorCompletionController >> isPopupVisible
	^ popupElement isNotNil and: [ popupElement space isNotNil ]

{
	#category : #completion
}
CoyEditorCompletionController >> suggestionsForSource: aString atPosition: anInteger
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

{
	#category : #completion }
CoyEditorCompletionController >> canAcceptSuggestion: aSuggestion forPartial: aPartialString
	^ aSuggestion beginsWith: aPartialString

{
	#category : #popup
}
CoyEditorCompletionController >> triggerCompletionAt: cursorPosition
	| text suggestions |
	editor ifNil: [ ^ self ].
	text := editor editor text asString.
	suggestions := self suggestionsForSource: text atPosition: cursorPosition.
	suggestions ifEmpty: [ ^ self ].
	self showPopup: suggestions at: cursorPosition

{
	#category : #popup
}
CoyEditorCompletionController >> showPopup: suggestions at: position
	self dismiss.
	popupElement := BlElement new
		size: 200 @ (suggestions size * 20 min: 200);
		background: Color veryDarkGray;
		border: (BlBorder builder width: 1; paint: Color gray; build);
		yourself.
	editor ifNotNil: [ editor addChild: popupElement ]

{
	#category : #popup
}
CoyEditorCompletionController >> acceptSelected
	self dismiss

{
	#category : #popup
}
CoyEditorCompletionController >> dismiss
	popupElement ifNotNil: [
		popupElement removeFromParent.
		popupElement := nil ]
