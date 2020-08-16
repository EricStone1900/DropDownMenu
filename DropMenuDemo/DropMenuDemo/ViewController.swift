//
//  ViewController.swift
//  DropMenuDemo
//
//  Created by song on 2020/8/4.
//  Copyright © 2020 huangbo. All rights reserved.
//

import UIKit
import DropMenu

class ViewController: UIViewController {

    @IBOutlet weak var mTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        setupNavi()
        setupTable()
    }

    func setupNavi() {
        self.title = "下拉菜单"
        let rightBtn = UIButton(type: .custom)
        rightBtn.tag = 10086
        rightBtn.setImage(UIImage(named: "icon_add_white_20x20"), for: .normal)
        rightBtn.addTarget(self, action: #selector(ViewController.addClicked(_:)), for: .touchUpInside)
        let rightBarItem = UIBarButtonItem(customView: rightBtn)
        navigationItem.rightBarButtonItem = rightBarItem
        navigationController?.navigationBar.barTintColor = .blue
    }
    
    func setupTable() {
        mTable.tableFooterView = UIView()
        mTable.delegate = self
        mTable.dataSource = self
        mTable.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
    }
    
    @objc func addClicked(_ sender: UIButton) {
        print("addClicked \(sender.tag)")
        let titleArray = ["2020年02月","2020年03月","2020年04月","2020年05月"]
        let menu = DropDownMenuView.pullDropDrownMenu(anchorView: sender, titleArray: titleArray)
        menu.selectionAction = { (index: Index, str: String) -> (Void) in
            let str = "\(index)" + " " + str
            print(str)
        }

    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88.0
    }
    
}
