Class {
	#name : #NewQuestionComponent,
	#superclass : #CuOOraHomeComponent,
	#instVars : [
		'titulo',
		'texto',
		'topicos'
	],
	#category : #'CuOOra-ui'
}

{ #category : #operation }
NewQuestionComponent >> crearColeccionDeTopicos: coleccionFiltrada [
	^ (coleccionFiltrada collect:[:nombre | self transformarATopico: nombre]) removeDuplicates 
]

{ #category : #parsing }
NewQuestionComponent >> filtrarTopicosValidos [
	^ (self parsearTopicos ) select: [ :nombreTopico | self validarTexto: nombreTopico ]
]

{ #category : #callbacks }
NewQuestionComponent >> goBackHome [
	self answer 
]

{ #category : #parsing }
NewQuestionComponent >> parsearTopicos [
	^ (self separarTopicos ) collect: [ :nombreTopico | nombreTopico trimBoth ].
]

{ #category : #rendering }
NewQuestionComponent >> registrar [
	(self validarPregunta)
	ifFalse: [ ^ self ].
	self model agregarPreguntaATopico: (self topicos)  yUsuario: (self session user) conTitulo: (self titulo)  conDescripcion: (self texto).
	self goBackHome .
	
]

{ #category : #rendering }
NewQuestionComponent >> renderButtonsOn: aCanvas [
	aCanvas button 
		class:'btn btn-danger';
		callback: [ self goBackHome ];
		with: 'Cancelar'.
	aCanvas space:5 .
	aCanvas submitButton 
		class: 'btn btn-success';
		callback: [ self registrar  ];
		with: 'Guardar'
]

{ #category : #rendering }
NewQuestionComponent >> renderContentOn: aCanvas [
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
					aCanvas heading level:2 ; with: 'Nueva pregunta'.
					aCanvas form:[
						self renderInputElementsOn: aCanvas.
						aCanvas break.
					self renderButtonsOn: aCanvas.
					]]].
	aCanvas horizontalRule. ]
]

{ #category : #rendering }
NewQuestionComponent >> renderInputElementsOn: aCanvas [
		
			aCanvas div
			class: 'form-group col-7';
			with:[
			 	aCanvas paragraph: [  
				aCanvas label 
				with:[ aCanvas emphasis:'Titulo:' ] ].
		  		aCanvas textInput 
				class: 'form-control required';
				callback: [ :valorNuevo | self titulo: valorNuevo ];
				placeholder: 'Escriba aqui el titulo de su pregunta.' ].
	
		aCanvas break.
		
		aCanvas div
			class: 'form-group col-7 ';
			with:[
			 	aCanvas paragraph: [  
				aCanvas label 
				with:[ aCanvas emphasis:'Desarrollo:' ] ].
			
		  		aCanvas textArea 
				class: 'form-control required';
				columns:80;
				rows:7;
				callback: [ :valorNuevo | self texto: valorNuevo ];
				placeholder: 'Escriba aqui el texto de su pregunta.' ].	
	
		
		aCanvas div
			class: 'form-group col-7';
			with:[
			 	aCanvas paragraph: [  
				aCanvas label 
				with:[ aCanvas emphasis:'Topicos:' ] ].
		  		aCanvas textInput 
				class: 'form-control required';
				callback: [:valorNuevo | self topicos: valorNuevo  ];
				placeholder: 'Ingrese los topicos separados por coma.'] 
	
]

{ #category : #parsing }
NewQuestionComponent >> separarTopicos [
"Separa los tópicos eliminando las comas y los devuelve como colección"
	^ (topicos substrings: ',') asOrderedCollection 
]

{ #category : #accessing }
NewQuestionComponent >> texto [ 
	^ texto 
]

{ #category : #accessing }
NewQuestionComponent >> texto: text [ 
	texto := text
]

{ #category : #accessing }
NewQuestionComponent >> titulo [ 
	^ titulo 
]

{ #category : #accessing }
NewQuestionComponent >> titulo: title [ 
	titulo := title
]

{ #category : #accessing }
NewQuestionComponent >> topicos [ 
	^ self crearColeccionDeTopicos: (self filtrarTopicosValidos ).
]

{ #category : #accessing }
NewQuestionComponent >> topicos: topics [
	topicos := topics
]

{ #category : #operation }
NewQuestionComponent >> transformarATopico: nombreTopico [
	^ (self model comprobarExistenciaTopico: nombreTopico ) ifNil: [ ^ self model agregarTopicoConNombre: nombreTopico descripcion: '' ]
]

{ #category : #operation }
NewQuestionComponent >> validarPregunta [
	"Si la pregunta es válida entonces puedo crearla"
	^ ((self validarTexto: titulo ) 
			and:[ 
				(self validarTexto: texto) 
					and:[ self topicos isNotEmpty ]
					]
				)
]

{ #category : #operation }
NewQuestionComponent >> validarTexto: aString [
	^ aString isNotEmpty 
]
