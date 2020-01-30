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
    
    public func configureCell(for user: User) {
      
        profilImageView.image = UIImage(contentsOfFile: user.picture.medium)
        nameLabel.text = "\(user.name.first) \(user.name.last)"
        addreeeLabel.text = user.location.city
        
        ImageCLient.getImage(urlString: user.picture.large) { [weak self] (result) in
            switch result {
            case .failure(_):
                self?.profilImageView.image = UIImage(systemName: "person.fill")
            case .success(let image):
                self?.profilImageView.image = image
            }
        }
    }
}
