//
//  Colors.swift
//  EasyPay
//
//  Created by Vaishnavi on 12/12/24.
//

import Foundation
import UIKit

extension UIColor {
    
    static var AppGreen1: UIColor {
        return UIColor(hexString: "#578555")!
    }
    
    static var AppGreen2: UIColor {
        return UIColor(hexString: "#73B870")!
    }

    //MARK: - init method with hex string and alpha(default: 1)
    public convenience init?(hexString: String, alpha: CGFloat = 1.0) {
        var formatted = hexString.replacingOccurrences(of: "0x", with: "")
        formatted = formatted.replacingOccurrences(of: "#", with: "")
        if let hex = Int(formatted, radix: 16) {
            let red = CGFloat(CGFloat((hex & 0xFF0000) >> 16)/255.0)
            let green = CGFloat(CGFloat((hex & 0x00FF00) >> 8)/255.0)
            let blue = CGFloat(CGFloat((hex & 0x0000FF) >> 0)/255.0)
            self.init(red: red, green: green, blue: blue, alpha: alpha)        }
        else {
            return nil
        }
    }
}
