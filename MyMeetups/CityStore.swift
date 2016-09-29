//
//  CityStore.swift
//  MyMeetups
//
//  Created by Austins Work on 9/28/16.
//  Copyright © 2016 AustinsIronYard. All rights reserved.
//

import UIKit
import CoreData

class CityStore {
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration:config)
    }()
    
    func processCityRequest(data: Data?, error: NSError?) -> CityResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        
        return MeetupAPI.citiesFromJSONData(jsonData)
    }
    
    
    
    func fetchCities(completion: @escaping (CityResult) -> Void) {
        let api = MeetupAPI()
        let url = api.meetUpURL(method:Method.Cities)
        let request = URLRequest(url: url as URL)
        let task = session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            
            let result = self.processCityRequest(data: data, error: error as NSError?)
            completion(result)
        })
        task.resume()
    }
}
