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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
