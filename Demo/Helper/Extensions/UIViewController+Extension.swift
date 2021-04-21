//
//  UIViewController+Extension.swift
//  Demo
//
//  Created by Ganesh Manickam on 20/04/21.
//

import Foundation
import UIKit

extension UIViewController {
    
    /**
     Function to push viewController to next view controller
    - PARAMETER vc: Instance of `UIViewController`
    - PARAMETER animated: Boolean value to define whether animation required or not
     */
    func pushTo(_ vc: UIViewController, animated: Bool) {
        self.navigationController?.pushViewController(vc, animated: animated)
    }
    
    /**
     Function to present viewController to next view controller
    - PARAMETER vc: Instance of `UIViewController`
    - PARAMETER animated: Boolean value to define whether animation required or not
     */
    func presentTo(_ vc: UIViewController, animated: Bool) {
        self.present(vc, animated: animated, completion: nil)
    }
    
    /**
     Function to dimiss/pop viewController to previous view controller
    - PARAMETER animated: Boolean value to define whether animation required or not
     */
    func customDismissViewController(_ animated: Bool) {
        if let _ = self.navigationController?.popViewController(animated: animated) {
        } else {
            self.dismiss(animated: animated, completion: nil)
        }
    }
    
}
