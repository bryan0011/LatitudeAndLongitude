//
//  ViewController.swift
//  LatitudeAndLongitude
//
//  Created by Bryan Kuo on 2021/8/26.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dLatitude0: UITextField!
    @IBOutlet weak var dLongitude0: UITextField!
    
    @IBOutlet weak var dLatitude1: UITextField!
    @IBOutlet weak var dLongitude1: UITextField!
    @IBOutlet weak var mLatitude1: UITextField!
    @IBOutlet weak var mLongitude1: UITextField!
    
    @IBOutlet weak var dLatitude2: UITextField!
    @IBOutlet weak var dLongitude2: UITextField!
    @IBOutlet weak var mLatitude2: UITextField!
    @IBOutlet weak var mLongitude2: UITextField!
    @IBOutlet weak var sLatitude2: UITextField!
    @IBOutlet weak var sLongitude2: UITextField!
    

    @IBOutlet weak var placeLocation: UITextField!
    
    @IBOutlet weak var mapView: MKMapView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        24.051225, 120.436514
        
    }
    @IBAction func resetButton(_ sender: Any) {
        
        dLatitude0.text = ""
        dLatitude1.text = ""
        dLatitude2.text = ""
        
        dLongitude0.text = ""
        dLongitude1.text = ""
        dLongitude2.text = ""
    
        mLatitude1.text = ""
        mLongitude1.text = ""
        mLatitude2.text = ""
        mLongitude2.text = ""
        
        sLatitude2.text = ""
        sLongitude2.text = ""
        
        placeLocation.text = ""
        
        
    }
    
    @IBAction func degreeChange(_ sender: UIButton) {
        
        view.endEditing(true)
        
        
        if let dLatitude0Double = Double(dLatitude0.text!),
            let dLongitude0Double = Double(dLongitude0.text!) {
            
            let dLatitude0Int = floor(dLatitude0Double)
            let dLongitude0Int = floor(dLongitude0Double)
            
            
            dLatitude1.text = String(format: "%.0f", dLatitude0Int)
            dLongitude1.text = String(format: "%.0f", dLongitude0Int)
            dLatitude2.text = String(format: "%.0f", dLatitude0Int)
            dLongitude2.text = String(format: "%.0f", dLongitude0Int)
            
            let dLatitudeChangeMinutes = (dLatitude0Double - dLatitude0Int) * 60
            let dLongitudeChangeMinutes = (dLongitude0Double - dLongitude0Int) * 60
            
            
            mLatitude1.text = String(format: "%.4f", dLatitudeChangeMinutes)
            mLongitude1.text = String(format: "%.4f", dLongitudeChangeMinutes)
            mLatitude2.text = String(format: "%.0f", floor(dLatitudeChangeMinutes))
            mLongitude2.text = String(format: "%.0f", floor(dLongitudeChangeMinutes))
            
            let dLatitudeChangeSeconds = (dLatitudeChangeMinutes - floor(dLatitudeChangeMinutes)) * 60
            let dLongitudeChangeSeconds = (dLongitudeChangeMinutes - floor(dLongitudeChangeMinutes)) * 60
            
            sLatitude2.text = String(format: "%.2f", dLatitudeChangeSeconds)
            sLongitude2.text = String(format: "%.2f", dLongitudeChangeSeconds)
            
            map(latitude: dLatitude0Double, Longitude: dLongitude0Double)
            
            
        } else {
            dLatitude0.text = "請輸入緯度"
            dLongitude0.text = "請輸入緯度"
        }
    }
    
    @IBAction func minutesChange(_ sender: UIButton) {
        if let dLatitude1Double = Double(dLatitude1.text!),
           let dLongitude1Double = Double(dLongitude1.text!),
           let mLatitude1Double = Double(mLatitude1.text!),
           let mLongitude1Double = Double(mLongitude1.text!) {
           
            let dLatitude1Int = floor(dLatitude1Double)
            let dLongitude1Int = floor(dLongitude1Double)
            let mLatitude1Int = floor(mLatitude1Double)
            let mLongitude1Int = floor(mLongitude1Double)
            
            let mLatitudeChangeDegree = dLatitude1Int + mLatitude1Double / 60
            let mLongitudeChangeDegree = dLongitude1Int + mLongitude1Double / 60
            let mLatitudeChangeSecond = ( mLatitude1Double - mLatitude1Int ) * 60
            let mLongitudeChangeSecond = ( mLongitude1Double - mLongitude1Int ) * 60
            
            dLatitude0.text = String(format: "%.6f", mLatitudeChangeDegree)
            dLongitude0.text = String(format: "%.6f", mLongitudeChangeDegree)
            dLatitude1.text = String(format: "%.0f", dLatitude1Int)
            dLongitude1.text = String(format: "%.0f", dLongitude1Int)
            dLatitude2.text = String(format: "%.0f", dLatitude1Int)
            dLongitude2.text = String(format: "%.0f", dLongitude1Int)
            mLatitude2.text = String(format: "%.0f", mLatitude1Int)
            mLongitude2.text = String(format: "%.0f", mLongitude1Int)
            sLatitude2.text = String(format: "%.2f", mLatitudeChangeSecond)
            sLongitude2.text = String(format: "%.2f", mLongitudeChangeSecond)
            
            map(latitude: mLatitudeChangeDegree, Longitude: mLongitudeChangeDegree)
            
        } else {
            dLatitude1.text = "請輸入"
            dLongitude1.text = "請輸入"
            mLatitude1.text = "請輸入"
            mLongitude1.text = "請輸入"
        }
    }

    
    @IBAction func secondsChange(_ sender: UIButton) {
        
        if let dLatitude2Double = Double(dLatitude2.text!),
           let dLongitude2Double = Double(dLongitude2.text!),
           let mLatitude2Double = Double(mLatitude2.text!),
           let mLongitude2Double = Double(mLongitude2.text!),
           let sLatitude2Double = Double(sLatitude2.text!),
           let sLongitude2Double = Double(sLongitude2.text!) {
           
            let dLatitude2Int = floor(dLatitude2Double)
            let dLongitude2Int = floor(dLongitude2Double)
            let mLatitude2Int = floor(mLatitude2Double)
            let mLongitude2Int = floor(mLongitude2Double)
            
            let sLatitudeChangeMinutes = mLatitude2Int + sLatitude2Double / 60
            let sLongitudeChangeMinutes = mLongitude2Int + sLongitude2Double / 60
            let sLatitudeChangeDegree = dLatitude2Int + sLatitudeChangeMinutes / 60
            let sLongitudeChangeDegree = dLongitude2Int + sLongitudeChangeMinutes / 60
            
            dLatitude2.text = String(format: "%.0f", dLatitude2Int)
            dLongitude2.text = String(format: "%.0f", dLongitude2Int)
            mLatitude2.text = String(format: "%.0f", mLatitude2Int)
            mLongitude2.text = String(format: "%.0f", mLongitude2Int)
            sLatitude2.text = String(format: "%.2f", sLatitude2Double)
            sLongitude2.text = String(format: "%.2f", sLongitude2Double)
            
            dLatitude1.text = String(format: "%.0f", dLatitude2Int)
            dLongitude1.text = String(format: "%.0f", dLongitude2Int)
            mLatitude1.text = String(format: "%.4f", sLatitudeChangeMinutes)
            mLongitude1.text = String(format: "%.4f", sLongitudeChangeMinutes)
            
            dLatitude0.text = String(format: "%.6f", sLatitudeChangeDegree)
            dLongitude0.text = String(format: "%.6f", sLongitudeChangeDegree)
            
            map(latitude: sLatitudeChangeDegree, Longitude: sLongitudeChangeDegree)
            
        } else {
            dLatitude2.text = "input"
            dLongitude2.text = "input"
            mLatitude2.text = "input"
            mLongitude2.text = "input"
            sLatitude2.text = "input"
            sLongitude2.text = "input"
        }
        
    }
    
    @IBAction func putMark(_ sender: UIButton) {
        
        if let dLatitude0Double = Double(dLatitude0.text!),
           let dLongitude0Double = Double(dLongitude0.text!) {
        
        let putPin = MKPointAnnotation()
        putPin.title = placeLocation.text!
        putPin.coordinate = CLLocationCoordinate2D(latitude: dLatitude0Double, longitude: dLongitude0Double)
        mapView.addAnnotation(putPin)
        
        } else {
            dLatitude0.text = "請輸入緯度"
            dLongitude0.text = "請輸入緯度"
        }
    }
    
    func map(latitude: Double, Longitude: Double) {
        mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: Longitude), latitudinalMeters: 1000, longitudinalMeters: 1000)
    }
}
