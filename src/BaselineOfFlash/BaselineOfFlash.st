Class {
	#name : #BaselineOfFlash,
	#superclass : #BaselineOf,
	#category : #BaselineOfFlash
}

{
	#category : #baselines
}
BaselineOfFlash >> baseline: spec
	<baseline>
	spec for: #common do: [
		spec
			baseline: 'Coypu'
			with: [ spec repository: 'github://lucretiomsp/coypu:master' ].
		spec
			package: 'Flash-Core' with: [ spec requires: #('Coypu') ];
			package: 'Flash-Editor' with: [ spec requires: #('Flash-Core' 'Flash-Events' 'Flash-Effects' 'Flash-Themes') ];
			package: 'Flash-Events' with: [ spec requires: #('Coypu') ];
			package: 'Flash-Effects';
			package: 'Flash-Themes' with: [ spec requires: #('Flash-Effects' 'Flash-Events') ];
			package: 'Flash-Themes-Editor' with: [ spec requires: #('Flash-Themes' 'Flash-Editor') ];
			package: 'Flash' with: [ spec requires: #('Flash-Core' 'Flash-Editor' 'Flash-Events' 'Flash-Effects' 'Flash-Themes') ];
			package: 'Flash-Tests-Core' with: [ spec requires: #('Flash-Core') ];
			package: 'Flash-Tests-Editor' with: [ spec requires: #('Flash-Editor') ];
			package: 'Flash-Tests-Events' with: [ spec requires: #('Flash-Events') ];
			package: 'Flash-Tests-Effects' with: [ spec requires: #('Flash-Effects') ];
			package: 'Flash-Tests-Themes' with: [ spec requires: #('Flash-Themes') ];
			package: 'Flash-Tests-Integration' with: [ spec requires: #('Flash-Editor' 'Flash-Events' 'Coypu') ] ]

