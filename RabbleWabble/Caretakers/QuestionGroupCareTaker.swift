//
//  QuestionGroupCareTaker.swift
//  RabbleWabble
//
//  Created by Armando Carrillo on 19/08/20.
//  Copyright © 2020 Armando Carrillo. All rights reserved.
//

import Foundation

public final class QuestionGroupCarataker {
    //MARK: - Properies
    
    private let fileName = "QuestionGroupData"// to indicate the file that need to save
    public var questionGroups: [QuestionGroup] = []
    public var selectedQuestionGroup: QuestionGroup!
    
    //MARK: - Object Lifecycle
    public init (){
        loadQuestionGroups()
    }
    
    private func loadQuestionGroups(){
        if let questionGroups = try? DiskCaretaker.retrive([QuestionGroup].self, from: fileName){
            self.questionGroups = questionGroups
        } else { // case to fail
            let bundle = Bundle.main
            let url = bundle.url(forResource: fileName, withExtension: "json")!
            self.questionGroups = try!
                DiskCaretaker.retrive([QuestionGroup].self, from: url)
            try! save()
        }
    }
    
    //MARK: - Instance Methods
    
    public func save() throws {
        try DiskCaretaker.save(questionGroups, to: fileName)
    }
}
