Class {
	#name : #TestTopicos,
	#superclass : #TestCase,
	#instVars : [
		't1',
		'p1',
		'p2'
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
	
	t1 
		registrarPregunta: p1;
		registrarPregunta: p2.
	
]

{ #category : #tests }
TestTopicos >> testBajaPregunta [
	t1 bajaPregunta: p1.
	self assert: t1 preguntas size equals: 1
]

{ #category : #tests }
TestTopicos >> testDevolverPreguntas [ 
	| pregs |
	pregs := t1 preguntas .
	self assert: pregs size equals: 2
]
