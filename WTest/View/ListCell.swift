//
//  ListCell.swift
//  WTest
//
//  Created by Mário Rodrigues on 13/10/2018.
//  Copyright © 2018 Mário Rodrigues. All rights reserved.
//

import UIKit

class ListCell: UITableViewCell {
    
    let postalCodeLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Answer"
        
        return label
    }()

    // MARK: - Initialization
    /*********************************************/
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        addSubview(postalCodeLabel)
        
        postalCodeLabel.anchor(top: self.topAnchor, bottom: self.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, topConstant: 8, bottomConstant: 8, leadingConstant: 8)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
