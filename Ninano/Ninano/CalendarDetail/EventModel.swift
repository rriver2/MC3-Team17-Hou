//
//  EventModel.swift
//  Ninano
//
//  Created by Eunbee Kang on 2022/07/19.
//

import Foundation

struct Event {
    var eventName: String
    var eventPosterName: String
    var eventPlace: String
    var eventPeriod: String
    var eventDate: String
    var eventTime: String
    var isLiked: Bool
    var isReserved: Bool
}

struct EventData {
    var list = [
        Event(eventName: "반향 2022: 묵", eventPosterName: "banhyang", eventPlace: "경기아트센터 대극장",
              eventPeriod: "2022.7.15~2022.7.20", eventDate: "", eventTime: "20:00", isLiked: true, isReserved: true),
        Event(eventName: "국립창극단 <귀토>", eventPosterName: "guiTo", eventPlace: "국립극장 해오름극장",
              eventPeriod: "2022.7.18~2022.7.25", eventDate: "", eventTime: "수목금 19:30, 토일 15:00", isLiked: false, isReserved: true)
    ]
}
