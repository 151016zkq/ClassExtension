//
//  UIView+extension.swift
//  SmartPicc
//
//  Created by 张凯强 on 2020/10/14.
//  Copyright © 2020 cn.picclife. All rights reserved.
//

import Foundation
import UIKit
public enum NSLayoutEqualType {
    case equal
    case less
    case grather
    
}

public extension UIView {
    
    func setSpecifyCornerRound(byRoundingCorners:UIRectCorner,cornerRadius:CGFloat)  {
        let maskPath = UIBezierPath.init(roundedRect: self.bounds, byRoundingCorners:byRoundingCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        maskLayer.bounds = self.bounds
        maskLayer.position = CGPoint(x: self.bounds.width/2 , y: self.bounds.height/2 )
        self.layer.mask = maskLayer
    }
    
    ///截图当前view位置的图片
    func clip() -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0.0)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {return nil}
        UIGraphicsEndImageContext()
        guard let data = image.jpegData(compressionQuality: 1) else {
            return nil
        }
        //截取指定范围
        return UIImage.init(data: data) //image

    }

    
    
    func embellishView(redius : CGFloat)  {
        self.layer.cornerRadius = redius
        self.layer.masksToBounds = true
    }
    func ddSizeToFit( contentInset : UIEdgeInsets = UIEdgeInsets.zero) {
        self.sizeToFit()
        let frame = self.bounds
        self.contentMode = UIView.ContentMode.center
        self.bounds = CGRect(x: 0, y: 0, width: frame.width + (contentInset.left + contentInset.right), height: frame.height + (contentInset.top + contentInset.bottom))
    }
    var x: CGFloat {
        set{
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
        get{
            return self.frame.origin.x
        }
    }
    var y: CGFloat {
        set{
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
        get{
            return self.frame.origin.y
        }
    }
    var width: CGFloat {
        set{
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
            
        }
        get{
            return self.frame.size.width
        }
    }
    
    var height: CGFloat {
        set{
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
            
        }
        get{
            return self.frame.size.height
        }
    }
    var origin: CGPoint {
        set{
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
        get{
            return self.frame.origin
        }
    }
    var size: CGSize {
        set{
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
        get{
            return self.frame.size
        }
    }
    var centerX: CGFloat {
        set{
            var center = self.center
            center.x = newValue
            self.center = center
        }
        get {
            return self.center.x
        }
    }
    var centerY: CGFloat {
        set{
            var center = self.center
            center.y = newValue
            self.center = center
        }
        get{
            return self.center.y
        }
    }
    var max_X: CGFloat {
        set{
            
        }
        get{
            return self.frame.maxX
        }
    }
    var max_Y: CGFloat{
        set{
            
        }
        get{
            return self.frame.maxY
        }
    }

    
    
    
}
///按钮中图片的位置枚举
public enum ButtonImagePositionStyle {
    ///图片在左文字在右
    case `default`
    ///图片在右文字左
    case right
    ///图片在上，文字在下
    case top
    ///图片在下文字在上
    case bottom

}
public extension UIButton {
    func createBtnWith(imagePositionStyle: ButtonImagePositionStyle, spacing: CGFloat, imagePositionBlock: (UIButton) -> ()) {
        imagePositionBlock(self)
        switch imagePositionStyle {
        case .default:
            switch self.contentHorizontalAlignment {
            case .left:
                self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: spacing, bottom: 0, right: 0)
            case .right:
                self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: spacing)
            default:
                self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -0.5 * spacing, bottom: 0, right: 0.5 * spacing)
                self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 0.5 * spacing, bottom: 0, right: -0.5 * spacing)
            }
            
        case .right:
            let imageW = self.imageView?.image?.size.width ?? 0
            let titleW = self.titleLabel?.frame.size.width ?? 0
            
            switch self.contentHorizontalAlignment {
            case .left:
                self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: titleW + spacing, bottom: 0, right: 0)
                self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -imageW, bottom: 0, right: 0)
            case .right:
                self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: -titleW)
                self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: imageW + spacing)
            default:
                let imageOffset = titleW + 0.5 * spacing
                let titleOffset = imageW + 0.5 * spacing
                self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: imageOffset, bottom: 0, right: -imageOffset)
                self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -titleOffset, bottom: 0, right: titleOffset)
            }
        case .top:
            let imageW = self.imageView?.frame.size.width ?? 0
            let imageH = self.imageView?.frame.size.height ?? 0
            let titleIntrinsicContentSizeW = self.titleLabel?.intrinsicContentSize.width ?? 0
            let titleIntrinsicContentSizeH = self.titleLabel?.intrinsicContentSize.height ?? 0
            self.imageEdgeInsets = UIEdgeInsets.init(top: -titleIntrinsicContentSizeH - spacing, left: 0, bottom: 0, right: -titleIntrinsicContentSizeW)
            self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: imageW, bottom: -imageH - spacing, right: 0)
        case .bottom:
            let imageW = self.imageView?.frame.size.width ?? 0
            let imageH = self.imageView?.frame.size.height ?? 0
            let titleIntrinsicContentSizeW = self.titleLabel?.intrinsicContentSize.width ?? 0
            let titleIntrinsicContentSizeH = self.titleLabel?.intrinsicContentSize.height ?? 0
            self.imageEdgeInsets = UIEdgeInsets.init(top: titleIntrinsicContentSizeH + spacing, left: 0, bottom: 0, right: -titleIntrinsicContentSizeW)
            self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -imageW, bottom: imageH + spacing, right: 0)
            
        default:
            break
        }
    }
}



extension UIStackView {

    func safelyRemoveArrangedSubviews() {

        // Remove all the arranged subviews and save them to an array
        let removedSubviews = arrangedSubviews.reduce([]) { (sum, next) -> [UIView] in
            self.removeArrangedSubview(next)
            return sum + [next]
        }

        // Deactive all constraints at once
        NSLayoutConstraint.deactivate(removedSubviews.flatMap({ $0.constraints }))

        // Remove the views from self
        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}



public extension UIView {
    @available(iOS 9.0, *)
    func leading(anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>,equalType:NSLayoutEqualType = .equal, constant: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        switch equalType {
        case .equal:
            self.leadingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        case .less:
            self.leadingAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
        case .grather:
            self.leadingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
        default:
            break
        }
    }

    
    @available(iOS 9.0, *)
    func trailing(anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>,equalType:NSLayoutEqualType = .equal, constant: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        switch equalType {
        case .equal:
            self.trailingAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        case .less:
            self.trailingAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
        case .grather:
            self.trailingAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
        default:
            break
        }
    }
    
    @available(iOS 9.0, *)
    func left(anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>,equalType:NSLayoutEqualType = .equal, constant: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        switch equalType {
        case .equal:
            self.leftAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        case .less:
            self.leftAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
        case .grather:
            self.leftAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
        default:
            break
        }
    }
    @available(iOS 9.0, *)
    func leftEqual(anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) {
        self.left(anchor: anchor, equalType: .equal, constant: constant)
    }

    
    @available(iOS 9.0, *)
    func leftSuperView(equalType:NSLayoutEqualType = .equal, constant: CGFloat = 0) {
        guard let superView = self.superview else { return }
        self.left(anchor: superView.leftAnchor, equalType: equalType, constant: constant)
    }
    
    @available(iOS 9.0, *)
    func rightSuperView(equalType:NSLayoutEqualType = .equal, constant: CGFloat = 0) {
        guard let superView = self.superview else { return }
        self.right(anchor: superView.rightAnchor, equalType: equalType, constant: constant)
    }



    
    @available(iOS 9.0, *)
    func right(anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>,equalType:NSLayoutEqualType = .equal, constant: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        switch equalType {
        case .equal:
            self.rightAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        case .less:
            self.rightAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
        case .grather:
            self.rightAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
        default:
            break
        }
    }
    
    @available(iOS 9.0, *)
    func rightEqual(anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) {
        self.right(anchor: anchor, equalType: .equal, constant: constant)
    }

    
    @available(iOS 9.0, *)
    func top(anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>,equalType:NSLayoutEqualType = .equal, constant: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        switch equalType {
        case .equal:
            self.topAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        case .less:
            self.topAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
        case .grather:
            self.topAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
        default:
            break
        }
    }
    @available(iOS 9.0, *)
    func topSuperView(equalType:NSLayoutEqualType = .equal, constant: CGFloat = 0) {
        guard let superView = self.superview else { return  }
        self.top(anchor: superView.topAnchor, equalType: equalType, constant: constant)
    }
    
    
    @available(iOS 9.0, *)
    func bottom(anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>,equalType:NSLayoutEqualType = .equal, constant: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        switch equalType {
        case .equal:
            self.bottomAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        case .less:
            self.bottomAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
        case .grather:
            self.bottomAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
        default:
            break
        }
    }
    @available(iOS 9.0, *)
    func bottomSuperView(equalType:NSLayoutEqualType = .equal, constant: CGFloat = 0) {
        guard let superView = self.superview else { return  }
        self.bottom(anchor: superView.bottomAnchor, equalType: equalType, constant: constant)
    }
    @available(iOS 9.0, *)
    func bottomEqual(anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) {
        self.bottom(anchor: anchor, equalType: .equal, constant: constant)
    }


    @available(iOS 9.0, *)
    func centerY(anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>,equalType:NSLayoutEqualType = .equal, constant: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        switch equalType {
        case .equal:
            self.centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        case .less:
            self.centerYAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
        case .grather:
            self.centerYAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
        default:
            break
        }
    }
    @available(iOS 9.0, *)
    func centerYEuqal(anchor: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) {
        self.centerY(anchor: anchor, equalType: .equal, constant: constant)
    }

    
    @available(iOS 9.0, *)
    func centerYSuperView(constant: CGFloat = 0) {
        guard let superView = self.superview else { return  }
        self.centerY(anchor: superView.centerYAnchor, equalType: .equal, constant: constant)
    }



    @available(iOS 9.0, *)
    func centerX(anchor: NSLayoutAnchor<NSLayoutXAxisAnchor>,equalType:NSLayoutEqualType = .equal, constant: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        switch equalType {
        case .equal:
            self.centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        case .less:
            self.centerXAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant).isActive = true
        case .grather:
            self.centerXAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant).isActive = true
        default:
            break
        }
    }
    @available(iOS 9.0, *)
    func centerXSuperView(equalType:NSLayoutEqualType = .equal, constant: CGFloat = 0) {
        guard let superView = self.superview else { return  }
        self.centerX(anchor: superView.centerXAnchor, equalType: equalType, constant: constant)
    }


    @available(iOS 9.0, *)
    func width(anchor: NSLayoutDimension,equalType:NSLayoutEqualType = .equal,multiplier: CGFloat = 1, constant: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        switch equalType {
        case .equal:
            self.widthAnchor.constraint(equalTo: anchor, multiplier: multiplier, constant: constant).isActive = true
        case .less:
            self.widthAnchor.constraint(lessThanOrEqualTo: anchor, multiplier: multiplier, constant: constant).isActive = true
        case .grather:
            self.widthAnchor.constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier, constant: constant).isActive = true
        default:
            break
        }
    }

    @available(iOS 9.0, *)
    func height(anchor: NSLayoutDimension,equalType:NSLayoutEqualType = .equal,multiplier: CGFloat = 1, constant: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        switch equalType {
        case .equal:
            self.heightAnchor.constraint(equalTo: anchor, multiplier: multiplier, constant: constant).isActive = true
        case .less:
            self.heightAnchor.constraint(lessThanOrEqualTo: anchor, multiplier: multiplier, constant: constant).isActive = true
        case .grather:
            self.heightAnchor.constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier, constant: constant).isActive = true
        default:
            break
        }
    }
    @available(iOS 9.0, *)
    func heightConstant(equalType:NSLayoutEqualType = .equal, constant: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        switch equalType {
        case .equal:
            self.heightAnchor.constraint(equalToConstant: constant).isActive = true
        case .less:
            self.heightAnchor.constraint(lessThanOrEqualToConstant: constant).isActive = true
        case .grather:
            self.heightAnchor.constraint(greaterThanOrEqualToConstant: constant).isActive = true
        default:
            break
        }
    }
    @available(iOS 9.0, *)
    func heightEqualConstant(constant: CGFloat) {
        self.heightConstant(equalType: .equal, constant: constant)
    }

    @available(iOS 9.0, *)
    func widthConstant(equalType:NSLayoutEqualType = .equal, constant: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        switch equalType {
        case .equal:
            self.widthAnchor.constraint(equalToConstant: constant).isActive = true
        case .less:
            self.widthAnchor.constraint(lessThanOrEqualToConstant: constant).isActive = true
        case .grather:
            self.widthAnchor.constraint(greaterThanOrEqualToConstant: constant).isActive = true
        default:
            break
        }
    }
    
    @available(iOS 9.0, *)
    func widthEqualConstant(constant: CGFloat = 0) {
        self.widthConstant(equalType: .equal, constant: constant)
    }

    
    @available(iOS 9.0, *)
    func edges(top: CGFloat = 0, left:CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
        self.topSuperView(equalType: .equal, constant: top)
        self.leftSuperView(equalType: .equal, constant: left)
        self.rightSuperView(equalType: .equal, constant: -right)
        self.bottomSuperView(equalType: .equal, constant: -bottom)
    }


}
