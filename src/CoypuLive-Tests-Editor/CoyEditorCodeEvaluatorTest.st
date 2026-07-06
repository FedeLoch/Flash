Class {
	#name : #CoyEditorCodeEvaluatorTest,
	#superclass : #TestCase,
	#category : #'CoypuLive-Tests-Editor'
}

{
	#category : #tests
}
CoyEditorCodeEvaluatorTest >> testEvaluateSimpleExpression
	| evaluator result |
	evaluator := CoyEditorCodeEvaluator new context: nil.
	result := evaluator evaluate: '3 + 4'.
	self assert: result equals: 7

{
	#category : #tests
}
CoyEditorCodeEvaluatorTest >> testEvaluateStringExpression
	| evaluator result |
	evaluator := CoyEditorCodeEvaluator new context: nil.
	result := evaluator evaluate: '''hello'', '' world'''.
	self assert: result equals: 'hello world'

{
	#category : #tests
}
CoyEditorCodeEvaluatorTest >> testEvaluateWithContext
	| evaluator result context |
	context := OrderedCollection withAll: #(1 2 3).
	evaluator := CoyEditorCodeEvaluator new context: context.
	result := evaluator evaluate: 'self size'.
	self assert: result equals: 3

{
	#category : #tests
}
CoyEditorCodeEvaluatorTest >> testEvaluateSyntaxErrorRaisesException
	| evaluator |
	evaluator := CoyEditorCodeEvaluator new context: nil.
	self should: [ evaluator evaluate: '3 +' ] raise: Error

{
	#category : #tests
}
CoyEditorCodeEvaluatorTest >> testEvaluateRuntimeErrorRaisesException
	| evaluator |
	evaluator := CoyEditorCodeEvaluator new context: nil.
	self should: [ evaluator evaluate: 'nil foo' ] raise: MessageNotUnderstood

{
	#category : #tests
}
CoyEditorCodeEvaluatorTest >> testEvaluateMultilineCode
	| evaluator result |
	evaluator := CoyEditorCodeEvaluator new context: nil.
	result := evaluator evaluate: '| x | x := 10. x * 2'.
	self assert: result equals: 20
