//
//  Question.swift
//  RabbleWabble
//
//  Created by Armando Carrillo on 17/08/20.
//  Copyright © 2020 Armando Carrillo. All rights reserved.
//

import Foundation

public class Question: Codable {
    public let answer : String
    public let hint : String?
    public let prompt : String
    
    public init (answer: String, hint: String?, prompt: String) {
        self.answer = answer
        self.hint = hint
        self.prompt = prompt
        
    }
}
