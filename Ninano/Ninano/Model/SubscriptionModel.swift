//
//  SubscriptionModel.swift
//  Ninano
//
//  Created by KYUBO A. SHIM on 2022/07/25.
//

import UIKit

struct LikeModel: Codable, Equatable {
    let nameLike: String
    let isLiked: Bool
    let url: String
}

struct ReserveModel: Codable, Equatable {
    let reserveDate: Date?
    let isReserved: Bool
    let url: String
}

struct KeywordModel: Codable, Equatable {
    let keywordSubs: String
}
