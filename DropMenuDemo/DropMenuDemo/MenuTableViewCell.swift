//
//  MenuTableViewCell.swift
//  DropMenuDemo
//
//  Created by song on 2020/8/5.
//  Copyright © 2020 huangbo. All rights reserved.
//

import UIKit
import DropMenu

class MenuTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func actionAlipayBtn(_ sender: UIButton) {
        print("actionAlipayBtn")
        let titleArray = ["发起群聊","添加朋友","扫一扫","收钱"];
        let image1 = UIImage(named: "ap_group_talk")!
        let image2 = UIImage(named: "ap_add_friend")!
        let image3 = UIImage(named: "ap_scan")!
        let image4 = UIImage(named: "ap_qrcode")!
        let imageArray = [image1,image2,image3,image4]
        Config.MenuCellConfig.menuCellHeight = 50
        let dropMenu = DropDownMenuView.pullDropDrownMenu(anchorView: sender, titleArray: titleArray, imageArray: imageArray)
        dropMenu.menuStyle = .MenuLightStyle
    }
    
    @IBAction func actionWechatBtn(_ sender: UIButton) {
        print("actionWechatBtn")
        let titleArray = ["发起群聊","添加朋友","扫一扫","收付款"]
        let image1 = UIImage(named: "contacts_add_newmessage_30x30_")!
        let image2 = UIImage(named: "contacts_add_friend_30x30_")!
        let image3 = UIImage(named: "contacts_add_scan_30x30_")!
        let image4 = UIImage(named: "contacts_add_scan_30x30_")!
        let imageArray = [image1,image2,image3,image4]
        Config.MenuCellConfig.menuCellHeight = 50
        let dropMenu = DropDownMenuView.pullDropDrownMenu(anchorView: sender, titleArray: titleArray, imageArray: imageArray)
    }
    
    @IBAction func actionEditBtn(_ sender: UIButton) {
        print("actionEditBtn")
        let titleArray = ["编辑","删除"]
         Config.MenuCellConfig.menuCellHeight = 25
        let menu = DropDownMenuView.pullDropDrownMenu(anchorView: sender, titleArray: titleArray)
//        menu.menuCellHeight = 25
       
    }
    
}
