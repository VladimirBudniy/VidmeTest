//
//  LoginViewController.swift
//  VidMe
//
//  Created by Vladimir Budniy on 4/26/17.
//  Copyright © 2017 Vladimir Budniy. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate, AlertViewController {

    @IBOutlet var loginTextField: UITextField?
    @IBOutlet var passwordTextField: UITextField?
    @IBOutlet var loginButton: UIButton?
    
    let const = AuthConst()
    let alertViewController = UIAlertController()
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // check userdefault token
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Login button action
    
    @IBAction func onLoginButton(_ sender: Any) {
        if let login = self.loginTextField?.text, let password = self.passwordTextField?.text {
            if self.isValidEmail(text: login), self.isValidPassword(text: password) {
                createAuthenticationSession(login, password, self.userCreate)
            } else {
                self.showAlertController(message: AlertControllerConst().erroValidation)
            }
        }
    }
    
    // MARK: - Blocks methods
    
    func loadError(error: String) {
        self.showAlertController(title: "", message: error)
    }
    
    func userCreate(_ isCreate: Bool) {
        if isCreate {
            self.reloadTabBarController()
        } else {
            self.loadError(error: AlertControllerConst().userNotFound)
        }
    }
    
    // MARK: - Private
    
    private func reloadTabBarController() {
        let tabBarController = self.tabBarController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let featuredViewController = storyboard.instantiateViewController(withIdentifier: "FeaturedViewController")
        let newViewController = storyboard.instantiateViewController(withIdentifier: "NewViewController")
        let feedViewController = storyboard.instantiateViewController(withIdentifier: "FeedViewController")
        let controllers = [featuredViewController, newViewController, feedViewController]
        
        tabBarController?.setViewControllers(controllers, animated: true)
        tabBarController?.selectedViewController = feedViewController
    }
    
    private func showAlertController(title: String? = nil, message: String) {
        self.present(self.alertViewController(title: title, message: message), animated: true, completion: nil)
    }
    
    // MARK: - Validation
    
    private func isValidEmail(text: String?) -> Bool {
//        let emailCheck = NSPredicate(format:"SELF MATCHES %@", CheckEmailRange().emailRange)
//        let isCheck = emailCheck.evaluate(with: text)
//        if isCheck == false {
//            self.showAlertController(message: AlertControllerConst().emailMessage)
//        }
        return true
    }
    
    private func isValidPassword(text: String?) -> Bool {
        let passwordCheck = text
        let isCheck = (passwordCheck?.characters.count)! >= 8
        if isCheck == false {
            self.showAlertController(message: AlertControllerConst().charactersQty)
        }
        
        return isCheck
    }
    
    private func checkWhitespace(string: String?) -> Bool {
        if string == " " {
            self.showAlertController(message: AlertControllerConst().whitespaceMessage)
            return false
        }
        
        return true
    }
    
    // MARK: - UITextFieldDelegate Protocol Reference
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case let textField where textField == self.loginTextField:
            let isValid = self.isValidEmail(text: textField.text)
            if isValid == false {
                textField.text = ""
            }
            
            self.passwordTextField?.becomeFirstResponder()
            return isValid
            
        case let textField where textField == self.passwordTextField:
            let isValid = self.isValidPassword(text: textField.text)
            self.passwordTextField?.endEditing(true)
            
            return isValid
            
        default:
            return true
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField {
        case let textField where textField == self.loginTextField:
            return self.checkWhitespace(string: string)
            
        case let textField where textField == self.passwordTextField:
            return self.checkWhitespace(string: string)
            
        default:
            return true
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case let textField where textField == self.loginTextField:
           _ = self.isValidEmail(text: textField.text)
            
        case let textField where textField == self.passwordTextField:
            _ = self.isValidPassword(text: textField.text)

        default:
            break
        }
    }

}
