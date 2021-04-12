Class {
	#name : #ComponentWithStyle,
	#superclass : #WAComponent,
	#category : #'CuOOra-ui'
}

{ #category : #updating }
ComponentWithStyle >> updateRoot: anHtmlRoot [
    super updateRoot: anHtmlRoot.
    anHtmlRoot stylesheet url: 'https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css'
]
