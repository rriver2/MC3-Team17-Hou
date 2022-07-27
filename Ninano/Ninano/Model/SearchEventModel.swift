//
//  SearchEventModel.swift
//  Ninano
//
//  Created by Eunbee Kang on 2022/07/27.
//

import Foundation

class SearchEvent {
    let title: String
    let posterURL: URL?
    var posterData: Data?
    let place: String?
    let area: String?
    let period: String?
    let uRL: String?
    let actor: String?
    let info: String?
    let price: String?
    
    init(title: String, posterURL: URL?, place: String, area: String, period: String, uRL: String?, actor: String, info: String, price: String) {
        self.title = title
        self.posterURL = posterURL
        self.place = place
        self.area = area
        self.period = period
        self.uRL = uRL
        self.actor = actor
        self.info = info
        self.price = price
    }
}
