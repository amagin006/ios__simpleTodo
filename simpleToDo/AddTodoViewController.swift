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
    func AddTodoDidFinish(_ todo: String, date: String, priorityLevel: String)
}

class AddTodoViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    weak var delegate: AddTodoControllerDelegate?

    let descriptionLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.font = UIFont.boldSystemFont(ofSize: 20)
        lb.text = "What do you have to do"
        lb.textColor = .black
        return lb
    }()
    
    let todoTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Enter your TODO"
        return tf
    }()
    
    let deadlineTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 5
        tf.textAlignment = .right
        tf.heightAnchor.constraint(equalToConstant: 40).isActive = true
        tf.widthAnchor.constraint(equalToConstant: 160).isActive = true
        tf.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        tf.rightViewMode = .always
        return tf
    }()
    
    let deadlineLabel: UILabel = {
        let lb = UILabel()
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.text = "Set due date"
        return lb
    }()
    
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.translatesAutoresizingMaskIntoConstraints = false
        dp.datePickerMode = .date
        return dp
    }()
    
    let toolbar: UIToolbar = {
        let tb = UIToolbar()
        tb.isTranslucent = true
        tb.sizeToFit()
        return tb
    }()
    
    let priorityLabel: UILabel = {
       let pl = UILabel()
        pl.translatesAutoresizingMaskIntoConstraints = false
        pl.text = "Set Priority"
        return pl
    }()
    
    let priorityTextField: UITextField = {
        let tf = UITextField(frame: .zero)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.layer.borderWidth = 1
        tf.layer.cornerRadius = 5
        tf.textAlignment = .right
        tf.heightAnchor.constraint(equalToConstant: 40).isActive = true
        tf.widthAnchor.constraint(equalToConstant: 160).isActive = true
        tf.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        tf.rightViewMode = .always
        return tf
    }()
    
    let prioritySelect = ["High", "Middle", "Low"]

    let priorityPicker: UIPickerView = {
        let pp = UIPickerView()
        pp.translatesAutoresizingMaskIntoConstraints = false
        
        return pp
    }()
    
    let priorityToolbar: UIToolbar = {
        let tb = UIToolbar()
        tb.isTranslucent = true
        tb.sizeToFit()
        return tb
    }()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        todoTextField.delegate = self
        priorityPicker.delegate = self
        
        setupUI()
        
        navigationItem.title = "ADD TODO"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didAddTodo))
    }
    
    
    @objc func didAddTodo() {
        if let todo = todoTextField.text {
            delegate?.AddTodoDidFinish(todo, date: deadlineTextField.text ?? "", priorityLevel: priorityTextField.text ?? "High")
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc func doneClickToolbar() {
        let dateFomatter = DateFormatter()
        dateFomatter.dateStyle = .medium
        dateFomatter.timeStyle = .none
        deadlineTextField.text = dateFomatter.string(from: datePicker.date)
        deadlineTextField.resignFirstResponder()
    }
    
    @objc func cancelClickToolbar() {
        deadlineTextField.resignFirstResponder()
        priorityTextField.resignFirstResponder()
    }
    
    @objc func doneClickPriority() {
        if priorityTextField.text == "" {
            priorityTextField.text = prioritySelect[0]
        }
        priorityTextField.resignFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        todoTextField.resignFirstResponder()
        priorityTextField.resignFirstResponder()
        return true
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return prioritySelect[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        priorityTextField.text = prioritySelect[row]
    }
    
    fileprivate func setupUI(){
        
        setDatepicker()
        setPriorityPicker()
        
        let deadlineSV = UIStackView(arrangedSubviews: [deadlineLabel, deadlineTextField])
        deadlineSV.translatesAutoresizingMaskIntoConstraints = false
        deadlineSV.axis = .horizontal
        deadlineSV.spacing = 10
       
        let prioritySV = UIStackView(arrangedSubviews: [priorityLabel, priorityTextField])
        prioritySV.axis = .horizontal
        prioritySV.translatesAutoresizingMaskIntoConstraints = false
        prioritySV.spacing = 10
        
        let stackView = UIStackView(arrangedSubviews: [descriptionLabel, deadlineSV, prioritySV, todoTextField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 30
        view.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
    }
    
    fileprivate func setDatepicker() {
        let doneButtonToolbar = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneClickToolbar))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButtonToolbar = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelClickToolbar))
        
        toolbar.setItems([cancelButtonToolbar, spaceButton, doneButtonToolbar], animated: true)
        toolbar.isUserInteractionEnabled = true
        deadlineTextField.inputView = datePicker
        deadlineTextField.inputAccessoryView = toolbar
        
    }
    
    fileprivate func setPriorityPicker() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneClickPriority))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButtonToolbar = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelClickToolbar))
        priorityToolbar.setItems([cancelButtonToolbar, spaceButton, doneButton], animated: true)
        priorityToolbar.isUserInteractionEnabled = true
        priorityTextField.inputView = priorityPicker
        priorityTextField.inputAccessoryView = priorityToolbar
    }
}
