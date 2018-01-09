//
//  ForgotPasswordViewController.swift
//  CognitoApplication
//
//  Created by David Tucker on 8/2/17.
//  Edited by Sasiluk Ruangrongsorakai on 1/5/28.
//  Copyright © 2017 David Tucker. All rights reserved.
//

import UIKit
import AWSCognitoIdentityProvider

class ForgotPasswordViewController: UIViewController {
    
    var forgotPasswordLabel = UILabel()
    var verificationCode = UITextField()
    var newPassword = UITextField()
    var confirmPassword = UITextField()
    var resetPasswordButton = UIButton()
    var cancelForgotPasswordButton = UIButton()

    var emailAddress:String = ""
    var user:AWSCognitoIdentityUser?
    
    func clearFields() {
        self.verificationCode.text = ""
        self.newPassword.text = ""
        self.confirmPassword.text = ""
        self.emailAddress = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(forgotPasswordLabel)
        self.view.addSubview(verificationCode)
        self.view.addSubview(newPassword)
        self.view.addSubview(confirmPassword)
        self.view.addSubview(resetPasswordButton)
        self.view.addSubview(cancelForgotPasswordButton)
        self.view.backgroundColor = .white
        
        forgotPasswordLabel.text = "Please enter verification code and a new password:"
        forgotPasswordLabel.lineBreakMode = .byWordWrapping
        forgotPasswordLabel.numberOfLines = 0
        
        verificationCode.placeholder = "Verification Code"
        verificationCode.backgroundColor = Style.Color.Primary.ui
        verificationCode.layer.cornerRadius = Style.Spacing.X2
        
        newPassword.placeholder = "New Password"
        newPassword.backgroundColor = Style.Color.Primary.ui
        newPassword.layer.cornerRadius = Style.Spacing.X2
        
        
        confirmPassword.placeholder = "Confirm Password"
        confirmPassword.backgroundColor = Style.Color.Primary.ui
        confirmPassword.layer.cornerRadius = Style.Spacing.X2
        
        
        resetPasswordButton.setTitleColor(.black, for: .normal)
        resetPasswordButton.setTitleColor(.gray, for: .disabled)
        resetPasswordButton.setTitle("Reset Password", for: .normal)
        resetPasswordButton.addTarget(self, action: #selector(resetPasswordAction), for: .touchUpInside)

        
        cancelForgotPasswordButton.setTitleColor(.black, for: .normal)
        cancelForgotPasswordButton.setTitle(R.string.localizable.buttonCancel(), for: .normal)
        cancelForgotPasswordButton.addTarget(self, action: #selector(cancelForgotPasswordAction), for: .touchUpInside)
        
        // layout
        forgotPasswordLabel.snp.makeConstraints { m in
            m.width.equalTo(self.view.frame.size.width)
            m.top.equalTo(self.view.snp.top).offset(Style.Spacing.X8)
        }
        
        verificationCode.snp.makeConstraints { m in
            m.width.equalTo(self.view.frame.size.width)
            m.top.equalTo(self.forgotPasswordLabel.snp.bottom).offset(Style.Spacing.X2)
        }

        newPassword.snp.makeConstraints { m in
            m.width.equalTo(self.view.frame.size.width)
            m.top.equalTo(self.verificationCode.snp.bottom).offset(Style.Spacing.X2)
        }
        
        confirmPassword.snp.makeConstraints { m in
            m.width.equalTo(self.view.frame.size.width)
            m.top.equalTo(self.newPassword.snp.bottom).offset(Style.Spacing.X2)
        }
        
        resetPasswordButton.snp.makeConstraints { m in
            m.width.equalTo(self.view.frame.size.width)
            m.top.equalTo(self.confirmPassword.snp.bottom).offset(Style.Spacing.X2)
        }
        
        cancelForgotPasswordButton.snp.makeConstraints { m in
            m.width.equalTo(self.view.frame.size.width)
            m.top.equalTo(self.resetPasswordButton.snp.bottom).offset(Style.Spacing.X2)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if !emailAddress.isEmpty {
            let pool = AppDelegate.defaultUserPool()
            // Get a reference to the user using the email address
            user = pool.getUser(emailAddress)
            // Initiate the forgot password process which will send a verification code to the user
            user?.forgotPassword()
                .continueWith(block: { (response) -> Any? in
                    if response.error != nil {
                        // Cannot request password reset due to error (for example, the attempt limit exceeded)
                        let alert = UIAlertController(title: "Cannot Reset Password", message: (response.error! as NSError).userInfo["message"] as? String, preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                            self.clearFields()
                            self.presentingViewController?.dismiss(animated: true, completion: nil)
                        }))
                        self.present(alert, animated: true, completion: nil)
                        return nil
                    }
                    // Password reset was requested and message sent.  Let the user know where to look for code.
                    let result = response.result
                    let isEmail = (result?.codeDeliveryDetails?.deliveryMedium == AWSCognitoIdentityProviderDeliveryMediumType.email)
                    let destination:String = result!.codeDeliveryDetails!.destination!
                    let medium = isEmail ? "an email" : "a text message"
                    let alert = UIAlertController(title: "Verification Sent", message: "You should receive \(medium) with a verification code at \(destination).  Enter that code here along with a new password.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return nil
                })
        }
    }
    
    @objc func resetPasswordAction(_ sender: AnyObject) {
        user?.confirmForgotPassword(self.verificationCode.text!, password: self.newPassword.text!)
            .continueWith { (response) -> Any? in
                if response.error != nil {
                    // The password could not be reset - let the user know
                    let alert = UIAlertController(title: "Cannot Reset Password", message: (response.error! as NSError).userInfo["message"] as? String, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Resend Code", style: .default, handler: { (action) in
                        self.user?.forgotPassword()
                            .continueWith(block: { (result) -> Any? in
                                print("Code Sent")
                                return nil
                            })
                    }))
                    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
                        DispatchQueue.main.async {
                            self.presentingViewController?.dismiss(animated: true, completion: nil)
                        }
                    }))
                    DispatchQueue.main.async {
                        self.present(alert, animated: true, completion: nil)
                    }
                } else {
                    // Password reset.  Send the user back to the login and let them know they can login with new password.
                    DispatchQueue.main.async {
                        let presentingController = self.presentingViewController
                        self.presentingViewController?.dismiss(animated: true, completion: {
                            let alert = UIAlertController(title: "Password Reset", message: "Password reset.  Please log into the account with your email and new password.", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                            presentingController?.present(alert, animated: true, completion: nil)
                            self.clearFields()
                        }
                        )
                    }
                }
                return nil
        }
    }
    
    @IBAction func cancelForgotPasswordAction(_ sender: AnyObject) {
        clearFields()
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}

