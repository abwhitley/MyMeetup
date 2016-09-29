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

    @IBAction func actionButton(_ sender: AnyObject) {
        store.fetchCities() {
            (citiesResult) -> Void in
            
            switch citiesResult {
            case let .success(CityResult):
                print("Successfully found \(CityResult.count) cities.")
                
            case let .failure(error):
                print("Error fetching cities: \(error)")
            }
            
        }
    }


}

