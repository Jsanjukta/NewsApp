//
//  ListTableViewCell.swift
//  News App
//
//  Created by Krishna on 25/09/19.
//  Copyright © 2019 Krishna. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var shadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shadowView.addShadow(cornerRadius: 6, opacity: 0.5, radius: 7, offset: (x: 0, y: 0), color: UIColor.lightGray)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
