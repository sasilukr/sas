//
//  Utils.swift
//  sasiraymic
//
//  Created by Sasi Ruangrongsorakai on 12/29/17.
//  Copyright © 2017 com.sasiluk. All rights reserved.
//

import Foundation
import UIKit


extension UIColor {
    
    static func fromHex(_ argb: UInt32)  -> UIColor {
        return UIColor(
            red: CGFloat((argb >> 16) & 0xFF)/255.0,
            green: CGFloat((argb >> 8) & 0xFF)/255.0,
            blue: CGFloat(argb & 0xFF)/255.0,
            alpha: CGFloat((argb >> 24) & 0xFF)/255.0
        )
    }
}

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
