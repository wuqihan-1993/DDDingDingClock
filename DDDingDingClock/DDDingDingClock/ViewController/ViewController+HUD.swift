//
//  ViewController+HUD.swift
//  DDDingDingClock
//
//  Created by wuqh on 2019/1/7.
//  Copyright © 2019 wuqh. All rights reserved.
//

import Foundation
import NVActivityIndicatorView

extension UIViewController: NVActivityIndicatorViewable {
    func showHud(message: String? = nil,type: NVActivityIndicatorType? = .ballRotateChase) {
        startAnimating(CGSize(width: 40, height: 40), message: message, messageFont: UIFont.systemFont(ofSize: 14), type: type, fadeInAnimation: nil)
    }
    func showErrorHUD(message: String? = nil) {
        NVActivityIndicatorPresenter.sharedInstance.setMessage(message)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
            self.dismissHUD()
        }
    }
    
    func dismissHUD() {
        stopAnimating(nil)
    }
}
