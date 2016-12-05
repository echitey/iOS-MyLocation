//
//  ViewController.swift
//  My Location
//
//  Created by Yawo Echitey on 12/5/16.
//  Copyright © 2016 Echitey. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var courseLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var altitudeLabel: UILabel!
    @IBOutlet weak var addressLAbel: UILabel!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations[0])
        
        let userLocation: CLLocation = locations[0]
        
        latitudeLabel.text = String(userLocation.coordinate.latitude)
        longitudeLabel.text = String(userLocation.coordinate.longitude)
        courseLabel.text = String(userLocation.course)
        speedLabel.text = String(userLocation.speed)
        altitudeLabel.text = String(userLocation.altitude)
        
        //Getting Address
        CLGeocoder().reverseGeocodeLocation(userLocation){(placemarks, error) in
            print("GEtting Address")
            if error != nil{
                self.addressLAbel.text = "Failed to get Address"
            }else{
                if let placemark = placemarks?[0]{
                    print(placemark)
                    var address = ""
                    
                    if placemark.subThoroughfare != nil{
                        address += placemark.subThoroughfare! + "\n"
                    }
                    
                    if placemark.thoroughfare != nil{
                        address += placemark.thoroughfare! + "\n"
                    }
                    
                    if placemark.subLocality != nil{
                        address += placemark.subLocality! + "\n"
                    }
                    
                    if placemark.locality != nil{
                        address += placemark.locality! + "\n"
                    }
                    
                    if placemark.administrativeArea != nil{
                        address += placemark.administrativeArea! + "\n"
                    }
                    
                    if placemark.postalCode != nil{
                        address += placemark.postalCode! + "\n"
                    }
                    
                    if placemark.country != nil{
                        address += placemark.country! + "\n"
                    }
                    
                    self.addressLAbel.text = address
                    
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

