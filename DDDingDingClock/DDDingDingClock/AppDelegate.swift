//
//  AppDelegate.swift
//  DDDingDingClock
//
//  Created by wuqh on 2019/1/4.
//  Copyright © 2019 wuqh. All rights reserved.
//

import UIKit

let HomeToken = "YiA05Wb06cLqp+Hk0SxcmcxLFy44qvJmbbEHga/UUOKJ6FalfhCiPo9sgToSE9tmqg/zLR84H4Da8ulYbbtixA=="
let CompanyToken = "kWHW85VChkCO/6B+Gk4hfcxLFy44qvJmbbEHga/UUOKJ6FalfhCiPk3IriBzEZndqg/zLR84H4DCAaVhypMJ1A=="


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        UIApplication.shared.isIdleTimerDisabled = true

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = TabBarViewController()
        window?.makeKeyAndVisible()

        RCIMClient.shared()?.initWithAppKey("vnroth0kvbffo")
        
        return true
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return DTOpenAPI.handleOpen(url, delegate: self)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        RCIMClient.shared()?.logout()
    }

}
extension AppDelegate: DTOpenAPIDelegate {
    func onResp(_ resp: DTBaseResp!) {
        if resp.errorCode == DTOpenAPIErrorCode.success {
            print("分享成功")
        }else {
            print("分享失败")
        }
    }
}

