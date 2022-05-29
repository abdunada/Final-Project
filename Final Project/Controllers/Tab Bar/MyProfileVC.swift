//
//  MyProfileVC.swift
//  Final Project
//
//  Created by Abdelrahman Nada on 28/05/2022.
//

import UIKit
import NVActivityIndicatorView

class MyProfileVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var headerViewOutlet: UIView!
    @IBOutlet weak var pageTitleLabelOutlet: UILabel!
    @IBOutlet weak var userImageViewOutlet: UIImageView!
    @IBOutlet weak var detailsContainerView: UIView!
    @IBOutlet weak var userNameLabelOulet: UILabel!
    @IBOutlet weak var emailLabelOutlet: UILabel!
    @IBOutlet weak var emailTextFieldOutlet: UITextField!
    @IBOutlet weak var phoneTextFieldOutlet: UITextField!
    @IBOutlet weak var phoneLabelOutlet: UILabel!
    @IBOutlet weak var imageUrlLabelOulet: UILabel!
    @IBOutlet weak var imageUrlTextFieldOutlet: UITextField!
    @IBOutlet weak var sumbmitButtonOutlet: UIButton!
    @IBOutlet weak var activityLoaderIndicatorOutlet: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
       
    }
    
    // MARK: - Action
    @IBAction func submitButtonPressed(_ sender: Any) {
     
        guard let loggedInUser = UserManager.loggedInUser else {return}
        
        activityLoaderIndicatorOutlet.startAnimating()
        
        UserAPI.updateUserInfo(firstName: emailTextFieldOutlet.text!, userId: loggedInUser.id, phone: phoneTextFieldOutlet.text!, imageUrl: imageUrlTextFieldOutlet.text!) { user, errorMessage in
            
            self.activityLoaderIndicatorOutlet.stopAnimating()
            if let responseUser = user {
                
                if let image = user?.picture {
                    
                    self.userImageViewOutlet.setImageFromStringURL(stringURL: image)
                }
            }
        }
        
    }
    
    // MARK: - Functions
    // MARK: - SetupUI
    func setupUI() {
        
        headerViewOutlet.layer.cornerRadius = 25
        userImageViewOutlet.makeCircularImage()
        detailsContainerView.layer.cornerRadius = 25
        sumbmitButtonOutlet.layer.cornerRadius = 25
        
        if let user = UserManager.loggedInUser {
            
            if let image = user.picture {
                userImageViewOutlet.setImageFromStringURL(stringURL: image)
            }
            
            userNameLabelOulet.text = user.firstName + " " + user.lastName
            emailTextFieldOutlet.text = user.firstName + " " + user.lastName
            phoneTextFieldOutlet.text = user.phone
            imageUrlTextFieldOutlet.text = user.picture
        }
    }

}
