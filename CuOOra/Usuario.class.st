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
	contraseña:		<Object>
	nombreUsuario:		<Object>
	seguidos:		<Object>
	timeStamp:		<Object>


    Implementation Points
"
Class {
	#name : #Usuario,
	#superclass : #Object,
	#instVars : [
		'nombreUsuario',
		'contraseña',
		'timeStamp',
		'seguidos',
		'topicosInteres',
		'preguntasHechas'
	],
	#category : #'CuOOra-model'
}

{ #category : #constructor }
Usuario class >> nombreUsuario: arg1 contraseña: arg2 [
	^ self new nombreUsuario: arg1 contraseña: arg2
]

{ #category : #accessing }
Usuario >> bajaPregunta: pregunta [ 
	preguntasHechas remove: pregunta ifAbsent: [ false ]
	
	
]

{ #category : #accessing }
Usuario >> contraseña [
	^ contraseña
]

{ #category : #accessing }
Usuario >> devolverPreguntasRelevantes [
	
	"^ ((	((seguidos collect:[: seguido | seguido preguntasHechas ]) addAll: (topicosInteres collect:[:topico | topico preguntas ])) flatCollect: [ : each | each ]		) 
					removeDuplicates )"
	| relevantes |
	relevantes := OrderedCollection new.
	relevantes addAll: ( (seguidos collect:[: seguido | seguido preguntasHechas ]) flatCollect:[:each | each]).
	relevantes addAll: ( (topicosInteres collect:[:topico | topico preguntas ]) flatCollect:[:each | each]).
	relevantes flatCollect: [ : each | each ].
	^ relevantes removeDuplicates 

	

]

{ #category : #accessing }
Usuario >> devolverPuntajePreguntas [
	| diferenciaLYD |
	diferenciaLYD := preguntasHechas sumNumbers: [ : pregunta | pregunta devolverDiferenciaReacciones  ].
	^ (preguntasHechas size * 20) + diferenciaLYD 
]

{ #category : #accessing }
Usuario >> devolverRespuestasDeUsuarioEspecifico: user [
	^ (preguntasHechas
		collect: [ :preg | preg devolverRespuestasUsuario: user ]) flatCollect: [ :each | each ]
]

{ #category : #initialization }
Usuario >> initialize [
	seguidos := OrderedCollection new.
	topicosInteres := OrderedCollection new.
	preguntasHechas := OrderedCollection new
]

{ #category : #accessing }
Usuario >> nombreUsuario [
	^ nombreUsuario
]

{ #category : #constructor }
Usuario >> nombreUsuario: nom contraseña: password [
	nombreUsuario := nom.
	contraseña := password.
	timeStamp := DateAndTime now.
	self initialize
]

{ #category : #accessing }
Usuario >> preguntasHechas [
	^ preguntasHechas
]

{ #category : #accessing }
Usuario >> registrarPregunta: pregunta [
	preguntasHechas add: pregunta
]

{ #category : #accessing }
Usuario >> registrarTopicoDeInteres: topico [
	topicosInteres add: topico
]

{ #category : #accessing }
Usuario >> seguidos [
	^ seguidos
]

{ #category : #accessing }
Usuario >> seguirUsuario: user [
	seguidos add: user
]

{ #category : #accessing }
Usuario >> topicosInteres [
	^ topicosInteres
]
