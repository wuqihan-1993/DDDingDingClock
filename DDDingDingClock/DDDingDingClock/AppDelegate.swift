//
//  AppDelegate.swift
//  DDDingDingClock
//
//  Created by wuqh on 2019/1/4.
//  Copyright © 2019 wuqh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = UINavigationController(rootViewController: MainViewController())
        window?.makeKeyAndVisible()
        
        RCIMClient.shared()?.initWithAppKey("vnroth0kvbffo")
        DTOpenAPI.registerApp("dingoapxdbrrp1w3gpqguu")
        return true
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return DTOpenAPI.handleOpen(url, delegate: self)
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

