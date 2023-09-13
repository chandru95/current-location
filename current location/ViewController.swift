//
//  ViewController.swift
//  current location
//
//  Created by Admin on 13/09/23.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate{
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var lat: UILabel!
    
    @IBOutlet weak var long: UILabel!
    //    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let url = URL(string: "https://avatars.githubusercontent.com/u/513560?v=4")!
        
        if let data = try? Data(contentsOf: url){
            
            imageView.image = UIImage(data: data)
            
            
        }
        
        //        locationManager.delegate = self
        //
        //        locationManager.requestAlwaysAuthorization()
        //
        //        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
            
        }
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        //        var lat = locations.last?.coordinate.latitude
        //        var lon = locations.last?.coordinate.longitude
        //        getLocationName(lat: lat!, long: lon!)
        //
        //    }
        //
        //        func getLocationName(lat:Double,long:Double) {
        //
        //        let location = CLLocation(latitude: lat, longitude: long)
        //
        //        geocoder.reverseGeocodeLocation(location) { (placemarks,error) in
        //
        //            if let error = error {
        //                print("Reverse gecoding failed with error: \(error.localizedDescription)")
        //                return
        //            }
        //
        //            var addressName = ""
        //
        //            if let placemark = placemarks?.first {
        //
        //                if let name = placemark.name {
        //                    print("Name: \(name)")
        //
        //                    addressName = addressName + name
        //                }
        //
        //                if let street = placemark.thoroughfare {
        //                    print("Street: \(street)")
        //
        //                }
        //
        //                if let street = placemark.subLocality {
        //                    print("Street: \(street)")
        //
        //                    addressName = addressName + ", " + street
        //                }
        //
        //                if let city = placemark.locality {
        //                    print("City: \(city)")
        //                    addressName = addressName + ", " + city
        //                }
        //
        //                if let postalCode = placemark.postalCode {
        //                    print("Postal Code: \(postalCode)")
        //                    addressName = addressName + " - " + postalCode
        //                }
        //
        //                if let country = placemark.country {
        //                    print("Country: \(country)")
        //
        //                }
        //
        //                self.labelAdd.text = "\(placemark.locality!), \(placemark.postalcode!), \(placemark.country!)"
        //
        //
        //            } else {
        //                print("No placemark found.")
        //            }
        //        }
        //    }
        //}
        let userLocation :CLLocation = locations[0] as CLLocation
        
        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        
        self.lat.text = "\(userLocation.coordinate.latitude)"
        self.long.text = "\(userLocation.coordinate.longitude)"
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }
            let placemark = placemarks! as [CLPlacemark]
            if placemark.count>0{
                let placemark = placemarks![0]
                print(placemark.locality!)
                print(placemark.administrativeArea!)
                print(placemark.country!)
                
                self.location.text = "\(placemark.locality!), \(placemark.administrativeArea!), \(placemark.country!)"
            }
        }
        
    }
}


