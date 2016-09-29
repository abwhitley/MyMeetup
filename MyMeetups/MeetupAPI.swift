//
//  MeetupAPI.swift
//  MyMeetups
//
//  Created by Austins Work on 9/28/16.
//  Copyright © 2016 AustinsIronYard. All rights reserved.
//

import Foundation
import CoreData

enum Method: String {
    case Cities = "/2/cities?only=city,state&page=10"
}

enum CityResult {
    case success([City])
    case failure(Error)
}

enum MeetupError: Error {
    case invalidJSONData
}

struct MeetupAPIConfiguration {
    let apiKey: String
    let baseURL: String
    
    init() {
        let bundle = Bundle.main
        guard let plistURL = bundle.url(forResource: "MeetupConfig", withExtension: "plist"), let plistData = try? Data.init(contentsOf: plistURL), let plistAny = try? PropertyListSerialization.propertyList(from: plistData, options: [], format: nil), let plist = plistAny as? [String: Any] else {
            fatalError("Could not load MeetupConfig.plist")
        }
        
        self.apiKey = plist["APIKey"] as! String
        self.baseURL = plist["BaseURL"] as! String
    }
    
}

class MeetupAPI {
    
    static let config = MeetupAPIConfiguration()
    let baseURL = config.baseURL
    
    func meetUpURL(method: Method) -> URL {
        let components = URLComponents(string: baseURL.appending(Method.Cities.rawValue))!
        return components.url!
        
    }
    
    class func citiesFromJSONData(_ data: Data) -> CityResult {
        
        do {
            let jsonObject: Any = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard let
                jsonDictionary = jsonObject as? [String: AnyObject],
                let citiesArray = jsonDictionary["results"] as? [[String:AnyObject]] else{
                    //
                    //                    // The JSON structure doesn't match our expectations
                    return .failure(MeetupError.invalidJSONData)
            }
            //
            var finalCities = [City]()
                        for cityJSON in citiesArray {
                            if let city = cityFromJSONObject(cityJSON) {
                                finalCities.append(city)
                            }
                        }
            
                        if finalCities.count == 0 && citiesArray.count > 0 {
                            // We weren't able to parse any of the photos.
                            // Maybe the JSON format for photos has changed.
                            return .failure(MeetupError.invalidJSONData)
                        }
            return .success(finalCities)
        }
        catch let error {
            return .failure(error)
        }
    }
    
//     class func cityFromJSONObject(_ json: [String : AnyObject]) -> City? {
//        guard let
//            name = json["city"] as? String else{
//        
//                // Don't have enough information to construct a Photo
//                return nil
//        }
//        
//        return City(name: name)
//    }

    
    
}
    
