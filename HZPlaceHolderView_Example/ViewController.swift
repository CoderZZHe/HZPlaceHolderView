//
//  ViewController.swift
//  HZPlaceHolderView_Example
//
//  Created by 何志志 on 2019/3/11.
//  Copyright © 2019 何志志. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    fileprivate var dataSource: [String]? = ["一", "二", "三", "四"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.backgroundColor = .white
        
        let tableview = UITableView(frame: view.bounds, style: .grouped)
        tableview.dataSource = self
        tableview.delegate = self
        view.addSubview(tableview)
        
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = dataSource?.count else {
            return 0
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = dataSource?[indexPath.row]
        cell.contentView.backgroundColor = .gray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataSource = nil
        tableView.hz_reloadData()
    }
    
}

extension ViewController: HZTableViewPlaceHolderDelegate {
    
    func makePlaceHolderView() -> UIView? {
        return HZPlaceHolderView.createWithTitleImage("没有数据哦~", image: "noData_default")
    }
    
}

