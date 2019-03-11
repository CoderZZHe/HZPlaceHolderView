//
//  HZPlaceHolderView_Extension.swift
//  YTExamApp
//
//  Created by 何志志 on 2019/3/11.
//  Copyright © 2019 何志志. All rights reserved.
//

import UIKit

enum ExamPlaceHolderType: Int {
    case collectionPage
    case wrongPage
    case messagePage
    case answerHistoryPage
    case downloadPage
    case defaultPage
    case loadFailedPage
    
    var titleString: String {
        switch self {
        case .collectionPage:
            return "你还没有收藏任何题目~"
        case .wrongPage:
            return "你还没有错题\n很棒哦~"
        case .messagePage:
            return "暂无任何消息~"
        case .answerHistoryPage:
            return "暂无答题记录！"
        case .downloadPage:
            return "暂无下载记录！"
        case .defaultPage:
            return "暂无数据"
        case .loadFailedPage:
            return "数据加载失败！"
        }
    }
    
    var imageString: String {
        switch self {
        case .collectionPage:
            return "noData_collection"
        case .wrongPage:
            return "noData_wrong"
        case .messagePage:
            return "noData_message"
        case .answerHistoryPage:
            return "noData_answerHistory"
        case .downloadPage:
            return "noData_download"
        case .defaultPage:
            return "noData_default"
        case .loadFailedPage:
            return "noData_fail"
        }
    }
    
}

extension HZPlaceHolderView {
    
    class func createWithType(_ type: ExamPlaceHolderType) -> HZPlaceHolderView? {
        return HZPlaceHolderView.createWithTitleImage(type.titleString, image: type.imageString)
    }
    
    class func createWithType(_ type: ExamPlaceHolderType, buttonTitle: String?, clickButtonBlock: (() -> Void)?) -> HZPlaceHolderView? {
        return HZPlaceHolderView.createWithTitleImage(type.titleString, image: type.imageString, buttonTitle: buttonTitle, clickButtonBlock: clickButtonBlock)
    }
    
}
