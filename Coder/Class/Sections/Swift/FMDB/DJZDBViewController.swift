//
//  DJZDBViewController.swift
//  Coder
//
//  Created by 张得军 on 2019/10/25.
//  Copyright © 2019 张得军. All rights reserved.
//

import Foundation
import UIKit

class DJZDBViewController: UITableViewController {
    var dataArray = Array<DJZDBListModel>()
    
    var expandCallBack: (Bool) -> Void = { isExpand in
        
    }
    subscript(index: Int) -> Int {
        return 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton()
        expandCallBack(true)
    }
    
    func addButton() {
        let createButton = UIBarButtonItem(title: "create", style: .done, target: self, action: #selector(createTable))
        let dropButton = UIBarButtonItem(title: "drop", style: .done, target: self, action: #selector(dropTable))
        self.navigationItem.rightBarButtonItems = [createButton, dropButton]
    }
    
    @objc private func createTable() {
        DJZDBManager.shareManager.createTable()
        makeData()
    }
    
    @objc private func dropTable() {
        DJZDBManager.shareManager.dropTable()
        dataArray.removeAll()
        tableView.reloadData()
    }
    
    private func makeData() {
        for i in 0...10 {
            let model = DJZDBListModel()
            model.personID = i
            model.name = "名称\(i)"
            model.isTop = false
            DJZDBManager.shareManager.insertData(model: model)
        }
        dataArray = DJZDBManager.shareManager.getDataList()
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        let model = dataArray[indexPath.row]
        cell?.textLabel?.text = "\(model.name) + isTop: \(model.isTop)"
        cell?.backgroundColor = model.isTop ? UIColor.lightGray : UIColor.white
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let model = dataArray[indexPath.row]
        let deleteAction = UITableViewRowAction(style: .destructive, title: "delete") { (action, indexPath) in
            guard DJZDBManager.shareManager.deleteDataOfDataList(personId: model.personID) else {
                return
            }
            self.dataArray = DJZDBManager.shareManager.getDataList()
            tableView.reloadData()
        }
        let topAction = UITableViewRowAction(style: .normal, title: model.isTop ? "cancel Top" : "Top") { (action, indexPath) in
            guard DJZDBManager.shareManager.setTopWithPersonId(personId: model.personID, isTop: !model.isTop) else {
                return
            }
            self.dataArray = DJZDBManager.shareManager.getDataList()
            tableView.reloadData()
        }
        return [deleteAction, topAction]
    }
}
