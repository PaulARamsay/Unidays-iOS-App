//
//  Breed.swift
//  WhatTypeOfDogIsThat
//
//  Created by Paul Ramsay on 15/08/2022.
//

import Foundation

struct BreedList: Decodable {
    let breed: [String : [String]]
    
    enum CodingKeys: String, CodingKey {
        case breed = "message"
    }
}
