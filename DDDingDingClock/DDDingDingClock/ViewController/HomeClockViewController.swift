//
//  HomeClockViewController.swift
//  DDDingDingClock
//
//  Created by wuqh on 2019/1/4.
//  Copyright © 2019 wuqh. All rights reserved.
//

import UIKit
import SnapKit
import NVActivityIndicatorView

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
        
        let alert = UIAlertController(title:"即将打卡", message: "请输入要接收打卡指令的userId", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .default) { (_) in
            
            guard let targetId = alert.textFields?.first?.text else{
                return
            }
            let message = RCTextMessage(content: "打卡喽")
            RCIMClient.shared()?.sendMessage(.ConversationType_PRIVATE, targetId: targetId, content: message, pushContent: nil, pushData: nil, success: { (messageId) in
                print("打卡成功喽")
            }, error: { (errorCode, messageId) in
                print("打卡失败了")
            })
            
        }
        alert.addTextField { (textfiled) in
            textfiled.placeholder = "请输入要接收打卡指令的userId"
        }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
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
