Class {
	#name : #RegisterComponent,
	#superclass : #AccessGrantingComponentWithStyle,
	#category : #'CuOOra-ui'
}

{ #category : #callbacks }
RegisterComponent >> goBackHome [
	self answer
]

{ #category : #rendering }
RegisterComponent >> registerAndLogin [
	| newUser |
	newUser := Usuario nombreUsuario: userName  contraseña: password .
	self model crearUsuarioConNombre: (newUser nombreUsuario) contraseña: (newUser contraseña)  .
	self proceedWith: newUser   
]

{ #category : #rendering }
RegisterComponent >> renderButtonsOn: aCanvas [
	self renderSignUpButtonOn: aCanvas
]

{ #category : #rendering }
RegisterComponent >> renderSignUpButtonOn: aCanvas [
	aCanvas submitButton 
		class: 'btn btn-success';
		callback: [ self registerAndLogin ];
		with: 'Registrarse'.
	aCanvas cancelButton 
		class: 'btn btn-danger'; 
		callback: [ self goBackHome  ];
		with: 'Cancelar'.
]
