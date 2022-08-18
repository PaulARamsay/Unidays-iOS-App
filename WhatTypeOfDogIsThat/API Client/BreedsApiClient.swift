//
//  BreedsAPIClient.swift
//  WhatTypeOfDogIsThat
//
//  Created by Paul Ramsay on 15/08/2022.
//

import Foundation
import Alamofire

protocol BreedsClient {
    func getBreedsList(completion: @escaping (BreedList?) -> ())
    func getBreedImageList(breedName: String,
                           completion: @escaping(BreedImages?) -> ())
}

class BreedsApiClient: BreedsClient {
    
    func getBreedImageList(breedName: String,
                           completion: @escaping (BreedImages?) -> ()) {
        let urlAsString = URL.Endpoints.getBreedImageList
            .replacingOccurrences(of: "{breed_name}", with: "\(breedName)")
        let request = AF.request(urlAsString)

        request.responseDecodable(of: BreedImages.self) { response in
            guard let model = response.value else {
                completion(nil)
                return
            }
            
            completion(model)
        }
    }
    
    func getBreedsList(completion: @escaping (BreedList?) -> ()) {
        let request = AF.request(URL.Endpoints.getBreedList)

        request.responseDecodable(of: BreedList.self) { response in
            guard let model = response.value else {
                completion(nil)
                return
            }
            
            completion(model)
        }
    }
}
