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
    
    var getBreedsListStubbed: BreedList? = .init(breed: ["test" : ["test sub breed"]])
    var getBreedImageListStubbed: BreedImages? = .init(imageList: [""])
    
    func getBreedsList(completion: @escaping (BreedList?) -> ()) {
        self.didRequestBreedsList = true
        completion(self.getBreedsListStubbed)
    }
    
    func getBreedImageList(breedName: String,
                           completion: @escaping(BreedImages?) -> ()) {
        self.didRequestImageList = true
        completion(self.getBreedImageListStubbed)
    }
}
