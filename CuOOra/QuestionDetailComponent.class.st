Class {
	#name : #QuestionDetailComponent,
	#superclass : #CuOOraHomeComponent,
	#instVars : [
		'pregunta'
	],
	#category : #'CuOOra-ui'
}

{ #category : #callbacks }
QuestionDetailComponent >> answerQuestion [
	self 
		call: 
		(NewAnswerComponent new
		pregunta: self pregunta;
		yourself).
]

{ #category : #accessing }
QuestionDetailComponent >> pregunta [
	^ pregunta
]

{ #category : #accessing }
QuestionDetailComponent >> pregunta: question [
	pregunta := question
]

{ #category : #rendering }
QuestionDetailComponent >> renderAnswer: answer with: aCanvas [
				
	aCanvas paragraph: [ 
		aCanvas text: 'Respuesta de '.
		aCanvas anchor 
			callback:[self goToUserDetail: answer usuario];
			with:[ aCanvas strong: (answer usuario) nombreUsuario ].
		].
	
	aCanvas emphasis: answer texto .
	aCanvas break.
	
	self renderReactionsOn: aCanvas with: answer.
	aCanvas horizontalRule.
]

{ #category : #rendering }
QuestionDetailComponent >> renderContentOn: aCanvas [
	self renderLoggedUser: aCanvas.
	aCanvas horizontalRule .
	self renderQuestion: self pregunta with: aCanvas.
	
	aCanvas
		unorderedList: [ 
			( (CuOOra soleInstance) obtenerRespuestasDePregunta: (self pregunta) )
				do:[ :each | 
					(self renderAnswer: each with: aCanvas)].
		].
	
	aCanvas paragraph:[
		aCanvas space: 50.
		aCanvas text: 'No hay mas respuestas'].
	
	aCanvas break.
	
	aCanvas anchor
		callback:[self answerQuestion];
		with: '+ Agregar respuesta'.
]
