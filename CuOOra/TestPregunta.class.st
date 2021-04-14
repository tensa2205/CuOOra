Class {
	#name : #TestPregunta,
	#superclass : #TestCase,
	#instVars : [
		'p1',
		'res1',
		'res2',
		'user'
	],
	#category : #'CuOOra-tests'
}

{ #category : #running }
TestPregunta >> setUp [
	user := Usuario nombreUsuario: 'El pepe' contraseña: '1' .
	p1 := Pregunta titulo: 'Hola' texto: 'Mundo' usuario: 'Pepe'.
	
	p1 agregarRespuestaConTexto: 'xxxxxxx' usuario: 'Diego'.
	p1 agregarRespuestaConTexto: 'yyyyyyy' usuario: 'Pedro'.
]

{ #category : #tests }
TestPregunta >> testAgregarRespuesta [
	self assert: p1 respuestas size equals: 2.
	p1 agregarRespuestaConTexto: 'Sigue adelante' usuario: user.
	self 
		assert: p1 respuestas size equals: 3;
		assert: (p1 respuestas at: 3) texto equals: 'Sigue adelante'.
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
