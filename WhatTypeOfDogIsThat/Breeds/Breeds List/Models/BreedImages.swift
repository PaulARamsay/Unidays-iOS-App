//
//  BreedImageList.swift
//  WhatTypeOfDogIsThat
//
//  Created by Paul Ramsay on 15/08/2022.
//

import Foundation

struct BreedImages: Decodable {
    let imageList: [String]
    
    enum CodingKeys: String, CodingKey {
        case imageList = "message"
    }
}
