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
	user1 := Usuario nombreUsuario: 'Raul' contraseña: '12345'.
	toFollow := Usuario nombreUsuario: 'Messi' contraseña: 'Messirve'.
	user3 := Usuario nombreUsuario: 'another' contraseña: 'otro'.
	p1 := Pregunta titulo: '???' texto: 'no se nada' usuario: 'Raul'.
	p2 := Pregunta titulo: '!!!' texto: 'que' usuario: 'Raul'.
	p3 := Pregunta
		titulo: 'Soy Messi'
		texto: 'Soy el mejor jugador de la historia?'
		usuario: 'Messi'.
	p4 := Pregunta titulo: 'ready' texto: 'alla vamos' usuario: 'another'.
	user1
		registrarPregunta: p1;
		registrarPregunta: p2.
	toFollow registrarPregunta: p3.
	r1 := p1 agregarRespuestaConTexto: 'hola' usuario: 'Messi'.
	r2 := p3 agregarRespuestaConTexto: 'si lo eres' usuario: 'Raul'.
	p2 darDislike: 'Messi'.
	r2 darLike: 'Messi'.
	t1 := Topico nombre: 'futbol' descripcion: 'todo sobre futbol'
]

{ #category : #tests }
TestUsuario >> testDevolverPreguntasRelevantes [
	| tmp1 tmp2 |
	user1 seguirUsuario: toFollow.
	tmp1 := user1 devolverPreguntasRelevantes.
	tmp2 := tmp1 first first.
	self
		assert: tmp1 size equals: 1;
		assert: tmp2 usuario equals: 'Messi'.
	t1 registrarPregunta: p4.
	user1 registrarTopicoDeInteres: t1.
	tmp1 := user1 devolverPreguntasRelevantes.
	self assert: tmp1 size equals: 2
]

{ #category : #tests }
TestUsuario >> testDevolverRespuestasUsuario [
	
]

{ #category : #tests }
TestUsuario >> testPreguntasHechas [
	user1 preguntasHechas.
	self
		assert: user1 preguntasHechas size equals: 2;
		assert: user1 preguntasHechas last titulo equals: '!!!';
		assert: user1 preguntasHechas first texto equals: 'no se nada'
]

{ #category : #tests }
TestUsuario >> testSeguirUsuario [
	user1 seguirUsuario: toFollow.
	self assert: user1 seguidos size equals: 1
]

{ #category : #tests }
TestUsuario >> testTopicoInteres [
	user1 registrarTopicoDeInteres: t1.
	self
		assert: user1 topicosInteres size equals: 1;
		assert: user1 topicosInteres first descripcion
			equals: 'todo sobre futbol';
		assert: user1 topicosInteres first nombre equals: 'futbol'
]
