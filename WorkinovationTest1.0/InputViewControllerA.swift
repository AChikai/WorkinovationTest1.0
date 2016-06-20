//
//  InputViewControllerA.swift
//  WorkinovationTest1.0
//
//  Created by Akio Chikai on 2016/06/02.
//  Copyright © 2016年 Akio Chikai. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class InputViewControllerA: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var workSwitchLabel: UILabel!
    @IBOutlet weak var workButton: UIButton!
    
    @IBOutlet weak var testLabel: UILabel!
    
    var locationManager = CLLocationManager()
    var myPosition = CLLocationCoordinate2D()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        //locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let locCoord = CLLocationCoordinate2D()
        let annotation = MKPointAnnotation()
        annotation.coordinate = locCoord
        annotation.title = ""
        annotation.subtitle = ""
        
        mapView.addAnnotation(annotation)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        
        myPosition = newLocation.coordinate
        
        print("Got Location \(newLocation.coordinate.latitude) , \(newLocation.coordinate.longitude)")
        
        testLabel.text = " \(newLocation.coordinate.latitude) , \(newLocation.coordinate.longitude)"
        
        let span = MKCoordinateSpanMake(0.005, 0.005)
        let region = MKCoordinateRegion(center: newLocation.coordinate, span: span)
        mapView.setRegion(region, animated: false)
    
    }
    
    func locationManager(manager: CLLocationManager, didchangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.NotDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else if status == CLAuthorizationStatus.AuthorizedAlways {
            let span = MKCoordinateSpanMake(0.1, 0.1)
            var region = MKCoordinateRegionMake(mapView.userLocation.coordinate, span)
            mapView.setRegion(region, animated: true)
            mapView.userTrackingMode = MKUserTrackingMode.Follow
            region.span.latitudeDelta = 0.1
            region.span.longitudeDelta = 0.1
            
        }
    }
    
    @IBAction func workStartButton(sender: AnyObject) {
        locationManager.startUpdatingLocation()
    }
    
}
