//
//  FakeImageRepository.swift
//  alamofireimagetest
//
//  Created by Alexandros Spyropoulos on 09/05/2016.
//  Copyright © 2016 Alexandros Spyropoulos. All rights reserved.
//


//import Foundation
import Alamofire
import Haneke
import BrightFutures
import SwiftyJSON


struct ImageType {
    let url: String
    let description: String
    
    func load(view: UIImageView) {
        let URL = NSURL(string: self.url)!
        view.hnk_setImageFromURL(URL)
    }
}





struct CustomError: ErrorType {
    let code: Int
    let description: String
}







class ImageFactory {
    
    
    func make(data: SwiftyJSON.JSON) -> [ImageType] {
        return makeImages(data)
    }
    
    
    
    func makeImages(data: SwiftyJSON.JSON) -> [ImageType] {
        var images = [ImageType]()
        
        for (_,d):(String, SwiftyJSON.JSON) in data {
            
            do {
                let image = try makeImage(d)
                images.append(image)
            } catch {
                
            }
            
        }
        return images
    }
    
    
    
    func makeImage(data: SwiftyJSON.JSON) throws -> ImageType {
        
        guard (data["images"]["dealSmall"].string != nil) else {
            throw CustomError(code: 3, description: "Value out of range")
        }
        
        guard (data["title"].string != nil) else {
            throw CustomError(code: 3, description: "Value out of range")
        }
        
        
        let u = data["images"]["dealSmall"].stringValue
        let des = data["title"].stringValue
        
        return ImageType(url: u, description:des)
    }
}








class ImageRepository {
    
    func find() -> Future<[ImageType], CustomError> {
        let factory = ImageFactory()
        
        let promise = Promise<[ImageType], CustomError>()
        let headers = [
            "accept": "application/json",
            "q-auth-token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjo3MTEsImlhdCI6MTQ2MDEzMDU1MSwiZXhwIjoxNzAxMjEzMDU1MSwiaXNzIjoicXBXaGl0ZWxhYmVsTWlkZGxlbGF5ZXIifQ.hDtVNi65nk_LZKdNGH9Flqqwwy8NBoDwTrsji09tH-M"
        ]
        
        Alamofire.request(.GET, "https://staging.shoop.fr/api/pages/home", headers: headers)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseJSON { response in
                switch response.result {
                case .Success:
                    
                    let json = JSON(response.result.value!)
                    
                    if json["deals"].exists() {  //TODO better vaidation
                       promise.success(factory.make(json["deals"]))
                    }
                    else{
                        promise.failure(CustomError(code:1,description: "Couldn't deserialise the response"))
                    }
                    
                    
                    print("Validation Successful")
                case .Failure(let error):
                    print(error)
                     promise.failure(CustomError(code:2,description: "Http Request failed: \(error.localizedDescription)"))
                }
            }
        
        
        return promise.future
    }
}