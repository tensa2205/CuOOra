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
	reacciones:		<Object>
	texto:		<Object>
	timeStamp:		<Object>
	usuario:		<Object>


    Implementation Points
"
Class {
	#name : #Post,
	#superclass : #Object,
	#instVars : [
		'texto',
		'usuario',
		'timeStamp',
		'reacciones'
	],
	#category : #'CuOOra-model'
}

{ #category : #accessing }
Post >> agregarReaccion: react [
	^ (reacciones add: react)
]

{ #category : #accessing }
Post >> buscarReaccionDe: user [ 
	^ (reacciones select: [ :reaccion | reaccion usuario = user ]).
]

{ #category : #abstract }
Post >> calcularPuntaje [
	self subclassResponsibility 
]

{ #category : #accessing }
Post >> cantDislikes [
	^ ( reacciones count: [ :react | react voto not ] )
]

{ #category : #accessing }
Post >> cantLikes [
	^ ( reacciones count: [ :react | react voto ] )
]

{ #category : #accessing }
Post >> darDislike: user [
	| react |
	react := (self buscarReaccionDe: user).
	react	
		ifEmpty: [ ^ (reacciones add: (Reaccion votoNegativoDeUsuario: user)) ].
	react voto ifTrue: [ react cambiarVoto  ].
	^ react
	
	"| react |
	react := reacciones select: [ :reaccion | reaccion usuario = user ].
	react
		ifEmpty: [ reacciones add: (Reaccion votoNegativoDeUsuario: user).
			^ nil ].
	react := react first.
	react voto
		ifTrue: [ react cambiarVoto ]"
]

{ #category : #accessing }
Post >> darLike: user [
	| react |
	react := (self buscarReaccionDe: user).
	react	
		ifEmpty: [ ^ (reacciones add: (Reaccion votoPositivoDeUsuario: user)) ].
	react voto ifFalse: [ react cambiarVoto  ].
	^ react
	
	"| react |
	react := reacciones select: [ :reaccion| reaccion usuario = user ].
	react
		ifEmpty: [ reacciones add: (Reaccion votoPositivoDeUsuario: user).
			^ nil ].
	react := react first.
	react voto
		ifFalse: [ react cambiarVoto ]"
]

{ #category : #accessing }
Post >> devolverDiferenciaReacciones [
	^ self cantLikes - self cantDislikes 
]

{ #category : #accessing }
Post >> devolverFecha [
	^ timeStamp asDate
]

{ #category : #accessing }
Post >> devolverFechaYHora [
	^ timeStamp
]

{ #category : #accessing }
Post >> devolverHora [
	^ timeStamp hours asString , ':' , timeStamp minutes asString
]

{ #category : #initialization }
Post >> initialize [
	reacciones := OrderedCollection new.
	timeStamp := DateAndTime now
]

{ #category : #accessing }
Post >> recibirReaccion: booleano deUn: user [ 
	| react |
	react := self buscarReaccionDe: user.
	react
		ifNotEmpty: [ react first voto = booleano
						ifFalse: [ react first cambiarVoto  ] .
						^ react ].			
	^ self agregarReaccion: (Reaccion voto: booleano usuario: user)
]

{ #category : #accessing }
Post >> texto [
	^ texto
]

{ #category : #accessing }
Post >> usuario [
	^ usuario
]
