Class {
	#name : #TestPregunta,
	#superclass : #TestCase,
	#instVars : [
		'p1',
		'res1',
		'res2',
		'user',
		'userPrueba1',
		'userPrueba2'
	],
	#category : #'CuOOra-tests'
}

{ #category : #running }
TestPregunta >> setUp [
	user := Usuario nombreUsuario: 'El pepe' contraseña: '1' .
	p1 := Pregunta titulo: 'Hola' texto: 'Mundo' usuario: user.
	userPrueba1 := Usuario nombreUsuario: 'Pedro' contraseña: '3'.
	userPrueba2 := Usuario nombreUsuario: 'Dieg' contraseña: '2'.
	
	res1 := p1 agregarRespuestaConTexto: 'El mejor anime del mundo? Bleach.' usuario: userPrueba2.
	res2 := p1 agregarRespuestaConTexto: 'El de arriba no conoce de anime, yo digo que Demon Slayer.' usuario: userPrueba1 .
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
		assert: p1 usuario equals: user
]

{ #category : #tests }
TestPregunta >> testDarLikeDislike [
	p1
		recibirReaccion: (Reaccion votoPositivoDeUsuario: userPrueba2 ) ;
		recibirReaccion: (Reaccion votoPositivoDeUsuario: userPrueba1 ) .
		 
	self assert: p1 devolverDiferenciaReacciones equals: 2.
	
	p1 
		recibirReaccion: (Reaccion votoNegativoDeUsuario: userPrueba1 ).
	
	self assert: p1 devolverDiferenciaReacciones equals: 0
]

{ #category : #tests }
TestPregunta >> testDevolverRespuestasUsuario [
	| respuestas |
	respuestas := p1 devolverRespuestasUsuario: userPrueba1 .
	self assert: (respuestas allSatisfy: [ :arg1 | arg1 usuario = userPrueba1  ])
]

{ #category : #tests }
TestPregunta >> testRespuestas [
	| answers |
	answers := p1 respuestas.
	self
		assert: (answers at: 2) texto equals: 'El mejor anime del mundo? Bleach.';
		assert: (answers at: 1) texto equals: 'El de arriba no conoce de anime, yo digo que Demon Slayer.'
]
