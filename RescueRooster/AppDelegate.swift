//
//  AppDelegate.swift
//  RescueRooster
//
//  Created by Роман Главацкий on 02.09.2025.
//

import UIKit
import OneSignalFramework
import AppsFlyerLib

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var restrictRotation: UIInterfaceOrientationMask = .all

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // AppsFlyer Init
           AppsFlyerLib.shared().appsFlyerDevKey = "vJMMAWQd8UYfQXhKT3sUNA"
           AppsFlyerLib.shared().appleAppID = "6752285914"
           AppsFlyerLib.shared().delegate = self
           AppsFlyerLib.shared().isDebug = true
           
        AppsFlyerLib.shared().start()
        let appsFlyerId = AppsFlyerLib.shared().getAppsFlyerUID()
        
        
        //MARK: - One signal
        OneSignal.initialize("a19d014d-16f2-4b46-8d71-98f48e207335", withLaunchOptions: nil)
        OneSignal.login(appsFlyerId)
        
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

extension AppDelegate: AppsFlyerLibDelegate {
    func onConversionDataSuccess(_ conversionInfo: [AnyHashable: Any]) {
        guard let data = conversionInfo as? [String: Any] else {
            print("⚠️ Failed to convert conversionInfo to [String: Any]")
            return
        }
        
        print("📦 AppsFlyer raw data received: \(data)")
        
        // Получаем AppsFlyer ID
        let appsflyerID = AppsFlyerLib.shared().getAppsFlyerUID()
        
        // Создаём базовый словарь параметров
        var queryParams = [String: String]()
        
        // Добавляем AppsFlyer ID
        queryParams["appsflyer_id"] = appsflyerID
        
        // Обрабатываем все входящие параметры
        for (key, value) in data {
            // Преобразуем значение в строку
            let stringValue: String
            
            if let str = value as? String {
                stringValue = str
            } else if let num = value as? NSNumber {
                stringValue = num.stringValue
            } else if let boolVal = value as? Bool {
                stringValue = boolVal ? "true" : "false"
            } else {
                stringValue = "\(value)"
            }
            
            // Добавляем в параметры, исключая пустые значения
            if !stringValue.isEmpty {
                queryParams[key] = stringValue
            }
        }
        
        // Специальная обработка для кампании (как в оригинальном коде)
        if let afStatus = queryParams["af_status"]?.lowercased(), afStatus == "organic" {
            queryParams["campaign"] = "organic"
        } else if let campaign = queryParams["campaign"] {
            let parts = campaign.components(separatedBy: "_")
            if !parts.isEmpty {
                queryParams["campaign"] = parts[0]
                for (index, part) in parts.enumerated() where index > 0 && index <= 6 {
                    queryParams["sub\(index)"] = part
                }
            }
        }
        
        // Строим URL строку
        let queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
        var urlComponents = URLComponents()
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url?.absoluteString else {
            print("⚠️ Failed to construct final URL")
            return
        }
        
        print("✅ Final URL: \(finalURL)")
        UserDefaults.standard.set(finalURL, forKey: "finalAppsflyerURL")
        NotificationCenter.default.post(name: Notification.Name("AppsFlyerDataReceived"), object: nil)
    }

    func onConversionDataFail(_ error: Error) {
        print("❌ Conversion data error: \(error.localizedDescription)")
    }
}
