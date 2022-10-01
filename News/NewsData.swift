//
//  NewsData.swift
//  News
//
//  Created by Gulyaz Huseynova on 12.09.22.
//

import UIKit

struct NewsData : Codable {
    let articles: [Articles]
}

struct Articles: Codable, Equatable{
    let title: String?
    let date: String?
    let author: String?
    let topic : String?
    let media: URL?
    let link: URL?
    let excerpt: String?
    let summary: String?

    
    enum CodingKeys: String, CodingKey{
        case date = "published_date"
        case title
        case author
        case topic
        case media
        case link
        case excerpt
        case summary

    }
}

