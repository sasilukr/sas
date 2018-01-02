//
//  TabBarController.swift
//  sasiraymic
//
//  Created by Sasi Ruangrongsorakai on 12/26/17.
//  Copyright © 2017 com.sasiluk. All rights reserved.
//

import Foundation
import UIKit
import AWSCognitoIdentityProvider

class TabBarController: UITabBarController, UITabBarControllerDelegate {
    var user:AWSCognitoIdentityUser?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self

        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(logoutAction),
                                               name: .onLogout,
                                               object: nil)
        
        self.fetchUserAttributes()

    }
    
    
    func fetchUserAttributes() {
        user = AppDelegate.defaultUserPool().currentUser()
        user?.getDetails()
            //            .continueOnSuccessWith(block: { (task) -> Any? in
            //                guard task.result != nil else {
            //                    print("\(#function) nil result")
            //                    return nil
            //                }
            //                print("\(#function)")
            //                //            self.userAttributes = task.result?.userAttributes
            //                //            self.mfaSettings = task.result?.mfaOptions
            //                //            self.userAttributes?.forEach({ (attribute) in
            //                //                print("Name: " + attribute.name!)
            //                //            })
            //                //            DispatchQueue.main.async {
            //                //                self.setAttributeValues()
            //                //            }
            //                return nil
            //            })
            .continueWith(block: { (task: AWSTask<AWSCognitoIdentityUserGetDetailsResponse>) -> Any? in
                if let error = task.error {
                    print("Error: \(error)")
                } else if let result = task.result {
                    print("result \(result)")
                    NotificationCenter.default.post(name: .onLogin, object: nil)
                }
                return nil
            })
    }
    
    @objc func logoutAction() {
        user?.signOut()
        self.fetchUserAttributes()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
//        if viewController is HomeViewController {
//            print("Home tab")
//        } else if viewController is AddViewController {
//            print("Add tab")
//        } else if viewController is ProfileViewController {
//            print("Profile tab")
//        }
    }
}
