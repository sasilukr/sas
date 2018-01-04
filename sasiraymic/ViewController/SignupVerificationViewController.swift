//
//  SignupVerificationViewController.swift
//  sasiraymic
//
//  Created by Sasi Ruangrongsorakai on 1/3/18.
//  Copyright © 2018 com.sasiluk. All rights reserved.
//

import Foundation

import AWSCognitoIdentityProvider

class SignupVerificationViewController: UIViewController {
    
    var verificationField = UITextField()
    var verifyButton = UIButton()
    var resendVerificationButton = UIButton()
    var verificationLabel = UILabel()

    var codeDeliveryDetails:AWSCognitoIdentityProviderCodeDeliveryDetailsType?
    
    var user: AWSCognitoIdentityUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.addSubview(verificationLabel)
        self.view.addSubview(verificationField)
        self.view.addSubview(verifyButton)
        self.view.addSubview(resendVerificationButton)
        self.view.backgroundColor = .white

        verificationLabel.text = "Enter the verification code that was sent to the email address you provided:"
        verificationLabel.lineBreakMode = .byWordWrapping
        verificationLabel.numberOfLines = 0
        verificationField.customizeInputTextField()
        
        
        verifyButton.setTitleColor(.black, for: .normal)
        verifyButton.setTitleColor(.gray, for: .disabled)
        verifyButton.setTitle("Verify your account", for: .normal)
        verifyButton.addTarget(self, action: #selector(verifyAction), for: .touchUpInside)
        
        
        resendVerificationButton.setTitleColor(.black, for: .normal)
        resendVerificationButton.setTitle("Resend verificaton code", for: .normal)
        resendVerificationButton.addTarget(self, action: #selector(resendConfirmationCodeAction), for: .touchUpInside)
        
        verificationLabel.snp.makeConstraints { m in
            m.width.equalTo(self.view.frame.size.width)
            m.top.equalTo(self.view.snp.top).offset(Style.Spacing.X8)
        }
        
        verificationField.snp.makeConstraints { m in
            m.width.equalTo(self.view.frame.size.width)
            m.top.equalTo(self.verificationLabel.snp.top).offset(Style.Spacing.X8)
        }
        verifyButton.snp.makeConstraints { m in
            m.width.equalTo(self.view.frame.size.width)
            m.top.equalTo(self.verificationField.snp.bottom).offset(Style.Spacing.X2)
        }
        
        
        resendVerificationButton.snp.makeConstraints { m in
            m.width.equalTo(self.view.frame.size.width)
            m.top.equalTo(self.verifyButton.snp.bottom).offset(Style.Spacing.X2)
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.verifyButton.isEnabled = false
        self.verificationField.addTarget(self, action: #selector(inputDidChange(_:)), for: .editingChanged)
        populateCodeDeliveryDetails()
    }
    
    
    @objc func inputDidChange(_ sender:AnyObject) {
        if verificationField.text?.isEmpty == true {
            self.verifyButton.isEnabled = false
        } else {
            self.verifyButton.isEnabled = true
        }
    }
    
    
    func populateCodeDeliveryDetails() {
        let isEmail = (codeDeliveryDetails?.deliveryMedium == AWSCognitoIdentityProviderDeliveryMediumType.email)
        verifyButton.setTitle(isEmail ? "Verify Email Address" : "Verify Phone Number", for: .normal)
        let medium = isEmail ? "your email address" : "your phone number"
        let destination = codeDeliveryDetails?.destination ?? ""
        verificationLabel.text = "Please enter the code that was sent to \(medium) at \(destination)"
    }
    
    func resetConfirmation(message:String? = "") {
        self.verificationField.text = ""
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: nil))
        self.present(alert, animated: true, completion:nil)
    }
    
    
    @objc func verifyAction(_ sender: AnyObject) {
        guard let verificationCode = verificationField.text, verificationCode.isEmpty == false else {
            let alert = UIAlertController(title: "Missing information", message: "Please enter the verification code.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion:nil)
            return
        }
        self.user?.confirmSignUp(verificationCode)
            .continueWith(block: { (response) -> Any? in
                DispatchQueue.main.async {
                    
                    if response.error != nil {
                        self.resetConfirmation(message: (response.error! as NSError).userInfo["message"] as? String)
                    } else {
                        // Return to Login View Controller - this should be handled a bit differently, but added in this manner for simplicity
                        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                    }

                }
                return nil

            })
    }
    
    @objc func resendConfirmationCodeAction(_ sender: AnyObject) {
        self.user?.resendConfirmationCode()
            .continueWith(block: { (respone) -> Any? in
                DispatchQueue.main.async {
                    
                    let alert = UIAlertController(title: "Resent", message: "The confirmation code has been resent.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true, completion:nil)
                }
                return nil
            })
    }
}
