//
//  UIView+Initializer.swift
//  simpleToDo
//
//  Created by Shota Iwamoto on 2019-05-04.
//  Copyright © 2019 Shota Iwamoto. All rights reserved.
//

import UIKit

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

extension UILabel {
    convenience init(title: String, color: UIColor, fontSize: CGFloat, bold: Bool = false) {
        self.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        text = title
        textColor = color
        if bold {
            font = UIFont.boldSystemFont(ofSize: fontSize)
        } else {
            font = UIFont(descriptor: .init(), size: fontSize)
        }
    }
}

extension UITextField {
    convenience init(width: CGFloat, height: CGFloat, fontSize: CGFloat = 16,
                     border: Bool = false, align: NSTextAlignment = .left,
                     placeHolder: String = "") {
        self.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        if border {
            layer.borderWidth = 1
            layer.cornerRadius = 5
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        textAlignment = align
        rightView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        rightViewMode = .always
        if placeHolder != "" {
            placeholder = placeHolder
        }
        font = UIFont(descriptor: .init(), size: fontSize)
    }
}
