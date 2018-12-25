//
//  ScanViewController.swift
//  Cocopay
//
//  Created by admin on 2018/8/6.
//  Copyright © 2018年 superchain. All rights reserved.
//

import UIKit

class ScanViewController: LBXScanViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置扫码区域参数
        var style = LBXScanViewStyle()
        style.centerUpOffset = 44;
        style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle.Inner;
        style.photoframeLineW = 3;
        style.photoframeAngleW = 18;
        style.photoframeAngleH = 18;
        style.isNeedShowRetangle = false;
        style.anmiationStyle = LBXScanViewAnimationStyle.LineMove;
        style.animationImage = UIImage(named: "CodeScan.bundle/qrcode_scan_light_green")
        
        self.scanStyle = style
        self.loadNavUI()
    }
    
    private func loadNavUI() {
        self.title = "扫一扫"
        
        let button = UIButton.init(type: .custom)
        button.frame = CGRect.init(x: 0, y: ScW - 50, width: 50, height: 44)
        button.setTitle("取消", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(cancleAction), for: .touchUpInside)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: button)
    }
    
    
    @objc func cancleAction() {
        self.dismiss(animated: true, completion: nil)
    }

}
