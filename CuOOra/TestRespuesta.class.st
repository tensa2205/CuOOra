Class {
	#name : #TestRespuesta,
	#superclass : #TestCase,
	#instVars : [
		'answer',
		'user'
	],
	#category : #'CuOOra-tests'
}

{ #category : #running }
TestRespuesta >> setUp [
	answer := Respuesta texto: 'Soy una respuesta.' usuario: user.
	
	answer
		recibirReaccion: true deUn: (Usuario nombreUsuario: 'Juan' contraseña: '1');
		recibirReaccion: false deUn: (Usuario nombreUsuario: 'Jon' contraseña: '2');
		recibirReaccion: true deUn: (Usuario nombreUsuario: 'Jin' contraseña: '3'). 

]

{ #category : #tests }
TestRespuesta >> testCalcularPuntaje [
	self
		assert: answer calcularPuntaje equals: 51
]

{ #category : #tests }
TestRespuesta >> testChequearUsuario [
	self
		assert: (answer chequearRespuesta: user).
]

{ #category : #accessing }
TestRespuesta >> testCreation [
	self
		assert: answer texto equals: 'Soy una respuesta.';
		assert: answer usuario equals: user
]
