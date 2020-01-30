//
//  DetailViewController.swift
//  ProgrammaticUserCells
//
//  Created by Brendon Cecilio on 1/29/20.
//  Copyright © 2020 Benjamin Stone. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userAddressLabel: UILabel!
    @IBOutlet weak var userPWLabel: UILabel!
    
    var detailUserInfo: User?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI() {
        guard let user = detailUserInfo else {
            return
        }
        backgroundView.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        userNameLabel.text = "\(user.name.first) \(user.name.last)"
        userAddressLabel.text = "\(user.location.city), \(user.location.state)"
        userPWLabel.text = user.email
        
        ImageCLient.getImage(urlString: user.picture.large) { [weak self] (result) in
            switch result {
            case .failure(_):
                self?.userImageView.image = UIImage(systemName: "person.fill")
            case .success(let image):
                self?.userImageView.image = image
            }
        }
    }
}
