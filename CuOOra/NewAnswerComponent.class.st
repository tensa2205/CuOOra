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
		class:'btn btn-danger';
		callback: [ self goBackQuestion  ];
		with: 'Cancelar'.
	aCanvas space:5 .
	aCanvas submitButton 
		class: 'btn btn-success';
		callback: [ self uploadAnswer  ];
		with: 'Guardar'
]

{ #category : #rendering }
NewAnswerComponent >> renderContentOn: aCanvas [ 
		aCanvas div 
	class: 'container';
	with:[ 
		aCanvas div 
			class: 'row';
			with:
			[
			aCanvas div
				class: 'col align-self-center';
				with: [ 
					self renderLoggedUser: aCanvas.
					aCanvas horizontalRule.
					self renderQuestion: (self pregunta)  with: aCanvas.
	
					aCanvas form:[
					self renderInputElementsOn: aCanvas.
					aCanvas break.
					self renderButtonsOn: aCanvas.
					].
				]]]
]

{ #category : #rendering }
NewAnswerComponent >> renderInputElementsOn: aCanvas [

	aCanvas div
			class: 'form-group col-7 ';
			with:[
			 	aCanvas paragraph: [  
				aCanvas label 
				with:[ aCanvas emphasis:'Responder:' ] ].
			
		  		aCanvas textArea 
				class: 'form-control required';
				columns:80;
				rows:7;
				callback: [ :valorNuevo | self texto: valorNuevo ];
				placeholder: 'Escriba aqui el texto de su respuesta.' ].	
	
		
		
		
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
	(self validarRespuesta )
	ifFalse: [ ^ self ].
	self pregunta agregarRespuestaConTexto: (self texto) usuario: (self session user).
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

{ #category : #operation }
NewAnswerComponent >> validarRespuesta [
	^ self texto isNotEmpty 
]
