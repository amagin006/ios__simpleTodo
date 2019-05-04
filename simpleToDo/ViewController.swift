//
//  ViewController.swift
//  simpleToDo
//
//  Created by Shota Iwamoto on 2019-05-01.
//  Copyright © 2019 Shota Iwamoto. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {    
    private let cellId = "cell"
    
//    var todos = [String]()
    var todos = [["run", "read book", "swim", "study", "push up", "buy food", "watch tv"],
                 ["give", "have", "take", "go"],
                 ["apple", "amazon", "google"]]
    let sectionName = ["High", "Middle", "Low"]
 
    var sections = [Dictionary<String, [String]>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(NameCell.self, forCellReuseIdentifier: cellId)
        
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodo))
        tableView.allowsSelectionDuringEditing = true
    }
    

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos[section].count
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionName.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionName[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! NameCell
        cell.nameLabel.text = todos[indexPath.section][indexPath.row]
        return cell
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    @objc func addTodo() {
        let addTodoVC = AddTodoViewController()
        addTodoVC.delegate = self
        navigationController?.pushViewController(addTodoVC, animated: true)
    }
}


extension ViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select cell")
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .insert:
            print(".insert")
        case .delete:
            todos[indexPath.section].remove(at: indexPath.row)
            print(todos)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        case .none:
            print(".none")
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
//        let temp =
        if sourceIndexPath.section == destinationIndexPath.section {
            if sourceIndexPath.row < destinationIndexPath.row {
                todos[destinationIndexPath.section].insert(todos[sourceIndexPath.section][sourceIndexPath.row], at: destinationIndexPath.row + 1)
                todos[sourceIndexPath.section].remove(at: sourceIndexPath.row)
            } else {
                todos[destinationIndexPath.section].insert(todos[sourceIndexPath.section][sourceIndexPath.row], at: destinationIndexPath.row)
                todos[sourceIndexPath.section].remove(at: sourceIndexPath.row + 1)
            }
        } else {
            todos[destinationIndexPath.section].insert(todos[sourceIndexPath.section][sourceIndexPath.row], at: destinationIndexPath.row)
            todos[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        }
        print(todos)
        
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
}



extension ViewController: AddTodoControllerDelegate {
    func AddTodoDidFinish(_ todo: String, date: String, priorityLevel: String) {
        print(priorityLevel)
        var priorityInt = 0
        if priorityLevel == "High" {
            priorityInt = 0
        } else if priorityLevel == "Middle" {
            priorityInt = 1
        } else if priorityLevel == "Low" {
            priorityInt = 2
        }
        todos[priorityInt].append(todo)
        tableView.reloadData()
    }
    
    func AddTodoCancel() {
        
    }
}
