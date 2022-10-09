import UIKit
import flutter_boost

@UIApplicationMain
class AppDelegate:UIResponder, UIApplicationDelegate  {
    
    var window: UIWindow?
    //创建代理，做初始化操作
    private let delegate = BoostDelegate()
    
    lazy var logoutButton: UIButton = {
        let logoutButton = UIButton()
        logoutButton.addTarget(self, action: #selector(self.logout), for:.touchUpInside)
        logoutButton.setTitle("Logout", for: .normal)
        
       
        logoutButton.backgroundColor = UIColor.systemBlue
        return logoutButton
    }()
    
    lazy var sendEventButton: UIButton = {
        let sendEventButton = UIButton()
        //在主窗口上放一个button，用来给flutter侧发送自定义事件
        sendEventButton.addTarget(self, action: #selector(self.onTapSendEventButton), for:.touchUpInside)
        sendEventButton.setTitle("Send event to flutter", for: .normal)
       
        sendEventButton.backgroundColor = UIColor.red
        
        return sendEventButton
    }()
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.makeKeyAndVisible()
        
        
        FlutterBoost.instance().setup(application, delegate: delegate, callback: { engine in
            
        })
        
        changeToRootController()
        
        
        return true
    }
    
    func changeToRootController() {
        //下面开始做四个Tab页面，一个native，三个flutter
        //native主页
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "首页", image: nil, tag: 0)
        
        //下面是三个flutter vc
        let fvc1  = FBFlutterViewContainer()!
        fvc1.setName("tab1", uniqueId: nil, params: nil, opaque: true)
        fvc1.tabBarItem = UITabBarItem(title: "flutter_tab1", image: nil, tag: 1)
        
        let fvc2  = FBFlutterViewContainer()!
        fvc2.setName("tab2", uniqueId: nil, params: nil, opaque: true)
        fvc2.tabBarItem = UITabBarItem(title: "flutter_tab2", image: nil, tag: 2)
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers([homeViewController,fvc1,fvc2], animated: false)
        
        let navigationViewController = UINavigationController(rootViewController: tabBarController)
        navigationViewController.navigationBar.isHidden = true
        self.window?.rootViewController = navigationViewController
        
        
        //这里将navigationController 给delegate，让delegate具有导航能力
        delegate.navigationController = navigationViewController
        
        
        
        self.window?.addSubview(sendEventButton)
        self.window?.addSubview(logoutButton)
        logoutButton.snp.remakeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(160)
        }
        sendEventButton.snp.remakeConstraints { (mkr) in
            mkr.centerX.equalToSuperview()
            mkr.top.equalToSuperview().offset(120)
        }
        
    }
    
    func changeToLoginController() {
        self.window?.rootViewController = LoginViewController()
    }
    
    @objc func onTapSendEventButton(){
        //发送自定义事件
        FlutterBoost.instance().sendEventToFlutter(with: "event", arguments: ["data":"event from native"])
    }
    
    
    @objc func logout() {
        FlutterBoost.instance().sendEventToFlutter(with: "logout", arguments: ["data":"logout"])
        changeToLoginController()
        sendEventButton.removeFromSuperview()
        logoutButton.removeFromSuperview()
    }
    
}
