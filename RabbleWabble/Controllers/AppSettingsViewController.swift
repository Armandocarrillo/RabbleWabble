//
//  AppSettingsViewController.swift
//  RabbleWabble
//
//  Created by Armando Carrillo on 19/08/20.
//  Copyright © 2020 Armando Carrillo. All rights reserved.
//

import UIKit

public class AppSettingsViewController: UITableViewController {
    //MARK: - Properties
    public let appSettings = AppSettings.shared //to use to get and set the questionStrategyType
    
    private let cellIdentifier = "basicCell"
    
    //MARK: - View Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView() // dont have extra blank cells at the bottom
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier) //to ensure getting back a uitableViewCell intance
        }
    }
// MARK: - UITableViewDataSource

extension AppSettingsViewController {
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QuestionStrategyType.allCases.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        let questionStrategyType = QuestionStrategyType.allCases[indexPath.row]
        
        cell.textLabel?.text = questionStrategyType.title()
        
        if appSettings.questionStrategyType == questionStrategyType {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
}

//MARK: - UITableViewDelegate

extension AppSettingsViewController {
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let questionStrategyType = QuestionStrategyType.allCases[indexPath.row]
        appSettings.questionStrategyType = questionStrategyType
        tableView.reloadData()
    }
}

