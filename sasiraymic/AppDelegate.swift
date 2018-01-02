//
//  AppDelegate.swift
//  sasiraymic
//
//  Created by Sasi Ruangrongsorakai on 12/26/17.
//  Copyright © 2017 com.sasiluk. All rights reserved.
//

import UIKit
import AWSCognitoIdentityProvider

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rememberDeviceCompletionSource: AWSTaskCompletionSource<NSNumber>?
    var loginViewController: LoginViewController?
    
    class func defaultUserPool() -> AWSCognitoIdentityUserPool {
        return AWSCognitoIdentityUserPool(forKey: AwsCognitoKeys.IdentityPoolId)
    }
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.setupCognitoUserPool()
        return true
    }
    
    func setupCognitoUserPool() {
        let clientId:String = AwsCognitoKeys.CognitoIdentityUserPoolAppClientId
        let poolId:String = AwsCognitoKeys.CognitoIdentityUserPoolId
        let clientSecret:String = AwsCognitoKeys.CognitoIdentityUserPoolAppClientSecret
        let region:AWSRegionType = AwsCognitoKeys.CognitoIdentityUserPoolRegion
        
        let serviceConfiguration:AWSServiceConfiguration = AWSServiceConfiguration(region: region, credentialsProvider: nil)
        let cognitoConfiguration:AWSCognitoIdentityUserPoolConfiguration = AWSCognitoIdentityUserPoolConfiguration(clientId: clientId, clientSecret: clientSecret, poolId: poolId)
        AWSCognitoIdentityUserPool.register(with: serviceConfiguration, userPoolConfiguration: cognitoConfiguration, forKey: AwsCognitoKeys.IdentityPoolId)
        let pool:AWSCognitoIdentityUserPool = AppDelegate.defaultUserPool()
        pool.delegate = self
    }


    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


extension AppDelegate: AWSCognitoIdentityInteractiveAuthenticationDelegate {
    
    
    func startPasswordAuthentication() -> AWSCognitoIdentityPasswordAuthentication {
        print("\(#function)")
        if(self.loginViewController == nil) {
            self.loginViewController = LoginViewController()
        }
        
        DispatchQueue.main.async {
            if(self.loginViewController!.isViewLoaded || self.loginViewController!.view.window == nil) {
                UIApplication.topViewController()?.present(self.loginViewController!, animated: true, completion: nil)
            }
        }
        print("\(#function) \(String(describing: self.loginViewController))")

        return self.loginViewController!
    }
    
//    func startMultiFactorAuthentication() -> AWSCognitoIdentityMultiFactorAuthentication {
//        if (self.mfaViewController == nil) {
//            self.mfaViewController = MFAViewController()
//            self.mfaViewController?.modalPresentationStyle = .popover
//        }
//        DispatchQueue.main.async {
//            if (!self.mfaViewController!.isViewLoaded
//                || self.mfaViewController!.view.window == nil) {
//                //display mfa as popover on current view controller
//                let viewController = self.window?.rootViewController!
//                viewController?.present(self.mfaViewController!,
//                                        animated: true,
//                                        completion: nil)
//
//                // configure popover vc
//                let presentationController = self.mfaViewController!.popoverPresentationController
//                presentationController?.permittedArrowDirections = UIPopoverArrowDirection.left
//                presentationController?.sourceView = viewController!.view
//                presentationController?.sourceRect = viewController!.view.bounds
//            }
//        }
//        return self.mfaViewController!
//    }
    
    func startRememberDevice() -> AWSCognitoIdentityRememberDevice {
        return self
    }
}

// MARK:- AWSCognitoIdentityRememberDevice protocol delegate

extension AppDelegate: AWSCognitoIdentityRememberDevice {
    
    func getRememberDevice(_ rememberDeviceCompletionSource: AWSTaskCompletionSource<NSNumber>) {
        self.rememberDeviceCompletionSource = rememberDeviceCompletionSource
        DispatchQueue.main.async {
            // dismiss the view controller being present before asking to remember device
            self.window?.rootViewController!.presentedViewController?.dismiss(animated: true, completion: nil)
            let alertController = UIAlertController(title: "Remember Device",
                                                    message: "Do you want to remember this device?.",
                                                    preferredStyle: .actionSheet)
            
            let yesAction = UIAlertAction(title: "Yes", style: .default, handler: { (action) in
                self.rememberDeviceCompletionSource?.set(result: true)
            })
            let noAction = UIAlertAction(title: "No", style: .default, handler: { (action) in
                self.rememberDeviceCompletionSource?.set(result: false)
            })
            alertController.addAction(yesAction)
            alertController.addAction(noAction)
            
            self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
    
    func didCompleteStepWithError(_ error: Error?) {
        DispatchQueue.main.async {
            if let error = error as NSError? {
                let alertController = UIAlertController(title: error.userInfo["__type"] as? String,
                                                        message: error.userInfo["message"] as? String,
                                                        preferredStyle: .alert)
                let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
                alertController.addAction(okAction)
                DispatchQueue.main.async {
                    self.window?.rootViewController?.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}


