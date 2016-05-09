//
//  FakeImageRepository.swift
//  alamofireimagetest
//
//  Created by Alexandros Spyropoulos on 09/05/2016.
//  Copyright © 2016 Alexandros Spyropoulos. All rights reserved.
//

import BrightFutures;

struct ImageType {
    let url: String
    let description: String
}

struct CustomError: ErrorType {
    let code: Int
    let description: String
}


class FakeImageRepository {
    
    func find() -> Future<[ImageType], CustomError> {
        let promise = Promise<[ImageType], CustomError>()
        
        
        return promise.future
    }
}