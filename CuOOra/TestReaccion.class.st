Class {
	#name : #TestReaccion,
	#superclass : #TestCase,
	#instVars : [
		'reaccion',
		'reacciones',
		'r1',
		'r2',
		'r3',
		'r4'
	],
	#category : #'CuOOra-tests'
}

{ #category : #running }
TestReaccion >> setUp [
	reacciones := OrderedCollection new.
	r1 := Reaccion voto: true usuario: 'Pepe'.
	r2 := Reaccion voto: true usuario: 'Juan'.
	r3 := Reaccion voto: false usuario: 'Diego'.
	r4 := Reaccion voto: true usuario: 'Pedro'.
	reacciones
		add: r1;
		add: r2;
		add: r3;
		add: r4
]

{ #category : #tests }
TestReaccion >> testCambiarVotos [
	r1 cambiarVoto.
	r3 cambiarVoto.
	self
		assert: r1 voto equals: false;
		assert: r3 voto
]

{ #category : #tests }
TestReaccion >> testCreation [
	self
		assert: r1 usuario equals: 'Pepe';
		assert: r1 voto;
		assert: r2 usuario equals: 'Juan';
		assert: r2 voto;
		assert: r3 usuario equals: 'Diego';
		assert: r3 voto equals: false;
		assert: r4 usuario equals: 'Pedro';
		assert: r4 voto
]

{ #category : #tests }
TestReaccion >> testDiferenciasLikesDislikes [
	| tmp1 tmp2 tmp3 |
	tmp1 := (reacciones select: [ :arg1 | arg1 voto ]) size.
	tmp2 := (reacciones reject: [ :arg2 | arg2 voto ]) size.
	tmp3 := tmp1 - tmp2.
	self assert: tmp3 equals: 2
]
