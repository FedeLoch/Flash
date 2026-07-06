Class {
	#name : #CoyEditorCompletionControllerTest,
	#superclass : #TestCase,
	#category : #'CoypuLive-Tests-Editor'
}

{
	#category : #tests
}
CoyEditorCompletionControllerTest >> testPopupInitiallyHidden
	| controller |
	controller := CoyEditorCompletionController new.
	self assert: controller isPopupVisible not

{
	#category : #tests
}
CoyEditorCompletionControllerTest >> testDismissHidesPopup
	| controller |
	controller := CoyEditorCompletionController new.
	controller dismiss.
	self assert: controller isPopupVisible not

{
	#category : #tests
}
CoyEditorCompletionControllerTest >> testTriggerCompletionReturnsSuggestions
	| controller suggestions |
	controller := CoyEditorCompletionController new.
	suggestions := controller suggestionsForSource: 'OrderedCollec' atPosition: 13.
	self assert: (suggestions anySatisfy: [ :each | each includesSubstring: 'OrderedCollection' ])

{
	#category : #tests
}
CoyEditorCompletionControllerTest >> testAcceptSelectedInsertsSuggestion
	| controller |
	controller := CoyEditorCompletionController new.
	self assert: (controller canAcceptSuggestion: 'OrderedCollection' forPartial: 'OrderedCollec')
