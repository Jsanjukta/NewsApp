//
//  AppConstant.swift
//  News App
//
//  Created by Krishna on 25/09/19.
//  Copyright © 2019 Krishna. All rights reserved.
//

import Foundation
import UIKit

struct INITIATE {
    static func INITIATE_STORY_BOARD(identifier: String) -> Any {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
}

struct ENTITY {
    static let news           = "News"
}

struct CELL_ANIMATION {
    static func cellAnimating(cell : UITableViewCell) {
        cell.alpha = 0.5
        UIView.animate(withDuration: 0.5) {
            cell.alpha = 1
        }
    }
}

extension UIView{
    func addShadow(cornerRadius: CGFloat, opacity: Float, radius: CGFloat, offset: (x: CGFloat, y: CGFloat), color: UIColor){
        self.clipsToBounds = true
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: offset.x, height: offset.y)
        self.layer.shadowRadius = radius
    }
}
