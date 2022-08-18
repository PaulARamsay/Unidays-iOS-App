//
//  Breeds.swift
//  WhatTypeOfDogIsThat
//
//  Created by Paul Ramsay on 15/08/2022.
//

import Foundation

struct Breed {
    let breedName: String
    var breedImageList: [String]
    let subBreeds: [String]    
}

struct BreedData {
    let breedName: String
    let subBreeds: [String]
}
