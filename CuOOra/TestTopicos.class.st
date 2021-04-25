Class {
	#name : #TestTopicos,
	#superclass : #TestCase,
	#instVars : [
		't1',
		'p1',
		'p2',
		'p3'
	],
	#category : #'CuOOra-tests'
}

{ #category : #running }
TestTopicos >> setUp [
	| u1 |
	t1 := Topico nombre: 'Basquet' descripcion: 'Todo sobre baloncesto.'.
	u1 := Usuario nombreUsuario: 'ElPepe' contraseña:  '123'.
	p1 := Pregunta titulo: '¿Necesitamos la vuelta de Manu Ginobili?' texto: 'Yo creo que si, ni piensen en la pregunta.'  usuario: u1.
	p2 := Pregunta titulo: 'Space Jam 2 con Lebron James, ¿Reaparecera Jordan?' texto: 'Eso, hace poco se anunció Space Jam 2 y queria saber sus opiniones sobre si va a aparecer Michael.' usuario: u1.
	p3 := Pregunta titulo: '¿Como hacer repulgue de empanadas? ' texto: 'Eso, no se repulgar empanadas :C' usuario: u1. 
	
	t1 
		registrarPregunta: p1;
		registrarPregunta: p2.
	
]

{ #category : #tests }
TestTopicos >> testAgregarPregunta [
	| preg |
	preg := Pregunta 
					titulo: '¿Cual es el mejor partido de Basquet?' 
					texto: 'Los Bulls de Jordan contra los Pistons de Rodman, for sure.' 
					usuario: (Usuario nombreUsuario: 'El pepe' contraseña: '123').
	t1 registrarPregunta: preg.
	
	self
		assert: (t1 preguntas includes: preg).
]

{ #category : #tests }
TestTopicos >> testBajaPregunta [
	t1 bajaPregunta: p1.
	self 
		assert: (t1 preguntas includes: p1) not. 
]

{ #category : #tests }
TestTopicos >> testComprobarNombre [
	self
		assert: (t1 comprobarNombre: 'bAsQUet').
]

{ #category : #tests }
TestTopicos >> testDevolverPreguntas [ 
	self 
		assert: (t1 preguntas includes: p1);
		assert: (t1 preguntas includes: p2).
]

{ #category : #tests }
TestTopicos >> testTienePregunta [
	self 
		assert: (t1 preguntas includes: p3) not;
		assert: (t1 preguntas includes: p1).
]
