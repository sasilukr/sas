//
//  ProfileViewController.swift
//  sasiraymic
//
//  Created by Sasi Ruangrongsorakai on 12/26/17.
//  Copyright © 2017 com.sasiluk. All rights reserved.
//

import UIKit
import AVFoundation

class ProfileViewController: UIViewController {
    
    var usernameLabel = UILabel()
    
    var logoutButton = UIButton()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.addSubview(usernameLabel)
        self.view.addSubview(logoutButton)
        
        if let user = AppDelegate.defaultUserPool().currentUser() {
            self.title = user.username
            usernameLabel.text = user.username
        }
    
        usernameLabel.lineBreakMode = .byWordWrapping
        usernameLabel.numberOfLines = 0
        usernameLabel.textAlignment = .center
        
        
        logoutButton.tintColor = .black
        logoutButton.setTitleColor(.black, for: .normal)
        logoutButton.setTitle(R.string.localizable.buttonLogout(), for: .normal)
        logoutButton.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
        
        
        usernameLabel.snp.makeConstraints { m in
            m.width.equalTo(self.view.frame.size.width)
            m.top.equalTo(self.view.snp.top).offset(Style.Spacing.X8 + Style.Spacing.X2)
        }
        
        logoutButton.snp.makeConstraints { m in
            m.width.equalTo(self.view.frame.size.width)
            m.top.equalTo(self.usernameLabel.snp.bottom).offset(Style.Spacing.X2)
        }
        
        
    }
    
    @objc func logoutAction() {
        NotificationCenter.default.post(name: .onLogout, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
