//
//  mapViewController.swift
//  Hw05
//
//  Created by YuKai Lee on 2020/6/3.
//  Copyright © 2020 leeyk. All rights reserved.
//

import UIKit
import MapKit

class mapViewController: UIViewController {

    var funeral: Funeral?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: self.funeral?.latitude ?? 0.0, longitude: self.funeral?.longitude ?? 0.0), latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        let bigBenAnnotation = MKPointAnnotation()
        bigBenAnnotation.title = self.funeral?.name
        bigBenAnnotation.coordinate = CLLocationCoordinate2D(latitude: self.funeral?.latitude ?? 0.0, longitude: self.funeral?.longitude ?? 0.0)
        bigBenAnnotation.subtitle = self.funeral?.category
        mapView.addAnnotation(bigBenAnnotation)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
