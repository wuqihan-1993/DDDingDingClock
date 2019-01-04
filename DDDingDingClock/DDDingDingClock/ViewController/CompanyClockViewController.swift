//
//  CompanyClockViewController.swift
//  DDDingDingClock
//
//  Created by wuqh on 2019/1/4.
//  Copyright © 2019 wuqh. All rights reserved.
//

import UIKit

class CompanyClockViewController: UIViewController {
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "恭喜你，连接成功了！💐 \n\n 你可以使用你的另一个手机，发送指令来唤起钉钉进行打卡\n\n请把该手机放在公司，接上电源（避免没电自动关机）,并且不要把该app退到后台"
        return label
    }()

    private var lastBrightness: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.white
        
        title = "准备就绪"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "退出", style: .done, target: self, action: #selector(exit))
        navigationItem.leftBarButtonItem?.tintColor = UIColor.red
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "省电模式", style: .plain, target: self, action: #selector(saveElectricity))
        
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.left.equalToSuperview().offset(60)
            make.right.equalToSuperview().offset(-60)
        }
        
        RCIMClient.shared()?.setReceiveMessageDelegate(self, object: nil)
        

    }
    
    @objc private func exit() {
        
        let alert = UIAlertController(title: "确定要退出吗", message: "退出该页面，将无法接收到打卡指令。请谨慎操作~", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定，我要退出~", style: .default) {[weak self] (_) in
            self?.dismiss(animated: true, completion: nil)
            RCIMClient.shared()?.logout()
        }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    @objc private func saveElectricity() {
        if navigationItem.rightBarButtonItem?.title == "省电模式" {
            lastBrightness = UIScreen.main.brightness
            navigationItem.rightBarButtonItem?.title = "关闭省电模式"
            UIScreen.main.brightness = 0
        }else {
            navigationItem.rightBarButtonItem?.title = "省电模式"
            UIScreen.main.brightness = lastBrightness
        }
        
    }

}

extension CompanyClockViewController: RCIMClientReceiveMessageDelegate {
    func onReceived(_ message: RCMessage!, left nLeft: Int32, object: Any!) {
        
        if DTOpenAPI.openDingTalk() {
            print("打开钉钉成功")
            
        }else {
            print("打开钉钉失败了")
        }
    }
}
