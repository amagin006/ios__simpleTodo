//
//  NameCell.swift
//  simpleToDo
//
//  Created by Shota Iwamoto on 2019-05-01.
//  Copyright © 2019 Shota Iwamoto. All rights reserved.
//

import UIKit

class NameCell: UITableViewCell {

    let nameLabel: UILabel = {
       let lb = UILabel(frame: .zero)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let deallineLabel = UILabel(title: "May 12 2019", color: .black, fontSize: 16)
    let dueLabel = UILabel(title: "Due Date", color: #colorLiteral(red: 1, green: 0.4749273103, blue: 0, alpha: 1), fontSize: 8)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        let stackView: UIStackView = {
            let sv = UIStackView(arrangedSubviews: [nameLabel, dueLabel, deallineLabel])
            sv.axis = .horizontal
            sv.spacing = 15
            sv.translatesAutoresizingMaskIntoConstraints = false
            return sv
        }()
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor),
            stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
