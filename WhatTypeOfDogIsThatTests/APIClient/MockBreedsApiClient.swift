//
//  MockBreedsApiClient.swift
//  WhatTypeOfDogIsThatTests
//
//  Created by Paul Ramsay on 15/08/2022.
//

import Foundation

class MockBreedsApiClient: BreedsClient {
    
    var didRequestBreedsList = false
    var didRequestImageList = false
    
    func getBreedsList(completion: @escaping (BreedList) -> ()) {
        self.didRequestBreedsList = true
        completion(.init(breed: ["test" : ["test sub breed"]]))
    }
    
    func getBreedImageList(breedName: String,
                           completion: @escaping(BreedImages) -> ()) {
        self.didRequestImageList = true
        completion(.init(imageList: [""]))
        
    }
}
