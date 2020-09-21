//
//  MapViewController.swift
//  TestApp
//
//  Created by metoSimka on 21.09.2020.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    @IBOutlet weak var labelUserCash: UILabel!
    @IBOutlet weak var labelUserName: UILabel!
    
    @IBOutlet weak var imageUserAvatar: UIImageView!
    @IBOutlet weak var googleMapView: GMSMapView!
    
    private var userAccount: UserAccount
    
    private let locationManager = CLLocationManager()
    private let animationTime: TimeInterval = 0.2
    private let zoom: Float = 15
    
    init(userAccount: UserAccount) {
        self.userAccount = userAccount
        super.init(nibName: "MapViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        googleMapView.delegate = self
        setupMapView()
        userAccount.accountImage = parseUsersImageAvatarFromServer()
        setupAccountInfo(userAccount)
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if CLLocationManager.locationServicesEnabled() {
            gotoMyLocationAction()
        }
    }

    @IBAction func useTicket(_ sender: Any) {
        
    }
    
    @IBAction func bicycleType1Touched(_ sender: Any) {
        
    }
    
    @IBAction func bicycleType2Touched(_ sender: Any) {
        
    }
    
    @IBAction func bicycleType3Touched(_ sender: Any) {
        
    }
    
    @IBAction func lockPosition(_ sender: UIButton) {
        
    }
    
    @IBAction func openOptions(_ sender: UIButton) {
        
    }
    
    @IBAction func positionButtonTouched(_ sender: UIButton) {
        gotoMyLocationAction()
    }
    
    private func setupMapView() {
        googleMapView.clipsToBounds = true
        googleMapView.layer.cornerRadius = 10

        googleMapView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        do {
            googleMapView.mapStyle = try GMSMapStyle(jsonString: MapStyle.darkMapStyle)
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        googleMapView.isMyLocationEnabled = true
        googleMapView.settings.myLocationButton = false
    }
    
    private func setupAccountInfo(_ account: UserAccount) {
        let userName = account.firstName + " " + account.lastName
        self.labelUserName.text = userName
        
        let cash = formattCurrency(cash: account.cash)
        self.labelUserCash.text = cash
        
        self.imageUserAvatar.image = account.accountImage
    }
    
    private func gotoMyLocationAction() {
        guard let lat = self.googleMapView.myLocation?.coordinate.latitude,
              let lng = self.googleMapView.myLocation?.coordinate.longitude else {
            return
        }
        let camera = GMSCameraPosition.camera(withLatitude: lat ,longitude: lng , zoom: zoom)
        self.googleMapView.animate(to: camera)
    }
    
    private func parseUsersImageAvatarFromServer() -> UIImage? {
        return UIImage(named: "avatar")
    }
    
    private func formattCurrency(cash: Float) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "es_CL")
        formatter.numberStyle = .currency
        formatter.groupingSize = 3
        formatter.usesGroupingSeparator = true
        formatter.groupingSeparator = "."
        if let formatted = formatter.string(from: cash as NSNumber) {
            return "\(formatted)"
        } else {
            return String(cash)
        }
    }
    
    private func reverseGeocode(coordinate: CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            UIView.animate(withDuration: self.animationTime) {
                self.view.layoutIfNeeded()
            }
        }
    }
}


extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return
        }
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        googleMapView.camera = GMSCameraPosition(target: location.coordinate, zoom: 15, bearing: 0, viewingAngle: 0)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
      reverseGeocode(coordinate: position.target)
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        
    }
}
