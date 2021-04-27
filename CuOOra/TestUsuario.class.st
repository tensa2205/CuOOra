Class {
	#name : #TestUsuario,
	#superclass : #TestCase,
	#instVars : [
		'user1',
		'toFollow',
		'p1',
		'p2',
		'p3',
		'r1',
		'r2',
		't1',
		'user3',
		'p4'
	],
	#category : #'CuOOra-tests'
}

{ #category : #running }
TestUsuario >> setUp [
	"Usuarios"
	user1 := Usuario nombreUsuario: 'Raul' contraseña: '12345'.
	toFollow := Usuario nombreUsuario: 'Messi' contraseña: 'Messirve'.
	user3 := Usuario nombreUsuario: 'another' contraseña: 'otro'.
	
	"Preguntas"
	p1 := Pregunta titulo: '???' texto: 'no se nada' usuario: user1.
	p2 := Pregunta titulo: '!!!' texto: 'que' usuario: user1.
	p3 := Pregunta titulo: 'Soy Messi' texto: 'Soy el mejor jugador de la historia?' usuario: toFollow .
	p4 := Pregunta titulo: 'ready' texto: 'alla vamos' usuario: user3.
	
	"Acciones"
	user1
		registrarPregunta: p1;
		registrarPregunta: p2.
	toFollow registrarPregunta: p3.
	user3 registrarPregunta: p4.
	
	r1 := p1 agregarRespuestaConTexto: 'hola' usuario: toFollow.
	r2 := p3 agregarRespuestaConTexto: 'si lo eres' usuario: user1.
	
	p2 recibirReaccion: (Reaccion votoNegativoDeUsuario: toFollow ).
	r2 recibirReaccion: (Reaccion votoPositivoDeUsuario: toFollow).
	
	
	t1 := Topico nombre: 'Futbol' descripcion: 'Todo sobre futbol'.
	t1 registrarPregunta: p4.
]

{ #category : #tests }
TestUsuario >> testBajaPregunta [ 
	user1 bajaPregunta: p1.
	self 
		assert: (user1 preguntasHechas includes: p1) not.
]

{ #category : #tests }
TestUsuario >> testDevolverPreguntasRelevantes [
	| preguntasRel pregunta |
	user1 seguirUsuario: toFollow.
	preguntasRel := user1 devolverPreguntasRelevantes.
	pregunta := preguntasRel first.
	
	self 	assert: preguntasRel size equals: 1;
			assert: (pregunta usuario) equals: toFollow .
		
	user1 registrarTopicoDeInteres: t1.
	preguntasRel := user1 devolverPreguntasRelevantes.
	self 
		assert: preguntasRel size equals: 2;
		assert: (preguntasRel includes: p4).
]

{ #category : #tests }
TestUsuario >> testDevolverPuntajePreguntas [
	"-Hizo dos preguntas: 40 puntos.
	 -Le dieron un dislike a una de sus preguntas, le resta un punto."
	self assert: user1 devolverPuntajePreguntas equals: 39.
]

{ #category : #tests }
TestUsuario >> testPreguntasHechas [
	user1 preguntasHechas.
	self
		assert: user1 preguntasHechas size equals: 2;
		assert: (user1 preguntasHechas includes: p1);
		assert: (user1 preguntasHechas includes: p2).
]

{ #category : #tests }
TestUsuario >> testSeguirUsuario [
	user1 seguirUsuario: toFollow.
	self assert: user1 seguidos size equals: 1.
	user1 seguirUsuario: user3.
	self assert: user1 seguidos size equals: 2.
	
	self 
		assert: (user1 seguidos includes: toFollow);
		assert: (user1 seguidos includes: user3).
]

{ #category : #tests }
TestUsuario >> testTopicoInteres [
	| first |
	user1 registrarTopicoDeInteres: t1.
	first := user1 topicosInteres first.
	self
		assert: user1 topicosInteres size equals: 1;
		assert: first descripcion equals: 'Todo sobre futbol';
		assert: first nombre equals: 'Futbol'
]
