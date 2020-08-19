//
//  BaseQuestionStrategy.swift
//  RabbleWabble
//
//  Created by Armando Carrillo on 19/08/20.
//  Copyright © 2020 Armando Carrillo. All rights reserved.
//

public class BaseQuestionStrategy: QuestionStrategy {
    
    
    
    //MARK: - Properties
    
    public var correctCount: Int {
        get {
            return questionGroup.score.correctCount
        } set {
            questionGroup.score.correctCount = newValue
        }
    }
    public var incorrectCount: Int {
        get {
            return questionGroup.score.incorrectCount
        } set {
            questionGroup.score.incorrectCount = newValue
        }
    }
    
    private var questionGroupCarataker: QuestionGroupCarataker
    
    private var questionGroup: QuestionGroup{
        return questionGroupCarataker.selectedQuestionGroup
    }
    
    private var questionIndex = 0
    private let questions: [Question]
    
    //MARK: - Object Lifecycle
    
    public init(questionGroupCarataker: QuestionGroupCarataker,
                questions: [Question]){
        self.questionGroupCarataker = questionGroupCarataker
        self.questions = questions
        
        self.questionGroupCarataker.selectedQuestionGroup.score = QuestionGroup.Score()
        
    }
    
    //MARK: - QuestionStrategy
    public var title: String{
        return questionGroup.title
    }
    
    public func currentQuestion() -> Question {
        return questions[questionIndex]
    }
    
    public func advanceToNextQuestion() -> Bool {
        try? questionGroupCarataker.save() //save whenever the next question is requested
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
