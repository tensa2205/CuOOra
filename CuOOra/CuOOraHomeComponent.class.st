Class {
	#name : #CuOOraHomeComponent,
	#superclass : #WAComponent,
	#category : #'CuOOra-ui'
}

{ #category : #callbacks }
CuOOraHomeComponent >> dislike: question [ 
	self model registrarDislikeDeUsuario: (self session user) aPost: question
	
]

{ #category : #callbacks }
CuOOraHomeComponent >> goToQuestionDetail: question [ 
	self
		call:(
			QuestionDetailComponent new 
			pregunta: question;
			yourself)
]

{ #category : #callbacks }
CuOOraHomeComponent >> goToUserDetail: user [
	self 
		call: 
			(UserDetailComponent new 
				usuario: user;
				yourself)
]

{ #category : #callbacks }
CuOOraHomeComponent >> like: question [
	self model registrarLikeDeUsuario: (self session user)   aPost: question
	  
	
]

{ #category : #callbacks }
CuOOraHomeComponent >> logout [
	self session unregister.
	self requestContext redirectTo: self application url
]

{ #category : #model }
CuOOraHomeComponent >> model [
	^ CuOOra soleInstance 
	
	
	
]

{ #category : #callbacks }
CuOOraHomeComponent >> newQuestion [
	self call: NewQuestionComponent new.
]

{ #category : #rendering }
CuOOraHomeComponent >> renderContentOn: aCanvas [
	self renderLoggedUser: aCanvas.
	aCanvas horizontalRule .
	aCanvas anchor
		callback: [ self newQuestion  ];
		with: 'HACE UNA NUEVA PREGUNTA FLACO.'.
	aCanvas break.
	self renderLastQuestions: aCanvas.
]

{ #category : #rendering }
CuOOraHomeComponent >> renderLastQuestions: aCanvas [
	aCanvas heading: 'Ultimas preguntas'.
	aCanvas
		unorderedList: [ 
			(self model obtenerPreguntasRelevantesDeUsuario: self session user)
				do:[ :each | 
					(self renderQuestion: each with: aCanvas)].
		].
	
]

{ #category : #rendering }
CuOOraHomeComponent >> renderLoggedUser: aCanvas [
	aCanvas heading:'CuooRa'.
	
	aCanvas paragraph: [  
		aCanvas space: 50.
		aCanvas text: self session user nombreUsuario.
		aCanvas space: 3.
		aCanvas anchor
			callback: [self logout ];
			with: 'Log out'.
		].
]

{ #category : #rendering }
CuOOraHomeComponent >> renderQuestion: question with: aCanvas [
	aCanvas anchor
		callback:[ self goToQuestionDetail: question];
		with:[ aCanvas emphasis: (question titulo) ].
		
	aCanvas break.
	aCanvas emphasis 
		with: [
			aCanvas text:'Topicos: ' , (', ' join: question topicos)].
		
	aCanvas paragraph: [ 
		aCanvas text: 'Realizada por '.
		aCanvas anchor 
			callback:[self goToUserDetail: question usuario];
			with:[ aCanvas strong: (question usuario) nombreUsuario ].
		aCanvas text: ' | ', question 						devolverCantidadRespuestas asString , ' respuestas'
		].
	
	self renderReactionsOn: aCanvas with: question.
	aCanvas horizontalRule.
		
]

{ #category : #rendering }
CuOOraHomeComponent >> renderReactionsOn: aCanvas with: aPost [
	aCanvas text: aPost cantLikes asString, ' likes', ' | ', aPost cantDislikes asString, ' dislikes' .
	
	aCanvas paragraph:[
		aCanvas anchor 
			callback: [ self like: aPost ];
			with: 'like'.
		aCanvas text: ' | '.
		aCanvas anchor 
			callback: [ self dislike: aPost ];
			with: 'dislike'.
		].
]
