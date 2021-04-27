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
	timeStamp:		<Object>
	voto:		<Object>


    Implementation Points
"
Class {
	#name : #Reaccion,
	#superclass : #Object,
	#instVars : [
		'voto',
		'timeStamp',
		'usuario'
	],
	#category : #'CuOOra-model'
}

{ #category : #constructor }
Reaccion class >> votoNegativoDeUsuario: arg2 [
	^ self new voto: false usuario: arg2
]

{ #category : #constructor }
Reaccion class >> votoPositivoDeUsuario: arg2 [
	^ self new voto: true usuario: arg2
]

{ #category : #accessing }
Reaccion >> cambiarVoto [
	voto := voto not
]

{ #category : #accessing }
Reaccion >> usuario [
	^ usuario
]

{ #category : #accessing }
Reaccion >> voto [
	^ voto
]

{ #category : #constructor }
Reaccion >> voto: vote usuario: user [
	voto := vote.
	usuario := user.
	timeStamp := DateAndTime now
]
