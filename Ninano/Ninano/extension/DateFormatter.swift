//
//  DateFormatter.swift
//  Ninano
//
//  Created by 이가은 on 2022/07/25.
//

import Foundation

extension Date {
    enum DataFormatCatagory: String {
        case koreanDate = "yyyy년 MM월 dd일(EEEEE)"
    }
    
    func convertDateToKoreanDate(_ dataFormatCatagory: DataFormatCatagory) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dataFormatCatagory.rawValue
        formatter.locale = Locale(identifier: "ko_KR")
        let koreanDate = formatter.string(from: self)
        return koreanDate
    }
}
