//
//  UIImage+extension.swift
//  PLBaseModule
//
//  Created by 张凯强 on 2021/2/7.
//

import Foundation
extension UIImage {
    ///获取本地bundle中的图片
    public static func imageWith(currentClass: AnyClass, resourceBundleName: String, imageName: String) -> UIImage?{
        var imageName = imageName
        if UIScreen.main.scale == 3.0 && !imageName.hasSuffix("@3x") {
            imageName += "@3x"
        }
        if UIScreen.main.scale == 2.0 && !imageName.hasSuffix("@2x") {
            imageName += "@2x"
        }
        let bundle = Bundle.init(for: currentClass)
        guard let url = bundle.url(forResource: resourceBundleName, withExtension: "bundle") else {return nil}
        guard let imageBundle = Bundle.init(url: url)else {return nil}
        guard let imagePath = imageBundle.path(forResource: imageName, ofType: "png") else { return nil }
        let image = UIImage.init(contentsOfFile: imagePath)
        return image


    }
    //截取屏幕
    class func clip(view: UIView) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 0.0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {return nil}
        UIGraphicsEndImageContext()
        guard let data = UIImageJPEGRepresentation(image, 1) else {
            return nil
        }
        //截取指定范围
        return UIImage.init(data: data) //image

    }

}
