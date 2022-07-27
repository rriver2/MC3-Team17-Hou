//
//  Static.swift
//  Ninano
//
//  Created by 이가은 on 2022/07/27.
//

import Foundation
import UIKit

class StaticFunc {
    static func cropImage(image: UIImage, rect: CGRect) -> UIImage {
        guard let cgImage = image.cgImage else { return UIImage() }
        let croppedCGImage = cgImage.cropping(to: rect)
        return UIImage(cgImage: croppedCGImage!)
    }
}
