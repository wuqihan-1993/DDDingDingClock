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
        
        
    }
    @objc private func companyButtonClick() {
        
    }
}
