//
//  MaterialCard.swift
//  EasyPay
//
//  Created by Neshwa on 12/12/24.
//


import UIKit

@IBDesignable
public class MaterialCard: UIView {

    // Custom properties for shadow and corner radius
    @IBInspectable open var shadowOffsetWidth: CGFloat = 0 {
        didSet { setNeedsLayout() }
    }
    
    @IBInspectable open var shadowOffsetHeight: CGFloat = 0.5 {
        didSet { setNeedsLayout() }
    }
    
    @IBInspectable open var customShadowColor: UIColor = .black {
        didSet { setNeedsLayout() }
    }
    
    @IBInspectable open var customShadowOpacity: Float = 0.5 {
        didSet { setNeedsLayout() }
    }
    
    @IBInspectable open var customCornerRadius: CGFloat = 10 {
        didSet { setNeedsLayout() }
    }

    // Override layoutSubviews to apply changes
    override open func layoutSubviews() {
        super.layoutSubviews()

        // Apply corner radius
        layer.cornerRadius = customCornerRadius
        layer.masksToBounds = false

        // Shadow Path for smooth shadow rendering
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: customCornerRadius)
        layer.shadowPath = shadowPath.cgPath
        
        // Apply shadow properties
        layer.shadowColor = customShadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        layer.shadowOpacity = customShadowOpacity
        
        // Set masksToBounds to false to avoid clipping the shadow
        layer.masksToBounds = false
    }
}
