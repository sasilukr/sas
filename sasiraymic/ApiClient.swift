//
//  ApiClient.swift
//  sasiraymic
//
//  Created by Sasi Ruangrongsorakai on 12/30/17.
//  Copyright © 2017 com.sasiluk. All rights reserved.
//

import Foundation
import AWSCognitoIdentityProvider

class ApiClient {
    static let shared = ApiClient()
    private init() {}
    
    func getPots(success: @escaping (NSArray) -> Void,
                 failure: @escaping (Any?) -> Void) {
        
        let credentialsProvider = AWSCognitoCredentialsProvider(regionType: .USEast1,
                                                                identityPoolId: AwsCognitoKeys.IdentityPoolId,
                                                                identityProviderManager: AppDelegate.defaultUserPool())
        let configuration = AWSServiceConfiguration(region: AWSRegionType.USEast1,
                                                    credentialsProvider: credentialsProvider)
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        
        let apiClient = AWSProdpotsappapiClient.default()
        
        apiClient.potsGet().continueWith {(t: AWSTask<AnyObject>) in
            if let error = t.error {
                failure(nil)
            } else if let result = t.result as? NSArray {
                success(result)
            } else {
                failure(nil)
            }
    
            self.showResult(task: t)
            return nil
        }
    }
    
    func showResult(task: AWSTask<AnyObject>) {
        if let error = task.error {
            print("Error: \(error)")
        } else if let result = task.result {
            if result is NSDictionary {
                let res = result as! NSDictionary
                print("NSDictionary: \(res)")
            } else if result is NSArray {
                print("NSArray: \(result)")
            }
        } else {
            print("task: \(task)")
        }
    }
}
