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


    Implementation Points
"
Class {
	#name : #Respuesta,
	#superclass : #Post,
	#category : #'CuOOra-model'
}

{ #category : #constructor }
Respuesta class >> texto: arg1 usuario: arg2 [
	^ self new texto: arg1 usuario: arg2
]

{ #category : #accessing }
Respuesta >> chequearRespuesta: user [
	usuario = user
		ifFalse: [ ^ false ].
	^ true
]

{ #category : #initialization }
Respuesta >> initialize [
	super initialize
]

{ #category : #constructor }
Respuesta >> texto: arg1 usuario: arg2 [
	texto := arg1.
	usuario := arg2.
	self initialize
]
