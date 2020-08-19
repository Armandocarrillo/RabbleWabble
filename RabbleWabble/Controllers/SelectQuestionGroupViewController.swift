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
    
    public let questionGroups = QuestionGroup.allGroups() //returns all of the possible questionGroup options
    private var selectedQuestionGroup : QuestionGroup! //to hold onto whichever questionGroup the user selects
    
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
        guard let viewController = segue.destination as? QuestionViewController else { return }
        //viewController.questionGroup = selectedQuestionGroup
        //viewController.questionStrategy = RandomQuestionStrategy(questionGroup: selectedQuestionGroup)
        viewController.questionStrategy = SequentialQuestionStrategy(questionGroup: selectedQuestionGroup)
        viewController.delegate = self
    }
    
    
}



   




