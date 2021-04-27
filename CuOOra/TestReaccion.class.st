Class {
	#name : #TestReaccion,
	#superclass : #TestCase,
	#instVars : [
		'reaccion',
		'reacciones',
		'r1',
		'r2',
		'r3',
		'r4',
		'user1',
		'user2',
		'user3',
		'user4'
	],
	#category : #'CuOOra-tests'
}

{ #category : #running }
TestReaccion >> setUp [
	reacciones := OrderedCollection new.
	 
	user1 := (Usuario nombreUsuario: 'Pepe' contraseña: 'Pepe').
	user2 := (Usuario nombreUsuario: 'Juan' contraseña: 'Juan').
	user3 := (Usuario nombreUsuario: 'Diego' contraseña: 'Diego').
	user4 := (Usuario nombreUsuario: 'Jony' contraseña: 'Jony').
	
	r1 :=(Reaccion votoPositivoDeUsuario: user1).
	r2 := (Reaccion votoPositivoDeUsuario: user2).
	r3 := (Reaccion votoNegativoDeUsuario: user3).
	r4 := (Reaccion votoPositivoDeUsuario: user4).
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
		assert: r1 usuario equals: user1;
		assert: r1 voto;
		assert: r2 usuario equals: user2;
		assert: r2 voto;
		assert: r3 usuario equals: user3;
		assert: r3 voto equals: false;
		assert: r4 usuario equals: user4;
		assert: r4 voto
]
