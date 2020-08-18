//
//  ViewController.swift
//  RabbleWabble
//
//  Created by Armando Carrillo on 16/08/20.
//  Copyright © 2020 Armando Carrillo. All rights reserved.
//

import UIKit

public protocol QuestionViewControllerDelegate: class {
    func questionViewController(_ viewController: QuestionViewController, didCancel questionGroup: QuestionGroup, at questionIndex: Int)// when the user cancel button
    
    func questionViewController(_ viewController: QuestionViewController, didComplete questionGroup: QuestionGroup) // when the user completes all of the questions
    
}

public class QuestionViewController: UIViewController {
    
    //MARK : - Instance Properties
    public weak var delegate: QuestionViewControllerDelegate?
    
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
        delegate?.questionViewController(self, didCancel: questionGroup, at: questionIndex)
    }
    
    private func showQuestion() {
        let question = questionGroup.questions[questionIndex]
        
        questionView.answerLabel.text = question.answer
        questionView.promptLabel.text = question.prompt
        questionView.hintLabel.text = question.hint
        
        questionView.answerLabel.isHidden = false
        questionView.hintLabel.isHidden = false
        
        questionIndexItem.title = "\(questionIndex + 1) /" + "\(questionGroup.questions.count)" //show question number
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
            
            // TODO: - Handle this..
            delegate?.questionViewController(self, didComplete: questionGroup)// Exit when question are complet
            return
        }
        showQuestion()
    }
}

