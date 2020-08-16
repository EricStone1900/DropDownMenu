//
//  DropMenuConfig.swift
//  Pods-DropMenuDemo
//
//  Created by song on 2020/8/4.
//

import Foundation
public enum DropMenuStyle {
  case MenuDarkStyle //类微信、黑底白字
  case MenuLightStyle //类支付宝、白底黑字
}

public struct Config {
    public static var menuContentMargin:CGFloat = 15.0 //默认文本图片边距
    public static var menuImageWidth:CGFloat = 15.0 //默认图片最小尺寸
    public static var menuBorderMinMargin:CGFloat = 15.0 //默认下拉框边界围栏
    public static var menuTitleFontSize:CGFloat = 15.0 //默认文本字体大小
    
    public static var initialMenuStyle: DropMenuStyle?

    
    public struct MenuCellConfig {        
        public static var lineColor = UIColor.lightGray
        public static var menuCellHeight:CGFloat = 50.0
        public static var menuMaxHeight:CGFloat = 5 * 50.0
    }
    
    public struct DropMenuConfig {
        public static var menuBgColor = UIColor.yellow
        public static var coverBgColor = UIColor.clear
        public static var triangleHeight:CGFloat = 8.0
        public static var adjustPullDown = true

    }
}
