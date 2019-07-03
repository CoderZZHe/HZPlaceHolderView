//
//  UITableview_Extension.swift
//  HZPlaceHolderView_Example
//
//  Created by 何志志 on 2019/3/11.
//  Copyright © 2019 何志志. All rights reserved.
//

import UIKit

public protocol HZTableViewPlaceHolderDelegate: class {
    func makePlaceHolderView() -> UIView?
    func enableScrollWhenPlaceHolderViewShowing() -> Bool?
}

public extension HZTableViewPlaceHolderDelegate {
    func enableScrollWhenPlaceHolderViewShowing() -> Bool? {
        return nil
    }
}

extension UITableView {
    
    private struct AssociatedKeys {
        static var placeHolderView = "AKPlaceHolderView"
        static var placeHolderDelegate = "AKPlaceHolderDelegate"
    }
    
    private var placeHolderView: UIView? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.placeHolderView) as? UIView
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.placeHolderView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private weak var placeHolderDelegate: HZTableViewPlaceHolderDelegate? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.placeHolderDelegate) as? HZTableViewPlaceHolderDelegate
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.placeHolderDelegate, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }
    }
    
    public func hz_reloadData() {
        self.reloadData()
        hz_checkEmpty()
    }
    
    fileprivate func hz_checkEmpty() {
        
        // 是否要显示空数据视图
        var isEmpty = true
        
        // 需要显示空数据视图的情况:
        // section为默认1, row为0
        // section为0, row默认为1
        // section为0, row为0
        
//        let src: UITableViewDataSource? = self.dataSource
//        var sections: Int = 1
//        if let _newSection = src?.numberOfSections?(in: self) {
//            sections = _newSection
//        }
//        if let _src = src, self.placeHolderDelegate == nil  {
//            self.placeHolderDelegate = _src as? HZTableViewPlaceHolderDelegate
//        }
//        for i in 0 ..< sections {
//            let rows = src?.tableView(self, numberOfRowsInSection: i)
//            if let _rows = rows, _rows > 0 {
//                isEmpty = false
//                break
//            }
//        }
        
        let src: UITableViewDataSource? = self.dataSource
        
        if let _src = src, self.placeHolderDelegate == nil  {
            self.placeHolderDelegate = _src as? HZTableViewPlaceHolderDelegate
        }
        
        var sections: Int = 1   // 若不实现numberOfSections方法, 默认是有1个分组
        var isMoreSection: Bool = false    // 是否有多个section
        if let _newSections = src?.numberOfSections?(in: self) {   // 若代理实现了numberOfSections方法, 默认有多个分组, 需先判断section是否为0
            isMoreSection = true
            sections = _newSections
        }

        if isMoreSection {   // 如果有多组, 先判断组的个数是否为0
            isEmpty = sections == 0
        }else {
            for i in 0 ..< sections {
                let rows = src?.tableView(self, numberOfRowsInSection: i)
                if let _rows = rows, _rows > 0 {
                    isEmpty = false
                    break
                }
            }
        }
        
        if isEmpty, self.placeHolderView == nil {
            if let _scrollWasEnabled = self.placeHolderDelegate?.enableScrollWhenPlaceHolderViewShowing() {
                self.isScrollEnabled = _scrollWasEnabled
            }
            if let _placeHolderView = self.placeHolderDelegate?.makePlaceHolderView() {
                _placeHolderView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
                self.placeHolderView = _placeHolderView
                self.addSubview(_placeHolderView)
            }
        }else if self.placeHolderView != nil {
            self.placeHolderView?.removeFromSuperview()
            if isEmpty {
                if let _scrollWasEnabled = self.placeHolderDelegate?.enableScrollWhenPlaceHolderViewShowing() {
                    self.isScrollEnabled = _scrollWasEnabled
                }
                if let _placeHolderView = self.placeHolderDelegate?.makePlaceHolderView() {
                    _placeHolderView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
                    self.placeHolderView = _placeHolderView
                    self.addSubview(_placeHolderView)
                }
            }else {
                self.isScrollEnabled = true
                self.placeHolderView = nil
            }
        }
    }
}

