//
//  Quote.swift
//  Quotes
//
//  Created by Matthew Curran on 4/2/19.
//  Copyright © 2019 Matthew. All rights reserved.
//

import Foundation

struct Quote: Decodable {
    
    let id: Int
    let text: String
    let author: String
    let link: String
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case text = "content"
        case author = "title"
        case link
    }
}
