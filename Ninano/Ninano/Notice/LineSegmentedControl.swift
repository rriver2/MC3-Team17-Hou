//
//  LineSegmentedControl.swift
//  Ninano
//
//  Created by KYUBO A. SHIM on 2022/07/18.
//

import UIKit

class LineSegmentedControl: UISegmentedControl {

}

extension UIImage {
    static func getSegRect(color: CGColor, andSize size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color)
        let rectangle = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        context?.fill(rectangle)
        
        guard let rectangleImage = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        UIGraphicsEndImageContext()
        return rectangleImage
    }
}

extension UISegmentedControl {
    func removeBorder() {
        let background = UIImage.getSegRect(color: UIColor.clear.cgColor, andSize: self.bounds.size)
        self.setBackgroundImage(background, for: .normal, barMetrics: .default)
        self.setBackgroundImage(background, for: .selected, barMetrics: .default)
        self.setBackgroundImage(background, for: .highlighted, barMetrics: .default)
        
        let deviderLine = UIImage.getSegRect(color: UIColor.clear.cgColor, andSize: CGSize(width: 1.0, height: 5))
        self.setDividerImage(deviderLine, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lightGray], for: .normal)
        self.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 1.0)], for: .selected)
    }
    
    func highlightSelectedSegment() {
        removeBorder()
        let lineWidth: CGFloat = self.bounds.size.width / CGFloat(self.numberOfSegments) - 14
        let lineHeight: CGFloat = 3.0
        let lineXPosition = CGFloat(selectedSegmentIndex * Int(lineWidth)) + 7.0
        let lineYPosition = self.bounds.size.height - 1.0
        let underlineFrame = CGRect(x: lineXPosition, y: lineYPosition, width: lineWidth, height: lineHeight)
        let underLine = UIView(frame: underlineFrame)
        underLine.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.8) // bottom line color
        underLine.tag = 1
        self.addSubview(underLine)
    }
        
    func underlinePosition() {
        guard let underLine = self.viewWithTag(1) else {return}
        let xPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(selectedSegmentIndex) + 7.0
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: .curveEaseInOut, animations: {
            underLine.frame.origin.x = xPosition
        })
    }
}
