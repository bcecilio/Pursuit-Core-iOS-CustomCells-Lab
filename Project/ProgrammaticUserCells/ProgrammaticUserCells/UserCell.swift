//
//  UserCell.swift
//  ProgrammaticUserCells
//
//  Created by Brendon Cecilio on 1/29/20.
//  Copyright © 2020 Benjamin Stone. All rights reserved.
//

import UIKit

class UserCell: UICollectionViewCell {
    
    @IBOutlet weak var profilImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addreeeLabel: UILabel!
    
    var userData: User?
    
    public func configureCell(for: User) {
        guard let user = userData else {
            return
        }
        profilImageView.image = UIImage(contentsOfFile: user.picture.medium)
        nameLabel.text = "\(user.name.first) \(user.name.last)"
        addreeeLabel.text = user.location.city
    }
}
