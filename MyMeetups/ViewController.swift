//
//  ViewController.swift
//  MyMeetups
//
//  Created by Austins Work on 9/28/16.
//  Copyright © 2016 AustinsIronYard. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var store = CityStore()
    
    //Pushes Button and calls fetchCities
    @IBAction func actionButton(_ sender: AnyObject) {
        store.fetchCities() {
            (CityResult) -> Void in
            
            switch CityResult {
            case let .success(CityResult):
                print("Successfully found \(CityResult.count) cities.")
                for city in CityResult{
                    print(city.name, city.state)
                }
                
            case let .failure(error):
                print("Error fetching cities: \(error)")
            }
            
        }
    }
    
    
}

