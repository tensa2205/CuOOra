Class {
	#name : #SessionWithUser,
	#superclass : #WASession,
	#instVars : [
		'user'
	],
	#category : #'CuOOra-ui'
}

{ #category : #accessing }
SessionWithUser >> user [
	^ user
]

{ #category : #accessing }
SessionWithUser >> user: anObject [
	user := anObject 
]
