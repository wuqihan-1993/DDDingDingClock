//
//  TabBarViewController.swift
//  DDDingDingClock
//
//  Created by wuqh on 2019/1/4.
//  Copyright © 2019 wuqh. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let manualClockVc = ManualClockViewController()
        manualClockVc.title = "手动打卡"
        addChild(UINavigationController(rootViewController: manualClockVc))
        
        let autoClockVc = AutoClockViewController()
        autoClockVc.title = "自动打卡"
        addChild(UINavigationController(rootViewController: autoClockVc))
        
        let recordClockVc = RecordClockViewController()
        recordClockVc.title = "打卡记录"
        addChild(UINavigationController(rootViewController: recordClockVc))
        
        
    }

}
