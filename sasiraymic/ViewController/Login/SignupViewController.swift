//
//  SignupViewController.swift
//  sasiraymic
//
//  Created by Sasi Ruangrongsorakai on 12/30/17.
//  Copyright © 2017 com.sasiluk. All rights reserved.
//

import UIKit
import AWSCognitoIdentityProvider

class SignupViewController: UIViewController {
    
    var usernameTextField = UITextField()
    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    var signupButton = UIButton()
    var cancelButton = UIButton()
    
    
    var firstNameTextField = UITextField()
    var lastNameTextField = UITextField()
    var confirmPasswordTextField = UITextField()
    var phoneNumberTextField = UITextField()
    
    
    var user: AWSCognitoIdentityUser?
    var codeDeliveryDetails:AWSCognitoIdentityProviderCodeDeliveryDetailsType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameTextField.placeholder = R.string.localizable.signupUsername()
        usernameTextField.customizeInputTextField()
        
        emailTextField.placeholder = R.string.localizable.loginEmail()
        emailTextField.customizeInputTextField()
        
        
        passwordTextField.placeholder = R.string.localizable.loginPassword()
        passwordTextField.customizeInputTextField()
        
        firstNameTextField.customizeInputTextField()
        lastNameTextField.customizeInputTextField()
        confirmPasswordTextField.customizeInputTextField()
        phoneNumberTextField.customizeInputTextField()
        
        
        signupButton.setTitleColor(.black, for: .normal)
        signupButton.setTitleColor(.gray, for: .disabled)
        signupButton.setTitle(R.string.localizable.buttonSignup(), for: .normal)
        signupButton.addTarget(self, action: #selector(signupAction), for: .touchUpInside)

        cancelButton.setTitleColor(.black, for: .normal)
        cancelButton.setTitle(R.string.localizable.buttonCancel(), for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        
        
        self.view.addSubview(usernameTextField)
        self.view.addSubview(emailTextField)
        self.view.addSubview(firstNameTextField)
        self.view.addSubview(lastNameTextField)
        self.view.addSubview(passwordTextField)
        self.view.addSubview(confirmPasswordTextField)
        self.view.addSubview(phoneNumberTextField)
        self.view.addSubview(signupButton)
        self.view.addSubview(cancelButton)

        self.view.backgroundColor = .white
        
        usernameTextField.snp.makeConstraints { m in
            m.width.equalTo(self.view.frame.size.width)
            m.top.equalTo(self.view.snp.top).offset(Style.Spacing.X8)
        }
        
        emailTextField.snp.makeConstraints { m in
            m.width.equalTo(self.view.frame.size.width)
            m.top.equalTo(self.usernameTextField.snp.bottom).offset(Style.Spacing.X2)
        }
        
        
        firstNameTextField.snp.makeConstraints { m in
            m.width.equalTo(self.view.frame.size.width)
            m.top.equalTo(self.emailTextField.snp.bottom).offset(Style.Spacing.X2)
        }
        
        lastNameTextField.snp.makeConstraints { m in
            m.width.equalTo(self.view.frame.size.width)
            m.top.equalTo(self.firstNameTextField.snp.bottom).offset(Style.Spacing.X2)
        }
        
        passwordTextField.snp.makeConstraints { m in
            m.width.equalTo(self.view.frame.size.width)
            m.top.equalTo(self.lastNameTextField.snp.bottom).offset(Style.Spacing.X2)
        }
        
        confirmPasswordTextField.snp.makeConstraints { m in
            m.width.equalTo(self.view.frame.size.width)
            m.top.equalTo(self.passwordTextField.snp.bottom).offset(Style.Spacing.X2)
        }
        
        phoneNumberTextField.snp.makeConstraints { m in
            m.width.equalTo(self.view.frame.size.width)
            m.top.equalTo(self.confirmPasswordTextField.snp.bottom).offset(Style.Spacing.X2)
        }
        signupButton.snp.makeConstraints { m in
            m.width.equalTo(self.view.frame.size.width/2)
            m.height.equalTo(Style.Spacing.X4)
            m.top.equalTo(self.phoneNumberTextField.snp.bottom).offset(Style.Spacing.X6)
            m.left.equalTo(self.view.snp.left)
        }
        
        cancelButton.snp.makeConstraints { m in
            m.width.equalTo(self.view.frame.size.width/2)
            m.height.equalTo(Style.Spacing.X4)
            m.top.equalTo(self.signupButton.snp.top)
            m.left.equalTo(self.signupButton.snp.right)
        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.signupButton.isEnabled = false
        self.usernameTextField.addTarget(self, action: #selector(inputDidChange), for: .editingChanged)
        self.firstNameTextField.addTarget(self, action: #selector(inputDidChange), for: .editingChanged)
        self.lastNameTextField.addTarget(self, action: #selector(inputDidChange), for: .editingChanged)
        self.emailTextField.addTarget(self, action: #selector(inputDidChange), for: .editingChanged)
        self.passwordTextField.addTarget(self, action: #selector(inputDidChange), for: .editingChanged)
        self.confirmPasswordTextField.addTarget(self, action: #selector(inputDidChange), for: .editingChanged)
        self.phoneNumberTextField.addTarget(self, action: #selector(inputDidChange), for: .editingChanged)
    }

    
    @objc func inputDidChange(_ sender:AnyObject) {
        
        if usernameTextField.text?.isEmpty == true {
            self.signupButton.isEnabled = false
            return
        }
        if (firstNameTextField.text?.isEmpty == true || lastNameTextField.text?.isEmpty == true) {
            self.signupButton.isEnabled = false
            return
        }
        if emailTextField.text?.isEmpty == true {
            self.signupButton.isEnabled = false
            return
        }
        if (passwordTextField.text?.isEmpty == true || confirmPasswordTextField.text?.isEmpty == true) {
            self.signupButton.isEnabled = false
            return
        }
        if phoneNumberTextField.text?.isEmpty == true {
            self.signupButton.isEnabled = false
            return
        }
        self.signupButton.isEnabled = (passwordTextField.text == confirmPasswordTextField.text)
    }

    
    @objc func signupAction() {
        guard let email = emailTextField.text, let password = passwordTextField.text,
        email.isEmpty == false, password.isEmpty == false else {
            let alertController = UIAlertController(title: "Missing information",
                                                    message: "Please fill in your information",
                                                    preferredStyle: .alert)
            let retryAction = UIAlertAction(title: R.string.localizable.buttonOk(), style: .default, handler: nil)
            alertController.addAction(retryAction)
            self.present(alertController, animated: true, completion:  nil)
            return
        }
        let userPool = AppDelegate.defaultUserPool()
        // TODO send username attributes
        let emailAttribute = AWSCognitoIdentityUserAttributeType(name: "email", value: emailTextField.text!)
        let firstNameAttribute = AWSCognitoIdentityUserAttributeType(name: "given_name", value: firstNameTextField.text!)
        let lastNameAttribute = AWSCognitoIdentityUserAttributeType(name: "family_name", value: lastNameTextField.text!)
        let phoneNumberAttribute = AWSCognitoIdentityUserAttributeType(name: "phone_number", value: phoneNumberTextField.text!)
        let attributes:[AWSCognitoIdentityUserAttributeType] = [emailAttribute, firstNameAttribute, lastNameAttribute, phoneNumberAttribute]
        userPool.signUp(email, password: password, userAttributes: attributes, validationData: nil)
            .continueWith { (response) -> Any? in
                if response.error != nil {
                    // Error in the Signup Process
                    DispatchQueue.main.async {

                    let alert = UIAlertController(title: "Error", message: (response.error! as NSError).userInfo["message"] as? String, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler:nil))
                    self.present(alert, animated: true, completion: nil)
                    }
                } else {
                    self.user = response.result!.user
                    // Does user need confirmation?
                    if (response.result?.userConfirmed?.intValue != AWSCognitoIdentityUserStatus.confirmed.rawValue) {
                        // User needs confirmation, so we need to proceed to the verify view controller
                        DispatchQueue.main.async {
                            self.codeDeliveryDetails = response.result?.codeDeliveryDetails
                            let verificationVc = SignupVerificationViewController()
                            verificationVc.codeDeliveryDetails = self.codeDeliveryDetails
                            verificationVc.user = self.user
                            self.present(verificationVc, animated: true, completion: nil)
//                            self.performSegue(withIdentifier: "VerifySegue", sender: self)
                            // TODO call verification VC with user and codeDeliveryDetails info
                        }
                    } else {
                        // User signed up but does not need confirmation.  This should rarely happen (if ever).
                        DispatchQueue.main.async {
                            self.presentingViewController?.dismiss(animated: true, completion: nil)
                        }
                    }
                }
                return nil
        }
    }
    
    @objc func cancelAction() {
        self.dismiss(animated: true, completion: nil)
    }
}


