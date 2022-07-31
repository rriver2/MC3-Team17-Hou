//
//  Calendar.swift
//  Ninano
//
//  Created by Eunbee Kang on 2022/07/31.
//

import Foundation

extension Calendar {
    private var currentDate: Date { return Date() }

    func isDateInThisMonth(_ date: Date) -> Bool {
        return isDate(date, equalTo: currentDate, toGranularity: .month)
    }
}
