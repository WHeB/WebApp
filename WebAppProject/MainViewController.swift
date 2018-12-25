//
//  MainViewController.swift
//  WebAppProject
//
//  Created by admin on 2018/12/25.
//  Copyright © 2018年 wangpeng. All rights reserved.
//

import UIKit
import WebKit
import JavaScriptCore

let ScW = UIScreen.main.bounds.size.width
let ScH = UIScreen.main.bounds.size.height
let headColor = UIColor.init(hex: "4E1073")
let bottomColor = UIColor.white

class MainViewController: UIViewController, WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {
    private var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = UIColor.white
        
        self.loadWebView()
        
        let headView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ScW, height: AppInfo.statusBarHeight))
        headView.backgroundColor = headColor
        self.view.addSubview(headView)
        
        if AppInfo.isHasSafeArea {
            let bottomView = UIView.init(frame: CGRect.init(x: 0, y: ScH - 34, width: ScW, height: 34))
            bottomView.backgroundColor = bottomColor
            self.view.addSubview(bottomView)
        }
        self.view.addSubview(self.loadindView)
    }
    
    private func loadWebView() {
        let config = WKWebViewConfiguration.init()
        config.preferences.javaScriptEnabled = true
        config.preferences.javaScriptCanOpenWindowsAutomatically = false
        config.processPool = WKProcessPool()
        config.userContentController = WKUserContentController()
        config.userContentController.add(self, name: "photograph")
        config.userContentController.add(self, name: "iOSServerAction")
        
        let webH = AppInfo.isHasSafeArea ? ScH - 44 - 34 : ScH - 20
        webView = WKWebView.init(frame: CGRect.init(x: 0, y: AppInfo.statusBarHeight, width: ScW, height: webH), configuration:config)
        webView.scrollView.bounces = false
        webView.navigationDelegate = self
        webView.uiDelegate = self
        self.view.addSubview(webView)
        let urlString = "http://m.diniver.com/dist"
        webView.load(URLRequest.init(url: URL.init(string: urlString)!))
        
        // 监听支持KVO的属性
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
    }
    
    lazy var loadindView: UIView = {
        let view = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ScW, height: ScH))
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var progressView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
        view.center = CGPoint.init(x: ScW/2, y: ScH/2)
        return view
    }()
    
    open override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress"{
            if Float(webView.estimatedProgress) < 1.0{ // 开始进度
                self.loadindView.addSubview(self.progressView)
                self.progressView.startAnimating()
            }
            if Float(webView.estimatedProgress) >= 1.0{ // 结束进度
                progressView .stopAnimating()
                self.loadindView.removeFromSuperview()
            }
        }
    }
    
    /// 获取当前url
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction:WKNavigationAction, decisionHandler: (WKNavigationActionPolicy) ->Void) {
        let urlString: String! = navigationAction.request.url?.absoluteString
        //        print(urlString)
        if urlString.hasPrefix("alipays://") || urlString.hasPrefix("alipay://") {
            let bSucc = UIApplication.shared.openURL(navigationAction.request.url!)
            if !bSucc {
                let alertVC = UIAlertController.init(title: "提示", message: "未检测到支付宝客户端，请安装后重试。", preferredStyle: .alert)
                let actionOK = UIAlertAction.init(title: "好的", style: .default) {(_) in }
                alertVC.addAction(actionOK)
                self.present(alertVC, animated: true, completion: nil)
            }
        }else if urlString.contains("apple.com/app/zhi-fu-bao") {
            _ = UIApplication.shared.openURL(navigationAction.request.url!)
        }
        decisionHandler(WKNavigationActionPolicy.allow)
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "photograph" { // 扫描
            self.qrCodeAction()
        }
        if message.name == "iOSServerAction" { // 客服
            self.connectMeiqiaServer()
        }
    }
}

extension MainViewController: LBXScanViewControllerDelegate {
    /// 扫一扫
    @objc func qrCodeAction() {
        let vc = ScanViewController();
        vc.scanResultDelegate = self
        let nav = UINavigationController.init(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
    
    /// 扫描完成
    func scanFinished(scanResult: LBXScanResult, error: String?) {
        self.dismiss(animated: true, completion: nil)
        let jsString = "qrcodeCallback('\(scanResult.strScanned!)')"
        self.webView.evaluateJavaScript(jsString, completionHandler: nil)
    }
    
    /// 客服 美恰
    private func connectMeiqiaServer() {
        let chatVC = MQChatViewManager.init()
        chatVC.pushMQChatViewController(in: self)
    }
}
