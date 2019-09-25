//
//  NewsModel.swift
//  News App
//
//  Created by Krishna on 25/09/19.
//  Copyright © 2019 Krishna. All rights reserved.
//

import Foundation

//MARK: - NewsModel
struct NewsList : Codable {
    
    var articles : [NewsData]
    let status : String?
    
    enum CodingKeys: String, CodingKey {
        case articles 
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.articles = try values.decode([NewsData].self, forKey: .articles)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }
}

//MARK: - CategoryData
struct NewsData : Codable {
    
    let title : String?
    let newsDesc : String?
    let imgUrl : String?
    let content : String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case newsDesc = "description"
        case imgUrl = "urlToImage"
        case content
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        newsDesc = try values.decodeIfPresent(String.self, forKey: .newsDesc)
        imgUrl = try values.decodeIfPresent(String.self, forKey: .imgUrl)
        content = try values.decodeIfPresent(String.self, forKey: .content)
    }
}
