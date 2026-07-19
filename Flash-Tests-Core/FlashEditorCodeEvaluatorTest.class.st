Class {
	#name : 'FlashEditorCodeEvaluatorTest',
	#superclass : 'TestCase',
	#category : 'Flash-Tests-Core',
	#package : 'Flash-Tests-Core'
}

{ #category : 'tests' }
FlashEditorCodeEvaluatorTest >> testEvaluateMultilineCode [
	| evaluator result |
	evaluator := FlashEditorCodeEvaluator new context: nil.
	result := evaluator evaluate: '| x | x := 10. x * 2'.
	self assert: result equals: 20
]

{ #category : 'tests' }
FlashEditorCodeEvaluatorTest >> testEvaluateRuntimeErrorRaisesException [
	| evaluator |
	evaluator := FlashEditorCodeEvaluator new context: nil.
	self should: [ evaluator evaluate: 'nil foo' ] raise: MessageNotUnderstood

]

{ #category : 'tests' }
FlashEditorCodeEvaluatorTest >> testEvaluateSimpleExpression [
	| evaluator result |
	evaluator := FlashEditorCodeEvaluator new context: nil.
	result := evaluator evaluate: '3 + 4'.
	self assert: result equals: 7

]

{ #category : 'tests' }
FlashEditorCodeEvaluatorTest >> testEvaluateStringExpression [
	| evaluator result |
	evaluator := FlashEditorCodeEvaluator new context: nil.
	result := evaluator evaluate: '''hello'', '' world'''.
	self assert: result equals: 'hello world'

]

{ #category : 'tests' }
FlashEditorCodeEvaluatorTest >> testEvaluateSyntaxErrorRaisesException [
	| evaluator |
	evaluator := FlashEditorCodeEvaluator new context: nil.
	self should: [ evaluator evaluate: '3 +' ] raise: Error

]

{ #category : 'tests' }
FlashEditorCodeEvaluatorTest >> testEvaluateWithContext [
	| evaluator result context |
	context := OrderedCollection withAll: #(1 2 3).
	evaluator := FlashEditorCodeEvaluator new context: context.
	result := evaluator evaluate: 'self size'.
	self assert: result equals: 3

]
