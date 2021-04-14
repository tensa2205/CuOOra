Class {
	#name : #NewAnswerComponent,
	#superclass : #QuestionDetailComponent,
	#instVars : [
		'usuario',
		'texto'
	],
	#category : #'CuOOra-ui'
}

{ #category : #callbacks }
NewAnswerComponent >> goBackQuestion [
	self answer
]

{ #category : #rendering }
NewAnswerComponent >> renderButtonsOn: aCanvas [
	aCanvas button 
		callback: [ self goBackQuestion  ];
		with: 'Cancelar'.
	aCanvas space:5 .
	aCanvas submitButton 
		callback: [ self uploadAnswer  ];
		with: 'Guardar'
]

{ #category : #rendering }
NewAnswerComponent >> renderContentOn: aCanvas [ 
	self renderLoggedUser: aCanvas.
	aCanvas horizontalRule.
	self renderQuestion: (self pregunta)  with: aCanvas.
	
	aCanvas form:[
		self renderInputElementsOn: aCanvas.
		aCanvas break.
		self renderButtonsOn: aCanvas.
		].
]

{ #category : #rendering }
NewAnswerComponent >> renderInputElementsOn: aCanvas [
	aCanvas paragraph: [  
		aCanvas label 
			with:[ aCanvas emphasis:'Responder:' ] 
		].
		aCanvas paragraph: [ 
			aCanvas space: 10.
			aCanvas textArea
				columns:80;
				rows:7;
				callback: [ :valorNuevo | self texto: valorNuevo ];
				with: 'Escriba aqui el texto de su respuesta.' ].
		
]

{ #category : #accessing }
NewAnswerComponent >> texto [
	^ texto
]

{ #category : #accessing }
NewAnswerComponent >> texto: text [
	texto := text
]

{ #category : #callbacks }
NewAnswerComponent >> uploadAnswer [
	self model agregarRespuestaDeUsuario: (self session user) aPregunta: (self pregunta) conTexto: (self texto).
	self goBackQuestion 
]

{ #category : #accessing }
NewAnswerComponent >> usuario [ 
	^ usuario
]

{ #category : #accessing }
NewAnswerComponent >> usuario: anUser [
	usuario := anUser
]
