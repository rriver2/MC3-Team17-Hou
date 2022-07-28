//
//  UIImage.swift
//  Ninano
//
//  Created by 이가은 on 2022/07/27.
//

import Foundation
import UIKit

extension UIImage {
    func cropImage(rect: CGRect) -> UIImage {
        guard let cgImage = self.cgImage else { return UIImage() }
        let croppedCGImage = cgImage.cropping(to: rect)
        return UIImage(cgImage: croppedCGImage!)
    }
    func resizeImage(newWidth: CGFloat) -> UIImage? {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
