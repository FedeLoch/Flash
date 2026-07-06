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
			package: 'Flash-Events' with: [ spec requires: #('Coypu') ];
			package: 'Flash-Effects';
			package: 'Flash-Themes' with: [ spec requires: #('Flash-Effects' 'Flash-Events') ];
			package: 'Flash-Themes-Editor' with: [ spec requires: #('Flash-Themes' 'Flash-Core') ];
			package: 'Flash-Tests-Core' with: [ spec requires: #('Flash-Core') ];
			package: 'Flash-Tests-Events' with: [ spec requires: #('Flash-Events') ];
			package: 'Flash-Tests-Effects' with: [ spec requires: #('Flash-Effects') ];
			package: 'Flash-Tests-Themes' with: [ spec requires: #('Flash-Themes') ];
			package: 'Flash-Tests-Integration' with: [ spec requires: #('Flash-Core' 'Flash-Events' 'Coypu') ].
		spec
			group: 'default' with: #('Flash-Core' 'Flash-Events' 'Flash-Effects' 'Flash-Themes');
			group: 'editor' with: #('Flash-Core');
			group: 'effects' with: #('Flash-Effects');
			group: 'themes' with: #('Flash-Themes');
			group: 'tests' with: #('Flash-Tests-Core' 'Flash-Tests-Events' 'Flash-Tests-Effects' 'Flash-Tests-Themes' 'Flash-Tests-Integration');
			group: 'all' with: #('default' 'tests') ]
