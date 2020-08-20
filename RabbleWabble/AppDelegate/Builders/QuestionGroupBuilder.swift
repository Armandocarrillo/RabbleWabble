//
//  QuestionGroupBuilder.swift
//  RabbleWabble
//
//  Created by Armando Carrillo on 19/08/20.
//  Copyright © 2020 Armando Carrillo. All rights reserved.
//

public class QuestionGroupBuilder {
    public var questions = [QuestionBuilder()]
    public var title = ""
    
    
    public func addNewQuestion() {
        let question = QuestionBuilder()
        questions.append(question)
    }
    
    public func removeQuestion(at index: Int) {
        questions.remove(at: index)
    }
    //validates that title has been set and theres at least one questionBuilder
    public func build() throws -> QuestionGroup {
        guard self.title.count > 0 else {throw Error.missingTitle }
        guard self.questions.count > 0 else { throw Error.missingQuestions}
        
        let questions = try self.questions.map{ try $0.build() }
        return QuestionGroup(questions: questions, title: title)
    }
    
    public enum Error: String, Swift.Error {
        case missingTitle
        case missingQuestions
    }
    
}

public class QuestionBuilder {
    
    

    public var answer = ""
    public var hint = ""
    public var prompt = ""
    // it validates that answer and prompt have been set
    public func build() throws -> Question {
        guard answer.count > 0 else { throw Error.missingAnswer }
        guard prompt.count > 0 else { throw Error.missingPrompt }
        
        return Question(answer: answer, hint: hint, prompt: prompt)
    }
    public enum Error: String, Swift.Error {
        case missingAnswer
        case missingPrompt
    }
}
