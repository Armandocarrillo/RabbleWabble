//
//  AppSettings.swift
//  RabbleWabble
//
//  Created by Armando Carrillo on 19/08/20.
//  Copyright © 2020 Armando Carrillo. All rights reserved.
//

import Foundation
//Singleton

public class AppSettings {
    //MARK: - Keys
    private struct Keys {
        static let questionStrategy = "questionStrategy"// to give a named and the typed way of referencing such strings
    }
    
    //MARK: - Static Properties
    public static let shared = AppSettings()
    
    //MARK: - Object Lifecycle
    private init(){ }
    
    //MARK: - Instance Properties
    public var questionStrategyType: QuestionStrategyType{//to hold onto the user s desired strategy
        // Use get o set to get the integer value using userDefaults
        get {
            let rawValue = userDefaults.integer(forKey: Keys.questionStrategy)
            return QuestionStrategyType(rawValue: rawValue)!
        } set {
            userDefaults.set(newValue.rawValue, forKey: Keys.questionStrategy)
        }
    }
    private let userDefaults = UserDefaults.standard//singleton plus, to use to store key-value pairs that persist across app launches
    
    //MARK: - Instance Methods
    public func questionStrategy(for questionGroupCarataker: QuestionGroupCarataker) -> QuestionStrategy {
        return questionStrategyType.questionStrategy(for: questionGroupCarataker)
    } // this is a convenience method to get the QuestionStrategy from the selected questionStrategyType
}

    //MARK: - QuestionStrategyType
public enum QuestionStrategyType : Int, CaseIterable { //which has cases for every possible type of QuestionStrategy
    //CaseIterable get a free static property generated by the compiler
    case random
    case sequential
    
    //MARK: - Instance Methods
    public func title() -> String { //title represent the strategy
        switch self {
        case .random:
            return "Random"
        case .sequential:
            return "Sequential"
        
        }
    }
    
    public func questionStrategy(for questionGroupCarataker: QuestionGroupCarataker) -> QuestionStrategy { //to create a QuestionStrategy from the selected QuestionStrategyType
        switch self {
        case .random:
            return RandomQuestionStrategy(questionGroupCarataker: questionGroupCarataker)
        case .sequential:
            return SequentialQuestionStrategy(questionGroupCarataker: questionGroupCarataker)
        
        }
    }
}
