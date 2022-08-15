//
//  URL+Extensions.swift
//  WhatTypeOfDogIsThat
//
//  Created by Paul Ramsay on 15/08/2022.
//

import Foundation

extension URL {
    
    enum Endpoints {
        static let getBreedImageList = "https://dog.ceo/api/breed/{breed_name}/images"
        static let getBreedList = "https://dog.ceo/api/breeds/list/all"
    }
}
