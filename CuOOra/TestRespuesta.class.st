Class {
	#name : #TestRespuesta,
	#superclass : #TestCase,
	#instVars : [
		'answer',
		'user',
		'userNot'
	],
	#category : #'CuOOra-tests'
}

{ #category : #running }
TestRespuesta >> setUp [
	user := Usuario nombreUsuario: 'Pepito' contraseña: '1'.
	userNot := Usuario nombreUsuario: 'Astraz' contraseña: '10'.
	answer := Respuesta texto: 'Soy una respuesta.' usuario: user.
	
	answer
		recibirReaccion: (Reaccion votoPositivoDeUsuario: (Usuario nombreUsuario: 'Juan' contraseña: '1') );
		recibirReaccion: (Reaccion votoNegativoDeUsuario: (Usuario nombreUsuario: 'Jon' contraseña: '2'));
		recibirReaccion: (Reaccion votoPositivoDeUsuario: (Usuario nombreUsuario: 'Jin' contraseña: '3')). 

]

{ #category : #tests }
TestRespuesta >> testCalcularPuntaje [
	self
		assert: answer calcularPuntaje equals: 51
]

{ #category : #tests }
TestRespuesta >> testChequearUsuario [
	self
		assert: (answer chequearRespuesta: user);
		assert: (answer chequearRespuesta: userNot) not.
]

{ #category : #accessing }
TestRespuesta >> testCreation [
	self
		assert: answer texto equals: 'Soy una respuesta.';
		assert: answer usuario equals: user
]
