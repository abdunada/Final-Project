//
//  AddNewPostVC.swift
//  Final Project
//
//  Created by Abdelrahman Nada on 26/05/2022.
//

import UIKit
import NVActivityIndicatorView

class AddNewPostVC: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var postTextLabelOutlet: UILabel!
    @IBOutlet weak var postTextFieldOutlet: UITextField!
    @IBOutlet weak var linkPostImageOutlet: UILabel!
    @IBOutlet weak var linkPostImageTextFieldOutlet: UITextField!
    @IBOutlet weak var addButtonOutlet: UIButton!
    @IBOutlet weak var activityLodarIndicatorOutlet: NVActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Action
    // MARK: - Add Button
    @IBAction func addButtonPressed(_ sender: Any) {
        
        if let user = UserManager.loggedInUser {
            
            addButtonOutlet.setTitle("", for: .normal)
            activityLodarIndicatorOutlet.startAnimating()
            PostAPI.addNewPost(text: postTextFieldOutlet.text!, userId: user.id) {
                self.activityLodarIndicatorOutlet.stopAnimating()
                self.addButtonOutlet.setTitle("ADD", for: .normal)
                
                NotificationCenter.default.post(name: NSNotification.Name("NewPostAdded"), object: nil)
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
