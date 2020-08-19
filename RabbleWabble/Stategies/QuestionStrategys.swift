//
//  QuestionStrategys.swift
//  RabbleWabble
//
//  Created by Armando Carrillo on 18/08/20.
//  Copyright © 2020 Armando Carrillo. All rights reserved.
//


//creates the protocol at the heart of the strategy

public protocol QuestionStrategy: class {
    var title: String { get } //will be the tittle for which set of question is selected
    
    var correctCount : Int { get } //will return the current number
    var incorrectCount : Int { get }

    func  advanceToNextQuestion() -> Bool //will be used to move onto the next question
    
    func currentQuestion() -> Question //will return the current question.
    
    func markQuestionCorrect(_ question: Question)// will mark a question correct
    func markQuestionIncorrect(_ question: Question)// will mark a question incorrect
    
    func questionIndexTitle() -> String //will return the index title for the current question to indicate progress
    
    
}

