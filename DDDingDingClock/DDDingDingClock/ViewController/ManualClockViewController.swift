//
//  ManualClockViewController.swift
//  DDDingDingClock
//
//  Created by wuqh on 2019/1/4.
//  Copyright © 2019 wuqh. All rights reserved.
//

import UIKit
import Alamofire
import CommonCrypto
import NVActivityIndicatorView
import CoreTelephony



class ManualClockViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 60
        return tableView
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        RCIMClient.shared()?.logout()
    }
    
}
extension ManualClockViewController: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description(), for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.accessoryType = .disclosureIndicator
        if indexPath.section == 0 {
            cell.textLabel?.text = "该手机为发送打卡指定的手机"
        }else {
            cell.textLabel?.text = "该手机为放在公司，接收指令，钉钉打卡的手机"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            connectHome()
        }else {
            connectCompany()
        }
    }
}

extension ManualClockViewController {
    private func connectHome() {
        
        showHud()
        //这里随机分配一个可以登陆的token
        let randomId = Int.random(in: 1000..<1050)
        IMManager.shared.getToken(userName: String(randomId), success: { (data) in
            
            guard let token = data["token"].string else{
                self.showErrorHUD(message: "获取token失败")
                return
            }
            //登录 链接融云
            RCIMClient.shared()?.connect(withToken: token, success: { (userId) in
                DispatchQueue.main.async {
                    self.dismissHUD()
                    self.navigationController?.pushViewController(HomeClockViewController(), animated: true)
                }
            }, error: { (errorCode) in
                if errorCode.rawValue == 31006 {
                    DispatchQueue.main.async {
                        self.dismissHUD()
                        self.navigationController?.pushViewController(HomeClockViewController(), animated: true)
                    }
                }else {
                    self.showErrorHUD(message: "errorCode:\(errorCode)")
                }
                
            }, tokenIncorrect: {
                self.showErrorHUD(message: "token过期或无效...")
            })
            
            
        }, failure: { (error) in
            
            self.showErrorHUD(message: error.localizedDescription)
            
        })
    }
    private func connectCompany() {
        
        

        let alert = UIAlertController(title: "登录", message: "如有问题联系qq:651076554", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "请输入您的用户名（无需注册）"
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (action) in

        }
        let okAction = UIAlertAction(title: "确定", style: .default) {[weak self] (action) in
            guard let userName = alert.textFields?.first?.text else{
                return
            }
            self?.showHud()
            IMManager.shared.getToken(userName: userName, success: { (data) in
                
                guard let token = data["token"].string else{
                    self?.showErrorHUD(message: "获取token失败")
                    return
                }
                //登录 链接融云
                RCIMClient.shared()?.connect(withToken: token, success: { (userId) in
                    DispatchQueue.main.async {
                        self?.dismissHUD()
                        let vc = CompanyClockViewController()
                        vc.companyId = token
                        self?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
                    }
                }, error: { (errorCode) in
                    self?.showErrorHUD(message: "errorCode:\(errorCode)")
                }, tokenIncorrect: {
                    self?.showErrorHUD(message: "token过期或无效...")
                })
                
                
            }, failure: { (error) in
                self?.showErrorHUD(message: error.localizedDescription)
            })
            
            
        }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
    }
}


