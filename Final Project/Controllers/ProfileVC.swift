//
//  ProfileVC.swift
//  Final Project
//
//  Created by Abdelrahman Nada on 26/04/2022.
//

import UIKit
import NVActivityIndicatorView

class ProfileVC: UIViewController {

    // MARK: - Outlets
    // MARK: - Profile Title
    @IBOutlet weak var loaderIndicatorView: NVActivityIndicatorView!
    @IBOutlet weak var profileImageViewOutlet: UIImageView! {
        didSet {
            profileImageViewOutlet.makeCircularImage()
        }
    }
    @IBOutlet weak var profileNameLabelOutlet: UILabel!
    // MARK: - Profile Data
    @IBOutlet weak var profileEmailLabelOutlet: UILabel!
    @IBOutlet weak var profilePhoneLabelOutlet: UILabel!
    @IBOutlet weak var profileCountryLabelOutlet: UILabel!
    @IBOutlet weak var profileGenderLabelOutlet: UILabel!
    
    // MARK: - Var
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        navigationController?.navigationBar.isHidden = false
        
        userData()
        
        loaderIndicatorView.startAnimating()
        
        UserAPI.getUserData(id: user.id) {userResponse in
            
            self.user = userResponse
            self.userData()
            self.loaderIndicatorView.stopAnimating()
        }
 
    }

    func userData() {
        
        if let image = user.picture {
            profileImageViewOutlet.setImageFromStringURL(stringURL: image)
        }
        profileNameLabelOutlet.text = user.firstName + " " + user.lastName
        profileEmailLabelOutlet.text = user.email
        profilePhoneLabelOutlet.text = user.phone
       
         if let location = user.location {
         
            profileCountryLabelOutlet.text = location.city! + " " + location.country!
        }
        profileGenderLabelOutlet.text = user.gender
    }
}
