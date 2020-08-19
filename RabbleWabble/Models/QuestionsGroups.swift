//
//  QuestionsGroups.swift
//  RabbleWabble
//
//  Created by Armando Carrillo on 17/08/20.
//  Copyright © 2020 Armando Carrillo. All rights reserved.
//

import Foundation

public class QuestionGroup: Codable {
    
    public class Score: Codable {
        public var correctCount: Int = 0
        public var incorrectCount: Int = 0
        public init () { }
    }
    
    public let questions : [Question]
    public var score: Score
    public let title : String
 
    public init (questions: [Question],
                 score: Score = Score(),//to get blank score object
                 title: String) {
        self.questions = questions
        self.score = score
        self.title = title
    }
    
}


