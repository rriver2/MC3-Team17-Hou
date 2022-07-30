//
//  StringFormatter.swift
//  Ninano
//
//  Created by Yoonjae on 2022/07/29.
//

import Foundation
import UIKit

extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: self)
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}
