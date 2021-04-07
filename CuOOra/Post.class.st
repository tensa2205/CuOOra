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
Post >> cantDislikes [
	^ (reacciones reject: [ :react | react voto ]) size.
]

{ #category : #accessing }
Post >> cantLikes [
	^ (reacciones select: [ :react | react voto ]) size.
]

{ #category : #accessing }
Post >> darDislike: user [
	| react |
	react := reacciones select: [ :reaccion | reaccion usuario = user ].
	react
		ifEmpty: [ reacciones add: (Reaccion voto: false usuario: user).
			^ self ].
	react := react first.
	react voto
		ifTrue: [ react cambiarVoto ]
]

{ #category : #accessing }
Post >> darLike: user [
	| react |
	react := reacciones select: [ :reaccion| reaccion usuario = user ].
	react
		ifEmpty: [ reacciones add: (Reaccion voto: true usuario: user).
			^ self ].
	react := react first.
	react voto
		ifFalse: [ react cambiarVoto ]
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
Post >> texto [
	^ texto
]

{ #category : #accessing }
Post >> usuario [
	^ usuario
]
