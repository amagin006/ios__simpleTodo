//
//  ViewController.swift
//  simpleToDo
//
//  Created by Shota Iwamoto on 2019-05-01.
//  Copyright © 2019 Shota Iwamoto. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UITableViewController {    
    private let cellId = "cell"
    
//    let todo1 = TodoItem(todo: "run", deadline: "Dec 3 2019", priority: 1)
//    let todo2 = TodoItem(todo: "read book", deadline: "Dec 3 2019", priority: 1)
//    let todo3 = TodoItem(todo: "swim", deadline: "Dec 3 2019", priority: 1)
//    let todo4 = TodoItem(todo: "study", deadline: "Dec 3 2019", priority: 1)
//    let todo5 = TodoItem(todo: "push up", deadline: "Dec 3 2019", priority: 1)
//    let todo6 = TodoItem(todo: "buy food", deadline: "Dec 3 2019", priority: 1)
//    let todo7 = TodoItem(todo: "watch tv", deadline: "Dec 3 2019", priority: 2)
//    let todo8 = TodoItem(todo: "give", deadline: "Dec 3 2019", priority: 2)
//    let todo9 = TodoItem(todo:  "take", deadline: "Dec 3 2019", priority: 2)
//    let todo10 = TodoItem(todo: "go", deadline: "Dec 3 2019", priority: 2)
//    let todo11 = TodoItem(todo: "apple", deadline: "Dec 3 2019", priority: 3)
//    let todo12 = TodoItem(todo: "amazon", deadline: "Dec 3 2019", priority: 3)
//    let todo13 = TodoItem(todo: "google", deadline: "Dec 3 2019", priority: 3)
//
//    lazy var todos = [[todo1, todo2, todo3, todo4, todo5, todo6], [todo7, todo8, todo9, todo10], [todo11, todo12, todo13]]
    
    var todoTasksArr:[[TodoTask]] = [[], [], []]
    let sectionName = ["High", "Middle", "Low"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(NameCell.self, forCellReuseIdentifier: cellId)
        self.title = "Todo List"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItem = editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTodo))
        tableView.allowsSelectionDuringEditing = true
        
        fetchTodo()
    }
    
    private func fetchTodo() {
        let manageContext = CoreDataManager.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<TodoTask>(entityName: "TodoTask")
        do {
            let fetchTodoTasks = try manageContext.fetch(fetchRequest)
            
            self.todoTasksArr[0] = fetchTodoTasks.filter({$0.priority == 0})
            self.todoTasksArr[1] = fetchTodoTasks.filter({$0.priority == 1})
            self.todoTasksArr[2] = fetchTodoTasks.filter({$0.priority == 2})
            self.tableView.reloadData()
            
        } catch let err {
            print("Failed to fetch todoTasks: \(err)")
        }
        
        
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoTasksArr[section].count
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionName.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let header = UILabel()
        header.text = sectionName[section]
        header.font = UIFont(descriptor: .init(), size: 22)
        if section == 0 {
            headerView.backgroundColor = #colorLiteral(red: 1, green: 0.6755259189, blue: 0.07688719753, alpha: 1)
        } else if section == 1 {
            headerView.backgroundColor = #colorLiteral(red: 0.4398253267, green: 1, blue: 0.6652365285, alpha: 1)
        } else if section == 2 {
            headerView.backgroundColor = #colorLiteral(red: 0.4579046029, green: 0.6709440624, blue: 1, alpha: 1)
        }
        headerView.addSubview(header)
        header.translatesAutoresizingMaskIntoConstraints = false
        header.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: 20).isActive = true
        header.widthAnchor.constraint(equalTo: headerView.widthAnchor).isActive = true
        header.heightAnchor.constraint(equalTo: headerView.heightAnchor).isActive = true
        header.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true

        return headerView
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! NameCell
        
        let todoTask = todoTasksArr[indexPath.section][indexPath.row]
        
        if let todo = todoTask.todo, let deadline = todoTask.deadline {
            cell.nameLabel.text = todo
            cell.deallineLabel.text = deadline
        }
        
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
        
        let editDetailVC = AddTodoViewController()
        editDetailVC.delegate = self
        editDetailVC.todoTask = self.todoTasksArr[indexPath.section][indexPath.row]
        navigationController?.pushViewController(editDetailVC, animated: true)
//
//        let editDtailVC = EditDetailViewController()
//        editDtailVC.delegate = self
//        editDtailVC.selectIndexPath = indexPath
//        editDtailVC.todoTextField.text = todos[indexPath.section][indexPath.row].todo
//        editDtailVC.deadlineTextField.text = todos[indexPath.section][indexPath.row].deadline
//        editDtailVC.priorityTextField.text = sectionName[indexPath.section]
//        editDtailVC.priorityNum = indexPath.section
//        navigationController?.pushViewController(editDtailVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .insert:
            print(".insert")
        case .delete:
//            todos[indexPath.section].remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
            print(".delete")
        case .none:
            print(".none")
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    
        if sourceIndexPath.section == destinationIndexPath.section {
            if sourceIndexPath.row < destinationIndexPath.row {
            todoTasksArr[destinationIndexPath.section].insert(todoTasksArr[sourceIndexPath.section][sourceIndexPath.row], at: destinationIndexPath.row + 1)
                todoTasksArr[sourceIndexPath.section].remove(at: sourceIndexPath.row)
                print("----\(todoTasksArr)")
            } else {
                todoTasksArr[destinationIndexPath.section].insert(todoTasksArr[sourceIndexPath.section][sourceIndexPath.row], at: destinationIndexPath.row)
                todoTasksArr[sourceIndexPath.section].remove(at: sourceIndexPath.row + 1)
                print("++++++\(todoTasksArr)")
            }
        } else {
            todoTasksArr[destinationIndexPath.section].insert(todoTasksArr[sourceIndexPath.section][sourceIndexPath.row], at: destinationIndexPath.row)
            todoTasksArr[sourceIndexPath.section].remove(at: sourceIndexPath.row)
            print("====\(todoTasksArr)")
        }
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension ViewController: AddTodoControllerDelegate {
    func AddTodoDidFinish(todoTask: TodoTask) {
        todoTasksArr[Int(todoTask.priority)].append(todoTask)
        let insertPath = IndexPath(row: todoTasksArr[Int(todoTask.priority)].count - 1, section: Int(todoTask.priority))
        tableView.insertRows(at: [insertPath], with: .automatic)
    }
    
    func EditTodoDidFinish(editTask: TodoTask, section: Int) {
        if Int(editTask.priority) == section {
            let row = todoTasksArr[Int(editTask.priority)].firstIndex(of: editTask)!
            tableView.reloadRows(at: [IndexPath(row: row, section: Int(editTask.priority))], with: .middle)
        } else {
            let row = todoTasksArr[section].firstIndex(of: editTask)!
            todoTasksArr[section].remove(at: row)
            tableView.deleteRows(at: [IndexPath(row: row, section: section)], with: .automatic)
            
            todoTasksArr[Int(editTask.priority)].append(editTask)
            let indexpath = IndexPath(row: todoTasksArr[Int(editTask.priority)].count - 1, section: Int(editTask.priority))
            tableView.insertRows(at: [indexpath], with: .middle)
        }
        
        
    }
    
}

