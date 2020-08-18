//
//  SelectQuestionGroupViewController.swift
//  RabbleWabble
//
//  Created by Armando Carrillo on 17/08/20.
//  Copyright © 2020 Armando Carrillo. All rights reserved.
//

import UIKit

public class SelectQuestionGroupViewController: UIViewController{
    
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

