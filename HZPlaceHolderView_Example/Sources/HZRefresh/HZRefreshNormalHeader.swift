//
//  HZRefreshNormalHeader.swift
//  AXSDK
//
//  Created by 何志志 on 2018/6/26.
//  Copyright © 2018年 何志志. All rights reserved.
//

import UIKit

class HZRefreshNormalHeader: MJRefreshNormalHeader {

    override func prepare() {
        super.prepare()
        
        // 自动切换透明度
        self.isAutomaticallyChangeAlpha = true
        
        self.setTitle("下拉即可刷新", for: .idle)
        self.setTitle("释放即刷新", for: .pulling)
        self.setTitle("正在刷新...", for: .refreshing)
        
        self.stateLabel.font = UIFont.systemFont(ofSize: 13)
        
    }
    
}
