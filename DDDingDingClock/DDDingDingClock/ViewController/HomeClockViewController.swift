//
//  HomeClockViewController.swift
//  DDDingDingClock
//
//  Created by wuqh on 2019/1/4.
//  Copyright © 2019 wuqh. All rights reserved.
//

import UIKit
import SnapKit
import SVProgressHUD

class HomeClockViewController: UIViewController {
    
    private lazy var clockButton: UIButton = {
        let clockButton = UIButton(type: .custom)
        clockButton.setTitle("现在就立即打卡~", for: .normal)
        clockButton.addTarget(self, action: #selector(clockButtonClick), for: .touchUpInside)
        clockButton.setTitleColor(UIColor.red, for: .normal)
        return clockButton
    }()
    
    private lazy var testButton: UIButton = {
        let testButton = UIButton(type: .custom)
        testButton.setTitle("检查公司设备是否在线", for: .normal)
        testButton.addTarget(self, action: #selector(testButtonClick), for: .touchUpInside)
        testButton.setTitleColor(UIColor.white, for: .normal)
        testButton.backgroundColor = UIColor.blue
        return testButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        title = "立即打卡"
        view.addSubview(testButton)
        view.addSubview(clockButton)
        testButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(100)
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
        }
        clockButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
        
        RCIMClient.shared()?.setReceiveMessageDelegate(self, object: nil)
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
    
    @objc private func testButtonClick() {
        let alert = UIAlertController(title:"是否现在", message: "请输入要接收打卡指令的userId", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .default) { (_) in
            
            guard let targetId = alert.textFields?.first?.text else{
                return
            }
            
            IMManager.shared.checkOnline(userId: targetId, success: { (dataJson) in
                if dataJson["status"].intValue == 1 {
                    //在线
                    SVProgressHUD.showSuccess(withStatus: "恭喜！在线")
                }else {
                    //不在线
                    SVProgressHUD.showError(withStatus: "赶紧去上班！！")
                }
            }, failure: { (errorCode) in
                SVProgressHUD.showError(withStatus: "网络异常，请重试！")
            })
            
        }
        alert.addTextField { (textfiled) in
            textfiled.placeholder = "请输入要接收打卡指令的userId"
        }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

}

extension HomeClockViewController: RCIMClientReceiveMessageDelegate {
    func onReceived(_ message: RCMessage!, left nLeft: Int32, object: Any!) {
        
        if let textMessage = message.content as? RCTextMessage {
            if textMessage.content == "DingSuccess" {
                DispatchQueue.main.async {
                    SVProgressHUD.showSuccess(withStatus: "恭喜您！！打卡成功啦！❤")
                }
            }
            if textMessage.content == "DingFail" {
                DispatchQueue.main.async {
                    SVProgressHUD.showSuccess(withStatus: "打卡没有成功 😭😭😭😭")
                }
            }
        }
        
        
    }
}
