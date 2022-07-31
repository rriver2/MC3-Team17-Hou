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
        case onlyDate = "yyyy MM dd"
    }
    
    func convertDateToOtherType(_ dataFormatCatagory: DataFormatCatagory) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dataFormatCatagory.rawValue
        formatter.locale = Locale(identifier: "ko_KR")
        let koreanDate = formatter.string(from: self)
        return koreanDate
    }
    public func isDateToday(fromDate: Date) -> Bool {
        self.convertDateToOtherType(.onlyDate) == fromDate.convertDateToOtherType(.onlyDate)
    }
}

extension String {
    /// self : "2022-08-10~2022-08-10: yyyy-MM-dd~yyyy-MM-dd"
    func periodToDateList() -> [Date] {
        // TODO: 2022-08-10~2022-09-03 -> 8월 10일 ~ 9월 3일 날짜 다 넣기 ...
        var returnDateList: [Date] = []
        let dateStringList = Array(Set(self.components(separatedBy: "~"))).sorted()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        for dateString in dateStringList {
            if let date = dateFormatter.date(from: dateString) {
                returnDateList.append(date)
            }
        }

        return returnDateList.sorted()
    }
    /// 2022-08-10~2022-09-03 -> 2022.09.03~08.10
    func dateFormatForUI() -> String {
        let dateStringList = Array(Set(self.components(separatedBy: "~"))).sorted()
        var returnString = dateStringList[0].components(separatedBy: "-").joined(separator: ".")
        if dateStringList.count == 2 {
            let exceptYear = dateStringList[1].components(separatedBy: "-")
            returnString += "~" + exceptYear[1] + "." + exceptYear[2]
        }
        return returnString
    }
}
