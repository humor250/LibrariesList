//
//  DBController.swift
//  ChicagoLibrary
//
//  Created by karl on 2017/8/3.
//  Copyright © 2017年 butterfly. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

class DBController: NSObject{

    public static let LIBRARY_ADDED_NOTIFICATION = NSNotification.Name("LIBRARY_ADDED")

    static var librariesArray:Array = Array<MapPin>()
    
    class func sharedLibraries() -> Array<Any>{
        return librariesArray
    }
    
    class func addlibrary( library:MapPin ){
        
        DBController.librariesArray.append(library)
        
        NotificationCenter.default.post(name: LIBRARY_ADDED_NOTIFICATION, object: library)
    }
    
    class func loadLibraries(){
        let NAME_KEY = "name_"
        let LOCATION_KEY = "location"
        let LATITUDE_KEY = "latitude"
        let LONGITUDE_KEY = "longitude"
        let ADDRESS_KEY = "address"
        let HOURS_OF_OPERATION = "hours_of_operation"
        let REQUEST_URL = "https://data.cityofchicago.org/resource/x8fc-8rcq.json"
        
        Alamofire.request(REQUEST_URL).responseString{ response in
            do{
                let jsonString = response.result.value!
                let jsonData = jsonString.data(using: .utf8)!
                let jsonArray = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions()) as! NSArray
                
                for(_, jsonObject) in jsonArray.enumerated(){
                    let currentLibrary:Dictionary = jsonObject as! Dictionary<String, AnyObject>
                    
                    let nameString:String = currentLibrary[NAME_KEY] as! String
                    let address: String = currentLibrary[ADDRESS_KEY] as! String
                    
                    let hoursOfOperation: String = currentLibrary[HOURS_OF_OPERATION] as! String
                    let locationDictionary:Dictionary = currentLibrary[LOCATION_KEY] as! Dictionary<String, AnyObject>
                    let latitude:Double = Double(locationDictionary[LATITUDE_KEY] as! String)!
                    let longitude:Double = Double(locationDictionary[LONGITUDE_KEY] as! String)!
                    
                    let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
                    
                    let currentMapPin: MapPin = MapPin(title: nameString, subtitle: address, hours: hoursOfOperation, coordinate: location)
                    DBController.addlibrary(library: currentMapPin)

                }
            }
            catch{
                print("error")
            }
        }
        
        print("called Alamofire")
    }
}

