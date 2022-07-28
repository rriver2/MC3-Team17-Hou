//
//  Static.swift
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
}
