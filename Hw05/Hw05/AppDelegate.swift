//
//  AppDelegate.swift
//  Hw05
//
//  Created by YuKai Lee on 2020/6/3.
//  Copyright © 2020 leeyk. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    let dataURL = "https://quality.data.gov.tw/dq_download_json.php?nid=7052&md5_url=40a9115042bcbc0c3deb0e171d27fc0a"
    var myLocationManager: CLLocationManager!
    var myUserDefaults: UserDefaults!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // 取得儲存的預設資料
        self.myUserDefaults = UserDefaults.standard
        
        // 建立一個 CLLocationManager
        myLocationManager = CLLocationManager()
        myLocationManager.delegate = self
        myLocationManager.distanceFilter = kCLLocationAccuracyHundredMeters
        myLocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        
        // 首次使用 向使用者詢問定位自身位置權限
        if CLLocationManager.authorizationStatus() == .notDetermined {
            // 取得定位服務授權
            myLocationManager.requestWhenInUseAuthorization()
            
            // 設定後的動作請至委任方法
            // func locationManager(
            //   manager: CLLocationManager,
            //   didChangeAuthorizationStatus status: CLAuthorizationStatus)
            // 設置
        } else if (CLLocationManager.authorizationStatus() == .denied) {
            // 設置定位權限的紀錄
            self.myUserDefaults.set(false, forKey: "locationAuth")

            self.myUserDefaults.synchronize()
        } else if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse) {
            // 設置定位權限的紀錄
            self.myUserDefaults.set(true, forKey: "locationAuth")
            
            // 更新記錄的座標
            self.myUserDefaults.set(0.0, forKey: "Latitude")
            self.myUserDefaults.set(0.0, forKey: "Longitude")
            
            self.myUserDefaults.synchronize()
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

