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
        public var correctCount: Int = 0{
            didSet {
              updateRunningPercentage()
            }
        }
        public var incorrectCount: Int = 0{
            didSet {
                updateRunningPercentage()
            }
        }
        
        private func updateRunningPercentage(){
            runningPercentage.value = calculateRunningPercentage()
        }
        public init () { }
        
        public lazy var runningPercentage = Observable(calculateRunningPercentage())
        
        private func calculateRunningPercentage() -> Double { //allow the users latest running Percentage score to be observed
            let totalCount = correctCount + incorrectCount
            guard  totalCount > 0 else {
                return 0
            }
            return Double(correctCount) / Double(totalCount)
        }
        
        public func reset() { //Resets score
            correctCount = 0
            incorrectCount = 0
        }
    }
    
    public let questions : [Question]
    public private(set) var score: Score //Prevent all outside classes from settings score, this ensure any runningPercentage obvservers arent accidentally wiped out
    public let title : String
 
    public init (questions: [Question],
                 score: Score = Score(),//to get blank score object
                 title: String) {
        self.questions = questions
        self.score = score
        self.title = title
    }
    
}


