//
//  AddTodoViewController.swift
//  simpleToDo
//
//  Created by Shota Iwamoto on 2019-05-02.
//  Copyright © 2019 Shota Iwamoto. All rights reserved.
//

import UIKit

protocol AddTodoControllerDelegate: class {
    func AddTodoCancel()
    func AddTodoDidFinish(_ todo: String)
}

class AddTodoViewController: UIViewController {
    
    weak var delegate: AddTodoControllerDelegate?
    

    let descriptionLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = true
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        lb.text = "What do you have to do"
        lb.textColor = .black
        return lb
    }()
    
    let todoTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = true
        tf.placeholder = "Enter your TODO"
        return tf
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        
        navigationItem.title = "ADD TODO"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didAddTodo))
        
    }
    
    
    @objc func didAddTodo() {
        if let todo = todoTextField.text {
            delegate?.AddTodoDidFinish(todo)
            navigationController?.popViewController(animated: true)
        }
    }

    fileprivate func setupUI(){
        let stackView = UIStackView(arrangedSubviews: [descriptionLabel, todoTextField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 30
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
}
