//
//  MapPin.swift
//  ChicagoLibrary
//
//  Created by karl on 2017/8/3.
//  Copyright © 2017年 butterfly. All rights reserved.
//

import MapKit

class MapPin: NSObject, MKAnnotation {
    
    var title: String?
    var subtitle: String?
    var hours: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title:String, subtitle:String, hours: String, coordinate:CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.hours = hours
        self.coordinate = coordinate
    }
}
