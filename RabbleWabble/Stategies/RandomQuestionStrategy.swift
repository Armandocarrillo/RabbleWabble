//
//  RandomQuestionStrategy.swift
//  RabbleWabble
//
//  Created by Armando Carrillo on 18/08/20.
//  Copyright © 2020 Armando Carrillo. All rights reserved.
//


import GameplayKit.GKRandomSource

public class RandomQuestionStrategy: QuestionStrategy {
    // MARK: - PROPERTIES
    
    public var correctCount: Int = 0
    public var incorrectCount: Int = 0
    private let questionGroup: QuestionGroup
    private var questionIndex = 0
    private let questions: [Question]
    
    //MARK: -Object Lifecycle
    public init(questionGroup: QuestionGroup) {
        self.questionGroup = questionGroup
        
        let randomSource = GKRandomSource.sharedRandom()//singleton instance of GKRandomSource
        self.questions = randomSource.arrayByShufflingObjects(in: questionGroup.questions) as! [Question]//it takes an array and randomly shuffles the elements, return a array
    }
    //MARK: -QuestionStrategy
    public var title: String{ //to need to update QuestionViewController
        
        return questionGroup.title
    }
    
    public func currentQuestion() -> Question {
        return questions[questionIndex]
    }
    
    public func advanceToNextQuestion() -> Bool {
        guard questionIndex + 1 < questions.count else {
            return false
        }
        questionIndex += 1
        return true
    }
    
    public func markQuestionCorrect(_ question: Question) {
        correctCount += 1
    }
    
    public func markQuestionIncorrect(_ question: Question) {
        incorrectCount += 1
    }
    
    public func questionIndexTitle() -> String {
        return "\(questionIndex + 1)/\(questions.count)"
    }
}
