//
//  ViewController.swift
//  高仿指南针
//
//  Created by 陈竹青 on 2021/4/15.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    var locationManager : CLLocationManager!
    var angelLabel : UILabel!
    var directionLabel: UILabel!
    var postionLabel : UILabel!
    var latiudlongitudeLabel : UILabel!
    var scaleView: ScaleView!
    var currentLocation: CLLocation!
    
    deinit {
        self.locationManager.stopUpdatingHeading()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
         scaleView = ScaleView(frame: CGRect(x: 0, y: 50, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width))
        
        self.view.backgroundColor = .black
        self.view.addSubview(scaleView)
        
        self.loadUI()
        self.loadLocation()
    }

    func loadLocation() -> Void {
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.distanceFilter = 0
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        self.locationManager.requestWhenInUseAuthorization()

        self.locationManager.allowsBackgroundLocationUpdates = true
        if CLLocationManager.locationServicesEnabled() && CLLocationManager.headingAvailable() {
            self.locationManager.startUpdatingLocation()
            self.locationManager.startUpdatingHeading()
        }else{
            print("不能获取导向数据")
        }
    }

}

extension ViewController {
    func loadUI() -> Void {
        self.angelLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 100, y: self.scaleView.frame.maxY + 10, width: 100, height: 100))
        self.angelLabel.font = .systemFont(ofSize: 30)
        self.angelLabel.textAlignment = .center
        self.angelLabel.textColor = .white
        self.view.addSubview(self.angelLabel)
        
        self.directionLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2, y: self.angelLabel.frame.maxY, width: 50, height: 50))
        self.directionLabel.font = .systemFont(ofSize: 15)
        self.directionLabel.textColor = .white
        self.view.addSubview(self.directionLabel)
        
    }
}

extension ViewController: CLLocationManagerDelegate{
    //获得地理和地磁航向数据，从而转动地理刻度表
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        let divece = UIDevice.current
        if newHeading.headingAccuracy>0 {
            let magneticHeading = self.heading(heanding: newHeading.magneticHeading, orientation: divece.orientation)
            let truHeading = self.heading(heanding: newHeading.trueHeading, orientation: divece.orientation)
            let heading = -1 * Double.pi * newHeading.magneticHeading / 180.0
            self.angelLabel.text = String(format: "%.2f", magneticHeading)
            self.scaleView.resetDirection(heading: CGFloat(heading))
            self.updateHeading(newHeading: newHeading)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = locations.last
        let latitudeStr = String(format: "%3.2f", self.currentLocation.coordinate.latitude)
        let longitudeStr = String(format: "%3.2f", self.currentLocation.coordinate.longitude)
        
        let altitudeStr = String(format: "%3.2f", self.currentLocation.altitude)
        
        print("维度\(latitudeStr)  经度\(longitudeStr) 高度\(altitudeStr)")
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(self.currentLocation) { (placemarks, error) in
            if let marsk = placemarks , marsk.count > 0 {
                let  placeMark : CLPlacemark = marsk[0]
                let addressDic = placeMark.locality
                print(addressDic)
           
            }
        }
        
    }
    
    func updateHeading(newHeading: CLHeading) -> Void {
        let theHeading = newHeading.magneticHeading > 0 ? newHeading.magneticHeading : newHeading.trueHeading
        switch theHeading {
        case 0:
            self.directionLabel.text = "北"
            break
        case 90:
            self.directionLabel.text = "东"
            break
        case 180:
            self.directionLabel.text = "南"
            break
        case 270:
            self.directionLabel.text = "西"
            break
        default:
            break
        }
        if theHeading > 0 && theHeading < 90 {
            self.directionLabel.text = "东北"
        }else if(theHeading > 90 && theHeading < 180){
            self.directionLabel.text = "东南"
        }else if(theHeading>180 && theHeading<270){
            self.directionLabel.text = "西南"
        }else{
            self.directionLabel.text = "西北"
        }
        
    }
    
    func heading(heanding: Double,orientation: UIDeviceOrientation) -> Double {
        var realHeading = heanding
        switch orientation {
        case .portrait:
            break
        case .portraitUpsideDown:
        realHeading = heanding - 180.0
            break
        case .landscapeLeft:
        realHeading = heanding + 90.0
        break
        case .landscapeRight:
        realHeading = heanding - 90
        default:
            break
            
        }
        if realHeading>360 {
            realHeading -= 360.0
        }
        else if (realHeading < 0.0){
            realHeading += 360
        }
        return realHeading
    }
}

