Class {
	#name : #TestPregunta,
	#superclass : #TestCase,
	#instVars : [
		'p1',
		'res1',
		'res2'
	],
	#category : #'CuOOra-tests'
}

{ #category : #running }
TestPregunta >> setUp [
	p1 := Pregunta titulo: 'Hola' texto: 'Mundo' usuario: 'Pepe'.
	res1 := Respuesta texto: 'xxxxxxx' usuario: 'Diego'.
	res2 := Respuesta texto: 'yyyyyyy' usuario: 'Pedro'.
	p1 respuestas
		add: res1;
		add: res2
]

{ #category : #tests }
TestPregunta >> testAgregarRespuesta [
	| tmp1 tmp2 |
	tmp1 := 'Sigue adelante'.
	tmp2 := 'MotivationalManager'.
	self assert: p1 respuestas size equals: 2.
	p1 agregarRespuestaConTexto: tmp1 usuario: tmp2.
	self assert: p1 respuestas size equals: 3
]

{ #category : #tests }
TestPregunta >> testCreation [
	self
		assert: p1 titulo equals: 'Hola';
		assert: p1 texto equals: 'Mundo';
		assert: p1 usuario equals: 'Pepe'
]

{ #category : #tests }
TestPregunta >> testDarLikeDislike [
	| tmp1 tmp2 tmp3 |
	tmp1 := 'Diego'.
	tmp2 := 'Pedro'.
	p1
		darLike: tmp1;
		darLike: tmp2.
	tmp3 := p1 devolverDiferenciaReacciones.
	self assert: tmp3 equals: 2.
	p1 darDislike: tmp2.
	tmp3 := p1 devolverDiferenciaReacciones.
	self assert: tmp3 equals: 0
]

{ #category : #tests }
TestPregunta >> testDevolverRespuestasUsuario [
	| tmp1 tmp2 |
	tmp2 := 'Pedro'.
	tmp1 := p1 devolverRespuestasUsuario: tmp2.
	self assert: (tmp1 allSatisfy: [ :arg1 | arg1 usuario = tmp2 ])
]

{ #category : #tests }
TestPregunta >> testRespuestas [
	p1 respuestas.
	self assert: p1 respuestas size equals: 2
]
