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

extension UITextField {
    func customizeInputTextField() {
        self.backgroundColor = Style.Color.Primary.ui
        self.layer.cornerRadius = 5
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 20))
        self.leftView = paddingView
        self.leftViewMode = UITextFieldViewMode.always
        self.tintColor = UIColor.white
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
