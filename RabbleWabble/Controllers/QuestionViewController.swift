//
//  ViewController.swift
//  RabbleWabble
//
//  Created by Armando Carrillo on 16/08/20.
//  Copyright © 2020 Armando Carrillo. All rights reserved.
//

import UIKit

public protocol QuestionViewControllerDelegate: class {
    func questionViewController(_ viewController: QuestionViewController, didCancel questionGroup: QuestionStrategy)// when the user cancel button
    
    func questionViewController(_ viewController: QuestionViewController, didComplete questionStrategy: QuestionStrategy) // when the user completes all of the questions
    
    
}



public class QuestionViewController: UIViewController {
    
    
    //MARK : - Instance Properties
    public weak var delegate: QuestionViewControllerDelegate?
    
    public var questionStrategy: QuestionStrategy! {
        didSet {
           navigationItem.title = questionStrategy.title
        }
    }
    
    //public var questionGroup = QuestionGroup.basicPhrases()
    public var questionGroup : QuestionGroup! {// show the name of group
        didSet {
            navigationItem.title = questionGroup.title
        }
    }
    public var questionIndex = 0
    
    public var correctCount = 0
    public var incorrectCount = 0
    
    public var questionView : QuestionView! {
        guard isViewLoaded else { return nil }
        return (view as! QuestionView)
    }
    
    private lazy var questionIndexItem: UIBarButtonItem = { //shown in navigation Item
        let item = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        item.tintColor = .black
        navigationItem.rightBarButtonItem = item
        return item
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCancelButton()
        showQuestion()
    }
    
    private func setupCancelButton() { // this sets a new cancel button as the navigation item
        let action = #selector(handleCancelPressed(sender:))
        let image = UIImage(named: "ic_menu")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: action)
    }
    
    @objc private func handleCancelPressed(sender: UIBarButtonItem) {
        delegate?.questionViewController(self, didCancel: questionStrategy)
    }
    
    private func showQuestion() {
        //let question = questionGroup.questions[questionIndex]
        let question = questionStrategy.currentQuestion()// get currentQuestion
        
        questionView.answerLabel.text = question.answer
        questionView.promptLabel.text = question.prompt
        questionView.hintLabel.text = question.hint
        
        questionView.answerLabel.isHidden = true
        questionView.hintLabel.isHidden = true
        
        //questionIndexItem.title = "\(questionIndex + 1) /" + "\(questionGroup.questions.count)" //show question number
        questionIndexItem.title = questionStrategy.questionIndexTitle()
    }
    @IBAction func toggleAnswerLabels(_ sender: Any) {
        questionView.answerLabel.isHidden = !questionView.answerLabel.isHidden
        questionView.hintLabel.isHidden = !questionView.hintLabel.isHidden
    }
    
    @IBAction func handleCorrect(_ sender: Any) {
        /*correctCount += 1
        questionView.correctCountLabel.text = "\(correctCount)"
        showNextQuestion()*/
        let question = questionStrategy.currentQuestion()
        questionStrategy.markQuestionCorrect(question)
        
        questionView.correctCountLabel.text = String(questionStrategy.correctCount)
        showNextQuestion()
    }

    @IBAction func handleIncorrect(_ sender: Any){
       /* incorrectCount += 1
        questionView.incorrectCountLabel.text = "\(incorrectCount)"
        showNextQuestion()*/
        
        let question = questionStrategy.currentQuestion()
        questionStrategy.markQuestionIncorrect(question)
        
        questionView.incorrectCountLabel.text = String(questionStrategy.incorrectCount)
        showNextQuestion()
    }

    private func showNextQuestion(){
        /*questionIndex += 1
        guard questionIndex < questionGroup.questions.count else {
            
            // TODO: - Handle this..
            delegate?.questionViewController(self, didComplete: questionGroup)// Exit when question are complet*/
        
        guard questionStrategy.advanceToNextQuestion() else { delegate?.questionViewController(self, didComplete: questionStrategy)
            return
        }
        showQuestion()
    }
    
   
}

