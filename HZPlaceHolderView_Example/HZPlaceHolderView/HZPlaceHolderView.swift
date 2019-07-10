//
//  HZPlaceHolderView.swift
//  HZPlaceHolderView_Example
//
//  Created by 何志志 on 2019/3/11.
//  Copyright © 2019 何志志. All rights reserved.
//

import UIKit

public class HZPlaceHolderView: UIView {

    private(set) var refreshButton: UIButton?
    private(set) var placeHolderTitleLabel: UILabel?
    
    fileprivate var titleString: String?
    fileprivate var image: UIImage?
    fileprivate var buttonTitle: String?
    fileprivate var clickButtonBlock: (() -> Void)?
    
    fileprivate var imageWidth: CGFloat = 0
    fileprivate var imageHeight: CGFloat = 0
    
    public class func create(_ titleString: String, image: Any, buttonTitle: String? = nil, clickButtonBlock: (() -> Void)? = nil) -> HZPlaceHolderView? {
        return HZPlaceHolderView(titleString, image: image, buttonTitle: buttonTitle, clickButtonBlock: clickButtonBlock)
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
        titleLabel.textColor = UIColor(red: 155.0 / 255.0, green: 162.0 / 255.0, blue: 181.0 / 255.0, alpha: 1.0)
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        self.placeHolderTitleLabel = titleLabel
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let titleLabelLeading = NSLayoutConstraint(item: titleLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0)
        let titleLabelTrailing = NSLayoutConstraint(item: titleLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0)
        let titleLabelVertical = NSLayoutConstraint(item: titleLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1.0, constant: -(self.bounds.size.height * 0.1))
        addConstraints([titleLabelLeading, titleLabelTrailing, titleLabelVertical])
        
        let imageView = UIImageView(image: self.image)
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let imageViewHorizontal = NSLayoutConstraint( item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0)
        let imageViewWidth = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.imageWidth)
        let imageViewHeight = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: self.imageHeight)
        let imageViewBottom = NSLayoutConstraint(item: imageView, attribute: .bottom, relatedBy: .equal, toItem: titleLabel, attribute: .top, multiplier: 1.0, constant: -20)
        addConstraints([imageViewHorizontal, imageViewWidth, imageViewHeight, imageViewBottom])
        
        if buttonTitle != nil {
            let button = UIButton(type: .custom)
            button.layer.cornerRadius = 17
            button.layer.masksToBounds = false
            
            button.backgroundColor = UIColor(red: 5.0 / 255.0, green: 202.0 / 255.0, blue: 113.0 / 255.0, alpha: 1.0)
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            button.addTarget(self, action: #selector(clickButtonAction(_:)), for: .touchUpInside)
            self.refreshButton = button
            self.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            let buttonHorizontal = NSLayoutConstraint( item: button, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1.0, constant: 0)
            let buttonWidth = NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 115)
            let buttonHeight = NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 34)
            let buttonBottom = NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .top, multiplier: 1.0, constant: 26)
            addConstraints([buttonHorizontal, buttonWidth, buttonHeight, buttonBottom])
        }
    }
}

extension HZPlaceHolderView {
    
    @objc fileprivate func clickButtonAction(_ sender: UIButton) {
        if let _block = self.clickButtonBlock {
            _block()
        }
    }
    
}
