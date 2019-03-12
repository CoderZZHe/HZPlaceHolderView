//
//  HZRefreshBackNormalFooter.swift
//  AXSDK
//
//  Created by 何志志 on 2018/6/26.
//  Copyright © 2018年 何志志. All rights reserved.
//

import UIKit
import MJRefresh

class HZRefreshBackNormalFooter: MJRefreshBackNormalFooter {

    override func prepare() {
        super.prepare()
        
        self.setTitle("上拉将加载更多", for: .idle)
        self.setTitle("松手加载更多", for: .pulling)
        self.setTitle("加载中...", for: .refreshing)
        //        self.isAutomaticallyHidden = true
        self.stateLabel.font = UIFont.systemFont(ofSize: 13)
    }

}
