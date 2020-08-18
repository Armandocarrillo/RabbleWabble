//
//  ViewController.swift
//  RabbleWabble
//
//  Created by Armando Carrillo on 16/08/20.
//  Copyright © 2020 Armando Carrillo. All rights reserved.
//

import UIKit

public class QuestionViewController: UIViewController {

    public var questionGroup = QuestionGroup.basicPhrases()
    public var questionIndex = 0
    
    public var correctCount = 0
    public var incorrectCount = 0
    
    public var questionView : QuestionView! {
        guard isViewLoaded else { return nil }
        return (view as! QuestionView)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        showQuestion()
    }
    
    private func showQuestion() {
        let question = questionGroup.questions[questionIndex]
        
        questionView.answerLabel.text = question.answer
        questionView.promptLabel.text = question.prompt
        questionView.hintLabel.text = question.hint
        
        questionView.answerLabel.isHidden = false
        questionView.hintLabel.isHidden = false
    }
    @IBAction func toggleAnswerLabels(_ sender: Any) {
        questionView.answerLabel.isHidden = !questionView.answerLabel.isHidden
        questionView.hintLabel.isHidden = !questionView.hintLabel.isHidden
    }
    
    @IBAction func handleCorrect(_ sender: Any) {
        correctCount += 1
        questionView.correctCountLabel.text = "\(correctCount)"
        showNextQuestion()
    }

    @IBAction func handleIncorrect(_ sender: Any){
        incorrectCount += 1
        questionView.incorrectCountLabel.text = "\(incorrectCount)"
        showNextQuestion()
    }

    private func showNextQuestion(){
        questionIndex += 1
        guard questionIndex < questionGroup.questions.count else {
            return
        }
        showQuestion()
    }
}

