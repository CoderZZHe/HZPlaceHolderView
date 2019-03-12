//
//  HZRefresh.swift
//  HZPlaceHolderView_Example
//
//  Created by 何志志 on 2019/3/12.
//  Copyright © 2019 何志志. All rights reserved.
//

import UIKit

public enum HZRefreshType: Int {
    /// 上下拉都有
    case HZAllRefresh = 0
    /// 下拉
    case HZHeaderRefresh = 1
    /// 上拉
    case HZFooterRefresh = 2
}

public enum HZRefreshHeaderType: Int {
    case normal = 0
    case gif = 1
}

public class HZRefresh: UIView {
    
    /**
     刷新
     
     - parameter refreshScrollView:                 需要刷新的scrollView
     - parameter refreshType:                        上下拉、上拉、下拉
     - parameter refreshHeaderType:               刷新的样式、可选normal和gif
     - parameter isFirstRefresh:                      是否第一次刷新
     - parameter lastUpdatedTimeLabelHidden:    上次刷新时间的Label是否隐藏
     - parameter stateLabelHidden:                   刷新状态Label是否隐藏
     - parameter labelTextColor:                       Label的颜色、默认白色、传nil默认浅灰原颜色
     - parameter HeaderRefreshBlock:              下拉block
     - parameter FooterRefreshBlock:               上拉block
     */
    public class func refresh(refreshScrollView: UIScrollView,
                                      refreshType: HZRefreshType,
                                      refreshHeaderType: HZRefreshHeaderType = .normal,
                                      isFirstRefresh: Bool = false,
                                      lastUpdatedTimeLabelHidden: Bool = true,
                                      stateLabelHidden: Bool = false,
                                      labelTextColor: UIColor? = nil,
                                      headerRefreshBlock: @escaping ()->Void,
                                      footerRefreshBlock: (()->Void)? = nil) {
        
        switch refreshType {
        /// 上下拉
        case .HZAllRefresh:
            /// 下拉
            let headerRef: MJRefreshStateHeader?
            switch refreshHeaderType {
            case .normal:
                headerRef = HZRefreshNormalHeader(refreshingBlock: {
                    headerRefreshBlock()
                })
            case .gif:
                headerRef = HZRefreshGifHeader(refreshingBlock: {
                    headerRefreshBlock()
                })
            }
            headerRef?.lastUpdatedTimeLabel.isHidden = lastUpdatedTimeLabelHidden
            headerRef?.stateLabel.isHidden = stateLabelHidden
            if let color = labelTextColor {
                headerRef?.lastUpdatedTimeLabel.textColor = color
                headerRef?.stateLabel.textColor = color
            }
            refreshScrollView.mj_header = headerRef
            if isFirstRefresh {
                headerRef?.beginRefreshing()
            }
            
            /// 上拉
            let footerRef = HZRefreshBackNormalFooter(refreshingBlock: {
                if let _footerRefreshBlock = footerRefreshBlock {
                    _footerRefreshBlock()
                }
            })
            refreshScrollView.mj_footer = footerRef
            
        /// 下拉
        case .HZHeaderRefresh:
            let headerRef: MJRefreshStateHeader?
            switch refreshHeaderType {
            case .normal:
                headerRef = HZRefreshNormalHeader(refreshingBlock: {
                    headerRefreshBlock()
                })
            case .gif:
                headerRef = HZRefreshGifHeader(refreshingBlock: {
                    headerRefreshBlock()
                })
            }
            headerRef?.lastUpdatedTimeLabel.isHidden = lastUpdatedTimeLabelHidden
            headerRef?.stateLabel.isHidden = stateLabelHidden
            if let color = labelTextColor {
                headerRef?.lastUpdatedTimeLabel.textColor = color
                headerRef?.stateLabel.textColor = color
            }
            refreshScrollView.mj_header = headerRef
            if isFirstRefresh {
                headerRef?.beginRefreshing()
            }
            
        /// 上拉
        case .HZFooterRefresh:
            let footerRef = HZRefreshBackNormalFooter(refreshingBlock: {
                if let _footerRefreshBlock = footerRefreshBlock {
                    _footerRefreshBlock()
                }
            })
            refreshScrollView.mj_footer = footerRef
        }
    }
}

