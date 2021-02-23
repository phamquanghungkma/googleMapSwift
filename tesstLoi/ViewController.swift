//
//  ViewController.swift
//  tesstLoi
//
//  Created by Apple on 2/21/21.
//  Copyright © 2021 Tofu. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation
import DropDown

class ViewController: UIViewController,GMSMapViewDelegate {
    @IBOutlet weak var radiusCirle: UIButton!
    let locationManager = CLLocationManager()
    
    let chooseDropDown = DropDown()
    lazy var dropDowns: [DropDown] = {
        return [
        
            self.chooseDropDown,
            
        ]
    }()
    var circle = GMSCircle()
    let cardMakers = [
        CardMarkerModel(name:"card 1",lat: 21.54602811848569, long: 105.87091371417046),
        CardMarkerModel(name:"card 2",lat: 21.546733205064346, long:  105.87919637560844),
        CardMarkerModel(name:"card 3",lat:  21.54294110245911, long:  105.87337397038937),
        CardMarkerModel(name:"card 4",lat:  21.541916656425027, long:  105.87982602417469),
        CardMarkerModel(name:"be boi Huong Son", lat: 21.543898804829695, long: 105.87590128183365),
        CardMarkerModel(name: "Trung Thanh School", lat: 21.540986, long: 105.867460),
        CardMarkerModel(name:"Ha Can Steel ", lat: 21.527205, long: 105.867396)
    ]
 
    @IBOutlet weak var mapView: GMSMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        print("Call ViewDidLoad")
        getCurrentLocation()
        setUpMapView()
        setUpDropDown()
        dropDowns.forEach { $0.dismissMode = .onTap }
            dropDowns.forEach { $0.direction = .any }
        
        
        let  currentLocation = CLLocation(latitude: 21.546231, longitude: 105.877081)
        let marker4 = CLLocation(latitude: 21.541916656425027, longitude: 105.87982602417469)
        let marker3 = CLLocation(latitude: 21.543898804829695 , longitude: 105.87590128183365)
        let distanceInMeters4 =  currentLocation.distance(from: marker4)
        let distanceInMeters3 = currentLocation.distance(from: marker3)
         print("double to Int \(Int(555.928620066711))")
       

    }
    @IBAction func didSelectRadius(_ sender: Any) {
            chooseDropDown.show()
    }
    func setupDefaultDropDown() {
        DropDown.setupDefaultAppearance()
        
        dropDowns.forEach {
            $0.cellNib = UINib(nibName: "DropDownCell", bundle: Bundle(for: DropDownCell.self))
            $0.customCellConfiguration = nil
        }
    }
    
    
    func setUpRadiusCirleButton(){
        self.radiusCirle.backgroundColor = UIColor(white: 1, alpha: 1)
        self.radiusCirle.layer.cornerRadius = 5
        self.radiusCirle.titleLabel?.text = "500m"
     
    }
    func updateCircle(value: Int){
        DispatchQueue.main.async {
            self.circle.radius = CLLocationDistance(value)
            let update = GMSCameraUpdate.fit(self.circle.bounds())
            self.mapView.animate(with: update)
            self.circle.map = self.mapView
        }
    }
    
    func calculDitance(radiusCircle: Int){
        let devicePoint = CLLocation(latitude: 21.546231, longitude: 105.877081)
        for item in cardMakers {
            let destiLocation = CLLocation(latitude: item.lat, longitude: item.long)
            let distance =  devicePoint.distance(from: destiLocation)
            let distanceInt = Int(distance)
            print("disCal ",distanceInt)
             let cardMarker = GMSMarker()
            if (distanceInt < radiusCircle) {
                print("Vi tri \(item.name) cach diem dau \(distanceInt) => nam trong ban kinh \(radiusCircle)")
                    let location = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                cardMarker.position =  CLLocationCoordinate2D(latitude: item.lat, longitude: item.long )
                cardMarker.title = item.name
                cardMarker.snippet = "Traphaco Joinstock Company"
                cardMarker.map = mapView
            } else if(distanceInt < radiusCircle) {
                mapView.clear()

            }
            
            
        }
        
    }

//    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
//            print("Call didTapAt")
//         self.mapView.clear()
//        print("Toa do nha :",coordinate)
//        self.pickMarker(coordinate: coordinate)
//
//
//    }
//    func pickMarker(coordinate: CLLocationCoordinate2D) {
//            print("Call addMaker")
//        let marker = GMSMarker()
//        marker.position = coordinate
//        let markerImage = UIImage(named: "icon_offer_pickup")!
//        let markerView = UIImageView(image: markerImage)
//        marker.iconView = markerView
//        marker.map = self.mapView
//    }
    func setUpDropDown(){
        setUpRadiusCirleButton()
        setupChooseDropDown()
    }
    func setupChooseDropDown() {
        chooseDropDown.anchorView = radiusCirle
        chooseDropDown.bottomOffset = CGPoint(x: 0, y: radiusCirle.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        chooseDropDown.dataSource = [
            " 500m ",
            " 1km ",
            " 2km "
        ]
        
        // Action triggered on selection
        chooseDropDown.selectionAction = { [weak self] (index, item) in
            self?.radiusCirle.setTitle(item, for: .normal)
           

            var valuesRadius: Int?
            if(item == " 500m "){
                self?.updateCircle(value: 500)
                self?.mapView.clear()
                self!.calculDitance(radiusCircle:500)
            }
            else if (item == " 1km "){
                self?.updateCircle(value: 1000)
                self?.mapView.clear()
                self!.calculDitance(radiusCircle:1000)
            }
            else if (item == " 2km "){
                self?.updateCircle(value: 2000)
                self?.mapView.clear()
                self!.calculDitance(radiusCircle:2000)

            }
            
            
            
            print("choosen item is :\(item)")
            
            
        }
    }
    func setUpMapView(){
        mapView.delegate = self
        mapView.settings.compassButton = true
    }

    func getCurrentLocation() {
          // Ask for Authorisation from the User.
          self.locationManager.requestAlwaysAuthorization()

          // For use in foreground
          self.locationManager.requestWhenInUseAuthorization()

          if CLLocationManager.locationServicesEnabled() {
              locationManager.delegate = self
              locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
              locationManager.startUpdatingLocation()
          }
      }


}
extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return
        }
        locationManager.startUpdatingLocation()
        
        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true

    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        executes when the location manager receives new location data.
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
    
       
        let circleCenter = CLLocationCoordinate2DMake(locValue.latitude, locValue.longitude)
        circle.position = circleCenter
        circle.fillColor = UIColor(red: 0.35, green: 0, blue: 0, alpha: 0.05)
        circle.strokeColor = UIColor.red
        circle.strokeWidth = 1
        circle.map = mapView
        circle.radius = CLLocationDistance(500)
//        for item in cardMakers {
//        let cardMarker = GMSMarker()
//            let location = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
//        cardMarker.position =  CLLocationCoordinate2D(latitude: item.lat, longitude: item.long )
//        cardMarker.title = item.name
//        cardMarker.snippet = "Traphaco Joinstock Company"
//        cardMarker.map = mapView
//
//        }
        calculDitance(radiusCircle: 500)
                self.mapView.camera = GMSCameraPosition(
                    target: locValue,
                    zoom: 15,
                    bearing: 0,
                    viewingAngle: 0)
        
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        locationManager.stopUpdatingLocation()
        
       
    }
}
//extension ViewController: GMSAutocompleteViewControllerDelegate {
//    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
//       print("Call didAutoCompletewith")
//       dismiss(animated: true, completion: nil)
//
//       self.mapView.clear()
////       self.txtSearch.text = place.name
//
//       /*
//       let placeGmap = GoogleMapObjects()
//       placeGmap.lat = place.coordinate.latitude
//       placeGmap.long = place.coordinate.longitude
//       placeGmap.address = place.name*/
//
//       //self.delegate?.getThePlaceAddress(vc: self, place: placeGmap, tag: self.FieldTag)
//
//       let cord2D = CLLocationCoordinate2D(latitude: (place.coordinate.latitude), longitude: (place.coordinate.longitude))
//
//       let marker = GMSMarker()
//       marker.position =  cord2D
//       marker.title = "Location"
//       marker.snippet = place.name
//
//       let markerImage = UIImage(named: "icon_offer_pickup")!
//       let markerView = UIImageView(image: markerImage)
//       marker.iconView = markerView
//       marker.map = self.mapView
//
//        // khi vào map màn hình sẽ show ra toạ độ hiện tại luôn
//       self.mapView.camera = GMSCameraPosition.camera(withTarget: cord2D, zoom: 30)
//
//
//
//    }
//
//    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
//        print(error.localizedDescription)
//    }
//
//    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
//
//    }
//
//
//}



