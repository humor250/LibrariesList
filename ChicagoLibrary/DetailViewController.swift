//
//  DetailViewController.swift
//  ChicagoLibrary
//
//  Created by karl on 2017/8/3.
//  Copyright © 2017年 butterfly. All rights reserved.
//

import UIKit
import MapKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var LibMapView: MKMapView!

    @IBOutlet weak var LibName: UILabel!
    
    @IBOutlet weak var LibAddress: UILabel!
    
    @IBOutlet weak var LibHours: UILabel!
    
    var currentLibrary: MapPin? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LibName?.text = currentLibrary?.title
        LibAddress?.text = currentLibrary?.subtitle
        LibHours?.text = currentLibrary?.hours
        
        let distanceSpan:CLLocationDegrees = 10000
        LibMapView.setRegion(MKCoordinateRegionMakeWithDistance((currentLibrary?.coordinate)!, distanceSpan, distanceSpan), animated: true)

        LibMapView.addAnnotation(currentLibrary!)

        }  
}


