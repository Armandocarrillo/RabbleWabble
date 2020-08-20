//
//  SelectQuestionGroupViewController.swift
//  RabbleWabble
//
//  Created by Armando Carrillo on 17/08/20.
//  Copyright © 2020 Armando Carrillo. All rights reserved.
//

import UIKit

public class SelectQuestionGroupViewController: UIViewController, QuestionViewControllerDelegate{
     //MARK: -QuestionViewControllerDelegate
    public func questionViewController(_ viewController: QuestionViewController, didCancel questionGroup: QuestionGroup, at questionIndex: Int) {
        navigationController?.popToViewController(self, animated: true)
    }
    
    public func questionViewController(_ viewController: QuestionViewController, didComplete questionGroup: QuestionGroup) {
        navigationController?.popToViewController(self, animated: true)
    }
    //
    @IBOutlet internal var tableView: UITableView! {
        didSet {
            tableView.tableFooterView = UIView() //Prevent the table view from drawing unnecessary empty table view cells
        }
    }
    
    //public let questionGroups = QuestionGroup.allGroups() //returns all of the possible questionGroup options
    private let questionGroupCarataker = QuestionGroupCarataker()
    private var questionGroups : [QuestionGroup]{
        return questionGroupCarataker.questionGroups
    }
    
    //private var selectedQuestionGroup : QuestionGroup! //to hold onto whichever questionGroup the user selects
    
    private var selectedQuestionGroup: QuestionGroup! {
        get {
            return questionGroupCarataker.selectedQuestionGroup
        } set {
            questionGroupCarataker.selectedQuestionGroup = newValue
        }
    }
    
    private let appSettings = AppSettings.shared
    
    //MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        questionGroups.forEach{
            print("\($0.title): " + "correctCount \($0.score.correctCount)," + "incorrectCount \($0.score.incorrectCount)"
            )
        }
        
        
    }
    
}
extension SelectQuestionGroupViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionGroups.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //return UITableViewCell() // return an empty UITableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionGroupCell") as! QuestionGroupCell
        let questionGroup = questionGroups[indexPath.row]
        cell.titleLabel.text = questionGroup.title
        //register cell as an observer of runningPercentage
        questionGroup.score.runningPercentage.addObserver(cell, options: [.initial, .new]) {
            //To ensure you dont create a retain cycle
            [weak cell] (percentage, _) in
            //good practice
            DispatchQueue.main.async {
                cell?.percentageLabel.text = String(format: "%.0f %%", round(100 * percentage))// formating the percentage®
            }
        }
        return cell
    }
    
   
    }

extension SelectQuestionGroupViewController: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedQuestionGroup = questionGroups[indexPath.row]
        return indexPath
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    
    
    }
    
    public func questionViewController(_ viewController: QuestionViewController, didCancel questionGroup: QuestionStrategy) {
        navigationController?.popToViewController(self, animated: true)
    }
    
    public func questionViewController(_ viewController: QuestionViewController, didComplete questionGroup: QuestionStrategy) {
        navigationController?.popToViewController(self, animated: true)
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //guard let viewController = segue.destination as? QuestionViewController else { return }
        //viewController.questionGroup = selectedQuestionGroup
        //viewController.questionStrategy = RandomQuestionStrategy(questionGroup: selectedQuestionGroup)
        //viewController.questionStrategy = SequentialQuestionStrategy(questionGroup: selectedQuestionGroup)
        //check if the segue is in QuestionViewController
        if let viewController = segue.destination as? QuestionViewController {
            viewController.questionStrategy = appSettings.questionStrategy(for: questionGroupCarataker)
            viewController.delegate = self
            //check if the segue is in CreateQuestionGroupViewController
        } else if let navController = segue.destination as? UINavigationController,
            let viewController = navController.topViewController as? CreateQuestionGroupViewController {
            viewController.delegate = self
            
        }
        /*
        viewController.questionStrategy = appSettings.questionStrategy(for: questionGroupCarataker)
        viewController.delegate = self*/
    }
    
    
}

//MARK: - CreateQuestionGroupViewControllerDelegate

extension SelectQuestionGroupViewController: CreateQuestionGroupViewControllerDelegate {
    //Didcancel is called whenever the cancel button is pressed
    public func createQuestionGroupViewControllerDidCancel(_ viewController: CreateQuestionGroupViewController) {
        dismiss(animated: true, completion: nil)
    }
    //create is called whenever a new QuestionGroup is created
    public func createQuestionGroupViewController(_ viewController: CreateQuestionGroupViewController, created questionGroup: QuestionGroup) {
        questionGroupCarataker.questionGroups.append(questionGroup)
        try? questionGroupCarataker.save()
        
        dismiss(animated: true, completion: nil)
        tableView.reloadData()
    }
}



   




