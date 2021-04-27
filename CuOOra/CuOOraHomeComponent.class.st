Class {
	#name : #CuOOraHomeComponent,
	#superclass : #WAComponent,
	#category : #'CuOOra-ui'
}

{ #category : #accessing }
CuOOraHomeComponent >> dislike: aPost [
	aPost recibirReaccion: (Reaccion votoNegativoDeUsuario: (self session user))
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

{ #category : #accessing }
CuOOraHomeComponent >> like: aPost [
	aPost recibirReaccion: (Reaccion votoPositivoDeUsuario: (self session user))
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
				aCanvas horizontalRule .
				self renderMakeACuestionOn: aCanvas.
				self renderLastQuestions: aCanvas].
			 ]
		]
]

{ #category : #rendering }
CuOOraHomeComponent >> renderLastQuestions: aCanvas [
	aCanvas heading
		level: 3;
		with: 'Ultimas Preguntas'.
	aCanvas
		unorderedList: [ 
			(self model obtenerPreguntasRelevantesDeUsuario: self session user)
				do:[ :each | 
					(self renderQuestion: each with: aCanvas)].
		].
	
]

{ #category : #rendering }
CuOOraHomeComponent >> renderLoggedUser: aCanvas [
	aCanvas heading
		class:' mt-3';
		with: 'CuOOra'.
	
	aCanvas div 
	class: 'container';
	with:[ 
		aCanvas div 
			class: 'row';
			with:[
			aCanvas div
			class: 'col-9'.
			aCanvas div
				class: 'col align-self-center';
				with: [ 
				aCanvas paragraph: [  
				
				aCanvas text: self session user nombreUsuario.
				aCanvas space: 3.
				aCanvas anchor
					callback: [self logout ];
					with: 'Log out'.
		]]]]. 
]

{ #category : #rendering }
CuOOraHomeComponent >> renderMakeACuestionOn: aCanvas [

  aCanvas div 
	class: 'container col-12';
	with:[ 
		aCanvas div 
			class: 'row';
			with:[
			aCanvas div
			class: 'col-9'.
			aCanvas div
				class: 'col align-self-center';
				with: [ 
				aCanvas anchor
				class: 'link-success col-6';
				callback: [ self newQuestion  ];
				with: 'Hacer una nueva pregunta']]].
	aCanvas break.
	
]

{ #category : #rendering }
CuOOraHomeComponent >> renderQuestion: question with: aCanvas [
	aCanvas anchor
		callback:[ self goToQuestionDetail: question];
		with:[ aCanvas emphasis: (question titulo) ].
		
	aCanvas break.
	aCanvas emphasis 
		with: [
			aCanvas text:'Topicos: ' , (', ' join: (self model obtenerTopicosDePregunta: question))].
		
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
			callback: [ self like: aPost];
			with: 'like'.
		aCanvas text: ' | '.
		aCanvas anchor 
			callback: [ self dislike: aPost];
			with: 'dislike'.
		].
]

{ #category : #updating }
CuOOraHomeComponent >> updateRoot: anHtmlRoot [ 
    super updateRoot: anHtmlRoot.
    anHtmlRoot stylesheet url: 'https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css'
]
