//
//  SwiftViewController.swift
//  Coder
//
//  Created by 张得军 on 2019/10/24.
//  Copyright © 2019 张得军. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class SwiftViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var dataArray = Array<String>()
    
    lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorColor = UIColor.red
        return tableView
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.white;
        dataArray = ["FMDB"]
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = dataArray[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let dbController = DJZDBViewController()
            navigationController?.pushViewController(dbController, animated: true)
        default:
            NSLog("")
        }
    }
    
}
