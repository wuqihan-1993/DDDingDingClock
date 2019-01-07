//
//  HomeClockViewController.swift
//  DDDingDingClock
//
//  Created by wuqh on 2019/1/4.
//  Copyright © 2019 wuqh. All rights reserved.
//

import UIKit
import SnapKit
class HomeClockViewController: UIViewController {
    
    private lazy var clockButton: UIButton = {
        let clockButton = UIButton(type: .custom)
        clockButton.setTitle("现在就立即打卡~", for: .normal)
        clockButton.addTarget(self, action: #selector(clockButtonClick), for: .touchUpInside)
        clockButton.setTitleColor(UIColor.red, for: .normal)
        return clockButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        title = "立即打卡"
        view.addSubview(clockButton)
        clockButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }
    
    @objc private func clockButtonClick() {
        let message = RCTextMessage(content: "打卡喽")
        RCIMClient.shared()?.sendMessage(.ConversationType_PRIVATE, targetId: "test", content: message, pushContent: nil, pushData: nil, success: { (messageId) in
            print("打卡成功喽")
        }, error: { (errorCode, messageId) in
            print("打卡失败了")
        })
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
