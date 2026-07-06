Class {
	#name : #FlashEditorCompletionControllerTest,
	#superclass : #TestCase,
	#category : #'Flash-Tests-Core'
}

{
	#category : #tests
}
FlashEditorCompletionControllerTest >> testPopupInitiallyHidden
	| controller |
	controller := FlashEditorCompletionController new.
	self assert: controller isPopupVisible not

{
	#category : #tests
}
FlashEditorCompletionControllerTest >> testDismissHidesPopup
	| controller |
	controller := FlashEditorCompletionController new.
	controller dismiss.
	self assert: controller isPopupVisible not

{
	#category : #tests
}
FlashEditorCompletionControllerTest >> testTriggerCompletionReturnsSuggestions
	| controller suggestions |
	controller := FlashEditorCompletionController new.
	suggestions := controller suggestionsForSource: 'OrderedCollec' atPosition: 13.
	self assert: (suggestions anySatisfy: [ :each | each includesSubstring: 'OrderedCollection' ])

{
	#category : #tests}
FlashEditorCompletionControllerTest >> testAcceptSelectedInsertsSuggestion
	| controller |
	controller := FlashEditorCompletionController new.
	self assert: (controller canAcceptSuggestion: 'OrderedCollection' forPartial: 'OrderedCollec')
