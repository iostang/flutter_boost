//
//  LoginViewController.swift
//  Runner
//
//  Created by tangchi on 2022/10/9.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        //在主窗口上放一个button，用来给flutter侧发送自定义事件
        let loginButton = UIButton()
        loginButton.addTarget(self, action: #selector(self.login), for:.touchUpInside)
        loginButton.setTitle("Login", for: .normal)
        
        self.view.addSubview(loginButton)
        
        loginButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(160)
        }
        loginButton.backgroundColor = UIColor.systemBlue
        
    }
    
    @objc func login() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.changeToRootController()
    }

}
