//
//  ViewController.swift
//  Hw05
//
//  Created by YuKai Lee on 2020/6/3.
//  Copyright © 2020 leeyk. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CLLocationManagerDelegate {
    
    var myUserDefaults: UserDefaults!
    var myLocationManager :CLLocationManager!
    
    @IBOutlet weak var tableView: UITableView!
    let dataURL = "https://quality.data.gov.tw/dq_download_json.php?nid=7052&md5_url=40a9115042bcbc0c3deb0e171d27fc0a"
    var funeral : [Funeral?] = [ ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return funeral.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = funeral[indexPath.row]?.name
        cell.detailTextLabel?.text = "\(funeral[indexPath.row]!.distance/1000)公里"
        return cell
    }
    
    func getData() {
        let locationAuth = myUserDefaults.object(forKey: "locationAuth") as? Bool
        
        if locationAuth != nil && locationAuth! {
            let userLatitude = myUserDefaults.object(forKey: "Latitude") as? Double
            let userLongitude = myUserDefaults.object(forKey: "Longitude") as? Double
            let userLocation = CLLocation(latitude: userLatitude!, longitude: userLongitude!)
            let settingDistance = myUserDefaults.object(forKey: "distance") as? Int ?? 10
            print(settingDistance)
            AF.request(dataURL, method: .get).responseJSON { response in
                switch response.result {
                case .success(let data):
                    self.funeral.removeAll()
                    
                    let json = JSON(data)
                    if let funerals = json.array {
                        for funeral_ in funerals {
                            if (funeral_["名稱"].stringValue != "" && funeral_["經度"].doubleValue != 0 && funeral_["緯度"].doubleValue != 0) {
                                
                                let thisDataLocation = CLLocation(latitude: funeral_["緯度"].doubleValue, longitude: funeral_["經度"].doubleValue)
                                let distance = Int(userLocation.distance(from: thisDataLocation))
                                let f = Funeral(category: funeral_["類別"].stringValue,
                                                name: funeral_["名稱"].stringValue,
                                                publicPrivate: funeral_["公私立"].stringValue,
                                                country: funeral_["縣市"].stringValue,
                                                region: funeral_["鄉鎮市區"].stringValue,
                                                address: funeral_["地址"].stringValue,
                                                longitude: funeral_["經度"].doubleValue,
                                                latitude: funeral_["緯度"].doubleValue,
                                                tel: funeral_["聯絡電話"].stringValue,
                                                jurisdiction: funeral_["管轄所屬"].stringValue,
                                                distance: Double(distance))
                                if distance <= settingDistance*1000 {
                                    self.funeral.append(f)
                                }
                            }
                        }
                    }
                    self.funeral.sort { $0!.distance < $1!.distance }
                    self.tableView.reloadData()
                    break
                case .failure(let error):
                    print("Get API Data Error: \(error)")
                    break
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.denied) {
            self.myUserDefaults.set(false, forKey: "locationAuth")
            self.myUserDefaults.synchronize()
        } else if (status == CLAuthorizationStatus.authorizedWhenInUse) {
            // 設置定位權限的紀錄
            self.myUserDefaults.set(true, forKey: "locationAuth")
            
            // 更新記錄的座標 for 取得有限數量的資料
            self.myUserDefaults.set(0.0, forKey: "Latitude")
            self.myUserDefaults.set(0.0, forKey: "Longitude")

            self.myUserDefaults.synchronize()

            // 開始定位自身位置
            myLocationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation: CLLocation = locations[0] as CLLocation
        
        self.myUserDefaults.set(currentLocation.coordinate.latitude, forKey:"Latitude")
        self.myUserDefaults.set(currentLocation.coordinate.longitude, forKey:"Longitude")
        
        self.myUserDefaults.synchronize()
        
        getData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // 取得儲存的預設資料
        self.myUserDefaults = UserDefaults.standard
        
        // 建立一個 CLLocationManager
        myLocationManager = CLLocationManager()
        myLocationManager.delegate = self
        myLocationManager.distanceFilter = kCLLocationAccuracyHundredMeters
        myLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        getData()
    }		
    
    @IBAction func reloadButton(_ sender: Any) {
        getData()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "toDetail") {
            
            let controller = segue.destination as? detailTableViewController
            
            if let row = tableView.indexPathForSelectedRow?.row {
                controller?.funeral = self.funeral[row]
            }
            
        }
        
    }
    


}

