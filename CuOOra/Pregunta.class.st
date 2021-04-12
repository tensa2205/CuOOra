"
!Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	respuestas:		<Object>
	titulo:		<Object>


    Implementation Points
"
Class {
	#name : #Pregunta,
	#superclass : #Post,
	#instVars : [
		'titulo',
		'respuestas',
		'topicos'
	],
	#category : #'CuOOra-model'
}

{ #category : #constructor }
Pregunta class >> titulo: arg1 texto: arg2 usuario: arg3 [
	^ self new titulo: arg1 texto: arg2 usuario: arg3
]

{ #category : #constructor }
Pregunta class >> titulo: arg1 texto: arg2 usuario: arg3 topicos: topics [
	^ self new titulo: arg1 texto: arg2 usuario: arg3 topicos: topics
]

{ #category : #accessing }
Pregunta >> agregarRespuestaConTexto: text usuario: user [
	respuestas add: (Respuesta texto: text usuario: user)
]

{ #category : #accessing }
Pregunta >> devolverCantidadRespuestas [
	^ respuestas size 
]

{ #category : #accessing }
Pregunta >> devolverRespuestasUsuario: user [
	^ respuestas select: [ :respuesta | respuesta chequearRespuesta: user ]
]

{ #category : #initialization }
Pregunta >> initialize [
	super initialize.
	respuestas := OrderedCollection new.
	topicos := OrderedCollection new.
]

{ #category : #accessing }
Pregunta >> respuestas [
	^ respuestas sort: [ :r1 :r2 | r1 devolverDiferenciaReacciones > r2 devolverDiferenciaReacciones  ]
]

{ #category : #accessing }
Pregunta >> titulo [
	^ titulo
]

{ #category : #constructor }
Pregunta >> titulo: title texto: text usuario: user topicos: topics [ 
	self initialize.
	titulo := title.
	texto := text.
	usuario := user.
	topicos := topics.
	
]
