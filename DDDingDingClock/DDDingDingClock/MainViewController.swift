//
//  MainViewController.swift
//  DDDingDingClock
//
//  Created by wuqh on 2019/1/4.
//  Copyright © 2019 wuqh. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private lazy var homeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("家里的手机请点击", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(homeButtonClick), for: .touchUpInside)
        return button
    }()
    private lazy var companyButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("放在公司的手机请点击", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(companyButtonClick), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "请选择"
        setupUI()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        RCIMClient.shared()?.logout()
    }
    
    private func setupUI() {
        view.addSubview(homeButton)
        view.addSubview(companyButton)
        
        homeButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
        }
        
        companyButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(homeButton.snp.bottom).offset(60)
        }
        
    }

}

extension MainViewController {
    @objc private func homeButtonClick() {
        
        let alert = UIAlertController(title: "登录", message: "如有问题联系qq:651076554", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "请输入您的token"
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
            
        }
        let okAction = UIAlertAction(title: "确定", style: .default) {[weak self] (action) in
            //登录 链接融云
            RCIMClient.shared()?.connect(withToken: "MZYeIXs1YcN3twxa/8N2q9TtNz3fxSLU+NA92dVayjH39xylZDwUUz1XwkLeFdoc8RauUCFuq64a+z/hnqyDkSWzWX4627se", success: { (userId) in
                DispatchQueue.main.async {
                    self?.navigationController?.pushViewController(HomeClockViewController(), animated: true)
                }
            }, error: { (errorCode) in
                print("\(errorCode)")
            }, tokenIncorrect: {
                print("过期或token无效")
            })
        }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    @objc private func companyButtonClick() {
        let alert = UIAlertController(title: "登录", message: "如有问题联系qq:651076554", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "请输入您的token"
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (action) in
            
        }
        let okAction = UIAlertAction(title: "确定", style: .default) {[weak self] (action) in
            //登录 链接融云
            RCIMClient.shared()?.connect(withToken: "BNQt/yE+6EV2zV6tYbhwhMxLFy44qvJmbbEHga/UUOKJ6FalfhCiPi6sMyOPySorl2AU/wLf9BD8DcLn+b4AnQ==", success: { (userId) in
                DispatchQueue.main.async {
                    
                    self?.navigationController?.pushViewController(CompanyClockViewController(), animated: true)
                }
            }, error: { (errorCode) in
                print("\(errorCode)")
            }, tokenIncorrect: {
                print("过期或token无效")
            })
        }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
