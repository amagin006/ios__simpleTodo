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
    struct TodoItem {
        var todo: String
        var deadline: String
        var priority: Int
        
        mutating func setTodo(todo: String, deadline: String, priority: Int) -> TodoItem {
            self.todo = todo
            self.deadline = deadline
            self.priority = priority
            return self
        }
    }
    
    let todo1 = TodoItem(todo: "run", deadline: "Dec 3 2019", priority: 1)
    let todo2 = TodoItem(todo: "read book", deadline: "Dec 3 2019", priority: 1)
    let todo3 = TodoItem(todo: "swim", deadline: "Dec 3 2019", priority: 1)
    let todo4 = TodoItem(todo: "study", deadline: "Dec 3 2019", priority: 1)
    let todo5 = TodoItem(todo: "push up", deadline: "Dec 3 2019", priority: 1)
    let todo6 = TodoItem(todo: "buy food", deadline: "Dec 3 2019", priority: 1)
    let todo7 = TodoItem(todo: "watch tv", deadline: "Dec 3 2019", priority: 2)
    let todo8 = TodoItem(todo: "give", deadline: "Dec 3 2019", priority: 2)
    let todo9 = TodoItem(todo:  "take", deadline: "Dec 3 2019", priority: 2)
    let todo10 = TodoItem(todo: "go", deadline: "Dec 3 2019", priority: 2)
    let todo11 = TodoItem(todo: "apple", deadline: "Dec 3 2019", priority: 3)
    let todo12 = TodoItem(todo: "amazon", deadline: "Dec 3 2019", priority: 3)
    let todo13 = TodoItem(todo: "google", deadline: "Dec 3 2019", priority: 3)
    
    lazy var todos = [[todo1, todo2, todo3, todo4, todo5, todo6], [todo7, todo8, todo9, todo10], [todo11, todo12, todo13]]
    let sectionName = ["High", "Middle", "Low"]
    
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
        cell.nameLabel.text = todos[indexPath.section][indexPath.row].todo
        cell.deallineLabel.text = todos[indexPath.section][indexPath.row].deadline
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
        
        let editDtailVC = EditDetailViewController()
        editDtailVC.delegate = self
        editDtailVC.selectIndexPath = indexPath
        editDtailVC.todoTextField.text = todos[indexPath.section][indexPath.row].todo
        editDtailVC.deadlineTextField.text = todos[indexPath.section][indexPath.row].deadline
        editDtailVC.priorityTextField.text = sectionName[indexPath.section]
        editDtailVC.priorityNum = indexPath.section
        navigationController?.pushViewController(editDtailVC, animated: true)
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
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension ViewController: AddTodoControllerDelegate {
    func AddTodoDidFinish(_ todo: String, date: String, priorityLevel: Int) {
        let newTodo = TodoItem(todo: todo, deadline: date, priority: priorityLevel)
        todos[priorityLevel].append(newTodo)
        tableView.reloadData()
    }
    
    func AddTodoCancel() {
        
    }
}

extension ViewController: EditDetailViewControllerDelegate {
    func EditTodoCancel() {
        
    }
    func EditTodoDidFinish(_ todo: String, date: String, priority: Int, indexPath: IndexPath) {
        let editTodo = todos[indexPath.section][indexPath.row].setTodo(todo: todo, deadline: date, priority: priority)
        if editTodo.priority != indexPath.section {
            todos[indexPath.section].remove(at: indexPath.row)
            todos[priority].append(editTodo)
        }
        tableView.reloadData()
    }
    
}
