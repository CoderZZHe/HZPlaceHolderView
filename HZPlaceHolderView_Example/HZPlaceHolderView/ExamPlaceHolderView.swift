//
//  ExamPlaceHolderView.swift
//  YTExamApp
//
//  Created by 研途 on 2019/3/5.
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

enum PlaceHolderImage: String {
    case collectionPage  = "noData_collection"
}

class ExamPlaceHolderView: UIView {

    fileprivate var titleString: String?
    fileprivate var image: UIImage?
    fileprivate var buttonTitle: String?
    fileprivate var clickButtonBlock: (() -> Void)?
    
    fileprivate var imageWidth: CGFloat = 0
    fileprivate var imageHeight: CGFloat = 0
    
    
    public class func createWithType(_ type: ExamPlaceHolderType) -> ExamPlaceHolderView? {
        return ExamPlaceHolderView(type.titleString, image: type.imageString, buttonTitle: nil, clickButtonBlock: nil)
    }
    
    public class func createWithType(_ type: ExamPlaceHolderType, buttonTitle: String?, clickButtonBlock: (() -> Void)?) -> ExamPlaceHolderView? {
        return ExamPlaceHolderView(type.titleString, image: type.imageString, buttonTitle: buttonTitle, clickButtonBlock: clickButtonBlock)
    }
    
    public class func createWithTitleImage(_ titleString: String, image: Any) -> ExamPlaceHolderView? {
        return ExamPlaceHolderView(titleString, image: image, buttonTitle: nil, clickButtonBlock: nil)
    }
    
    public class func createWithTitleImage(_ titleString: String, image: Any, buttonTitle: String?, clickButtonBlock: (() -> Void)?) -> ExamPlaceHolderView? {
        return ExamPlaceHolderView(titleString, image: image, buttonTitle: buttonTitle, clickButtonBlock: clickButtonBlock)
    }
    
    fileprivate init(_ titleString: String, image: Any, buttonTitle: String? = nil, clickButtonBlock: (() -> Void)? = nil) {
        super.init(frame: .zero)
        
        self.titleString = titleString
        if let _imageString = image as? String {
            self.image = UIImage(named: _imageString)
        }else if let _image = image as? UIImage {
            self.image = _image
        }else {
            return
        }
        self.buttonTitle = buttonTitle
        self.clickButtonBlock = clickButtonBlock
        if let _image = self.image {
            self.imageWidth = _image.size.width
            self.imageHeight = _image.size.height
        }
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupUI() {
        
        self.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.text = self.titleString
        titleLabel.textColor = UIColor(r: 155, g: 162, b: 181)
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        self.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.centerY.equalToSuperview().offset(-(self.bounds.size.height * 0.1))
        }
        
        let imageView = UIImageView(image: self.image)
        self.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.width.equalTo(self.imageWidth)
            make.height.equalTo(self.imageHeight)
            make.bottom.equalTo(titleLabel.snp.top).offset(-20)
        }
        
        if buttonTitle != nil {
            let button = UIButton(type: .custom)
            button.hz_viewAddCornerRadius(17)
            button.backgroundColor = UIColor(r: 5, g: 202, b: 113)
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.addTarget(self, action: #selector(clickButtonAction(_:)), for: .touchUpInside)
            self.addSubview(button)
            button.snp.makeConstraints { (make) in
                make.top.equalTo(titleLabel.snp.bottom).offset(26)
                make.width.equalTo(115)
                make.height.equalTo(34)
                make.centerX.equalToSuperview()
            }
        }
    }
}

extension ExamPlaceHolderView {
    
    @objc fileprivate func clickButtonAction(_ sender: UIButton) {
        if let _block = self.clickButtonBlock {
            _block()
        }
    }
    
}
