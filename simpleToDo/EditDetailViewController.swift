//
//  EditDetailViewController.swift
//  simpleToDo
//
//  Created by Shota Iwamoto on 2019-05-04.
//  Copyright © 2019 Shota Iwamoto. All rights reserved.
//

import UIKit

protocol EditDetailViewControllerDelegate: class {
    func EditTodoDidFinish(_ todo: String, date: String, priority: Int, indexPath: IndexPath)
    func EditTodoCancel()
}

class EditDetailViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    weak var delegate: EditDetailViewControllerDelegate?
    let prioritySelect = ["High", "Middle", "Low"]
    var priorityNum = 0
    var selectIndexPath = IndexPath.init()
    
    let descriptionLabel = UILabel(title: "What do you have to do", color: .black, fontSize: 20, bold: true)
    let todoTextField = UITextField(width: 0, height: 0, fontSize: 30, placeHolder: "Enter your TODO")
    let deadlineTextField = UITextField(width: 160, height: 40, border: true, align: .right)
    let deadlineLabel = UILabel(title: "Set due date", color: .black, fontSize: 16, bold: false)
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
    
    let priorityLabel = UILabel(title: "Set Priority", color: .black, fontSize: 16, bold: false)
    let priorityTextField = UITextField(width: 160, height: 40, border: true, align: .right)
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
        view.backgroundColor = #colorLiteral(red: 0.9395442034, green: 0.7203364789, blue: 0.8146132371, alpha: 1)
        todoTextField.delegate = self
        priorityPicker.delegate = self
        
        setupUI()
        
        navigationItem.title = "Edit TODO"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editDone))
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
    
    @objc func editDone() {
        if let todo = todoTextField.text {
            delegate?.EditTodoDidFinish(todo, date: deadlineTextField.text ?? "", priority: priorityNum, indexPath: selectIndexPath)
            navigationController?.popViewController(animated: true)
        }
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
        priorityNum = row
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
