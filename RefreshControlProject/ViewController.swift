//
//  ViewController.swift
//  RefreshControlProject
//
//  Created by zhifu360 on 2019/5/28.
//  Copyright © 2019 ZZJ. All rights reserved.
//

import UIKit

class ViewController: BaseViewController {

    ///创建UITableView
    lazy var tableView: UITableView = {
        let table = UITableView(frame: view.bounds, style: .plain)
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: BaseTableReuseIdentifier)
        return table
    }()
    
    ///数据源
    var dataArray = ["🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓","🍈","🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓","🍈","🍏","🍎","🍐","🍊","🍋","🍌","🍉","🍇","🍓","🍈"]
    var newDataArray = ["🐶🐶🐶","🦊🦊🦊","🦁🦁🦁","🐵🐵🐵"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setPage()
        addRefresher()
    }

    func setPage() {
        title = "演示"
        view.addSubview(tableView)
    }
    
    func addRefresher() {
        if #available(iOS 10, *) {
            //创建UIRefreshControl
            let refreshCtrl = UIRefreshControl()
            refreshCtrl.tintColor = UIColor.gray
            refreshCtrl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
            tableView.refreshControl = refreshCtrl
        }
    }
    
    @objc func refreshAction() {
        if #available(iOS 10, *) {
            tableView.refreshControl?.beginRefreshing()
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+3) {
                self.tableView.refreshControl?.endRefreshing()
                //插入新数据到头部
                let newItem = self.newDataArray[Int(arc4random())%4]
                self.dataArray.insert(newItem, at: 0)
                self.tableView.reloadData()
            }
        }
    }

}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BaseTableReuseIdentifier, for: indexPath)
        cell.textLabel?.font = UIFont(name: "Apple Color Emoji", size: 30)
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }
    
}

