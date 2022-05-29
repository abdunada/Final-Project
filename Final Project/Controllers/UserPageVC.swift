//
//  RegisterVC.swift
//  Final Project
//
//  Created by Abdelrahman Nada on 10/05/2022.
//

import UIKit
import NVActivityIndicatorView

class UserPageVC: UIViewController {
    
    // MARK: - Outlets
    // MARK: - Page Name Outlet
    @IBOutlet weak var pageNameLabelOutlet: UILabel!
    // MARK: - email Outlet
    @IBOutlet weak var emailLabelOutlet: UILabel!
    @IBOutlet weak var emailTextFieldOutlet: UITextField!
    // MARK: - firstName Outlet
    @IBOutlet weak var firstNameLabelOutlet: UILabel!
    @IBOutlet weak var firstNameTextFieldOutlet: UITextField!
    // MARK: - lastName Outlet
    @IBOutlet weak var lastNameLabelOutlet: UILabel!
    @IBOutlet weak var lastNameTextFieldOutlet: UITextField!
    // MARK: - Forget Username Button Outlet
    @IBOutlet weak var forgetUserNameButtonOutlet: UIButton!
    // MARK: - Resend Email Button Outlet
    @IBOutlet weak var resendEmailButtonOutlet: UIButton!
    // MARK: - Register Button Outlet
    @IBOutlet weak var registerButtonOutlet: UIButton!
    // MARK: - Have An Account Label Outlet
    @IBOutlet weak var haveAnAccountLabelOutlet: UILabel!
    // MARK: - Login Button Outlet
    @IBOutlet weak var loginButtonOutlet: UIButton!
    @IBOutlet weak var activityLoaderIndicatorOutlet: NVActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Fill userName Auto
        self.firstNameTextFieldOutlet.text = "abdu"
        self.lastNameTextFieldOutlet.text = "nada"
        
        resendEmailButtonOutlet.isHidden = true
        // MARK: - Make Label is empty
        emailLabelOutlet.text = ""
        firstNameLabelOutlet.text = ""
        lastNameLabelOutlet.text = ""
        // MARK: - Textfield Delegate
        emailTextFieldOutlet.delegate = self
        firstNameTextFieldOutlet.delegate = self
        lastNameTextFieldOutlet.delegate = self
        // MARK: - Make it "Forget Password Button" invisible with the start.
        forgetUserNameButtonOutlet.isHidden = true
        setupBackgroundTap()
    }
    
    // MARK: - Variables
    var isLogin: Bool = false
    
    // MARK: - Actions
    // MARK: - Forget Password Pressed
    @IBAction func forgetUserNameButtonPressed(_ sender: Any) {
        
        // MARK: - Validation with if Statement By switch
        if isDataInputedFor(mode: "forgetUsername") {
            print("OK")
        } else {

            // MARK: - Alert
            let alert = UIAlertController()
            let alertAction = UIAlertAction(title: "Error all data is required.", style: .destructive, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        }
    }
    // MARK: - Resend Email Pressed
    @IBAction func resendEmailButtonPressed(_ sender: Any) {
        
        // MARK: - Validation
        // MARK: - Validation with if Statement By switch
//        if isDataInputedFor(mode: isLogin ? "login" : "register") {
//            print("OK")
//        } else {
//            // MARK: - Show error with ProgressHUD
//            //            ProgressHUD.showError("Error, all data is required.")
//            // MARK: - Alert
//            let alert = UIAlertController()
//            let alertAction = UIAlertAction(title: "Error all data is required.", style: .destructive, handler: nil)
//            alert.addAction(alertAction)
//            present(alert, animated: true, completion: nil)
//        }
//        // MARK: - Guard Validation & Custom Alert
//        guard !emailTextFieldOutlet.text!.isEmpty, !firstNameTextFieldOutlet.text!.isEmpty, !lastNameTextFieldOutlet.text!.isEmpty else {
//            customAlert(title: "Error", message: "Please fill all fields are required.", alertStyle: .alert, buttonTitle: "OK", buttonStyle: .destructive)
//            return
//        }
    }
    // MARK: - Register Pressed
    @IBAction func registerButtonPressed(_ sender: Any) {
        // MARK: - Validation
        // MARK: - Validation with if Statement By switch
        if isDataInputedFor(mode: isLogin ? "login" : "register") {
            print("OK")
            
            isLogin ? loginUser() : registerUser()
            
        } else {
            
            //  MARK: - Alert
            let alert = UIAlertController(title: "ERROR", message: "All data is required.", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
            alert.addAction(alertAction)
            present(alert, animated: true, completion: nil)
        }
        // MARK: - Guard Validation & Custom Alert
//        guard !emailTextFieldOutlet.text!.isEmpty, !firstNameTextFieldOutlet.text!.isEmpty, !lastNameTextFieldOutlet.text!.isEmpty else {
//            customAlert(title: "Error", message: "Please fill all fields are required.", alertStyle: .alert, buttonTitle: "OK", buttonStyle: .destructive)
//            return
//        }
    }
    // MARK: - Skip Button
    @IBAction func skipButtonPressed(_ sender: Any) {
        
        if let page = storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? MainTabBarController {
            
            navigationController?.pushViewController(page, animated: true)
        }
    }
    
    // MARK: - Login Button
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        updateUIMode(mode: isLogin)
    }
}

// MARK: - Extension
// MARK: - Extension for textfield Delegate
extension UserPageVC: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        // MARK: - Show label with writing at textfiled
        emailLabelOutlet.text = emailTextFieldOutlet.hasText ? "E-mail" : ""
        firstNameLabelOutlet.text = firstNameTextFieldOutlet.hasText ? "First Name" : ""
        lastNameLabelOutlet.text = lastNameTextFieldOutlet.hasText ? "Last Name" : ""
    }
    // MARK: - Custom Alert
    func customAlert(title: String, message: String, alertStyle: UIAlertController.Style, buttonTitle: String, buttonStyle: UIAlertAction.Style) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        let alertAction = UIAlertAction(title: buttonTitle, style: buttonStyle, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true, completion: nil)
    }
}
// MARK: - Extension Func of Register User, Login User, Login Page toggle, Helpers or Utilities and Tap Gesture
extension UserPageVC {
    
    // MARK: - Register User
    private func registerUser() {

        activityLoaderIndicatorOutlet.startAnimating()
        
        UserAPI.registerNewUser(firstName: firstNameTextFieldOutlet.text!, lastName: lastNameTextFieldOutlet.text!, email: emailTextFieldOutlet.text!) { user, errorMessage  in
            
            self.activityLoaderIndicatorOutlet.stopAnimating()
            
            if errorMessage != nil {
                
                let alert = UIAlertController(title: "ERROR", message: errorMessage, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
                
            } else {
                
                let alert = UIAlertController(title: "SUCCESS", message: "Created Successfully.", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // MARK: - Login User
    private func loginUser() {
        
        activityLoaderIndicatorOutlet.startAnimating()
        
        UserAPI.loginUser(firstName: firstNameTextFieldOutlet.text!, lastName: lastNameTextFieldOutlet.text!) { user, errorMessage in
        
            self.activityLoaderIndicatorOutlet.stopAnimating()
            
            if let message = errorMessage {
                let alert = UIAlertController(title: "ERROR", message: message, preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
            } else {
                // TODO: - move to MainTabBarController
                if let loggedInUser = user {
                    let page = self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
                    
                    UserManager.loggedInUser = loggedInUser
                    self.navigationController?.pushViewController(page, animated: true)
                }
            }
        }
    }
    
    // MARK: - Login Page toggle
    private func updateUIMode(mode: Bool) {
        if !mode {
            pageNameLabelOutlet.text = "Login"
            emailLabelOutlet.isHidden = true
            emailTextFieldOutlet.isHidden = true
            forgetUserNameButtonOutlet.isHidden = false
            resendEmailButtonOutlet.isHidden = true
            registerButtonOutlet.setTitle("Login", for: .normal)
            haveAnAccountLabelOutlet.text = "Already have an account?"
            loginButtonOutlet.setTitle("Register", for: .normal)
        } else {
            pageNameLabelOutlet.text = "Register"
            emailLabelOutlet.isHidden = false
            emailTextFieldOutlet.isHidden = false
            forgetUserNameButtonOutlet.isHidden = true
            resendEmailButtonOutlet.isHidden = true
            registerButtonOutlet.setTitle("Register", for: .normal)
            haveAnAccountLabelOutlet.text = "Don't have an account?"
            loginButtonOutlet.setTitle("Login", for: .normal)
        }
        isLogin.toggle()
    }
    // MARK: - Helpers or Utilities
    private func isDataInputedFor(mode: String) ->Bool {
        switch mode {
        case "login":
            return firstNameTextFieldOutlet.text != "" &&
            lastNameTextFieldOutlet.text != ""
        case "register":
            return emailTextFieldOutlet.text != "" &&
            firstNameTextFieldOutlet.text != "" &&
            lastNameTextFieldOutlet.text != ""
        case "forgetUsername":
            return firstNameTextFieldOutlet.text != "" && lastNameTextFieldOutlet.text != ""
        case "resendEmail":
            return emailTextFieldOutlet.text != ""
        default:
            return false
        }
    }
    // MARK: - Tap Gesture
    func setupBackgroundTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    @objc func hideKeyboard () {
        view.endEditing(false)
    }
}
