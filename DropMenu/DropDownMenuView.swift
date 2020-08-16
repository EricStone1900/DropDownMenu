//
//  DropDownMenuView.swift
//  DropMenu
//
//  Created by song on 2020/8/4.
//

import UIKit

public typealias Index = Int
public typealias SelectionClosure = (Index, String) -> Void

public class DropDownMenuView: UIView {

    // 蒙层背景color
    var coverBgColor: UIColor? {
        didSet {
            guard let color = coverBgColor else { return }
            backgroundColor = color
        }
    }
    // 主样式color
    var menuBgColor: UIColor? {
        didSet {
            guard let color = menuBgColor else { return }
            mTable.backgroundColor = color
        }
    }//= Config.DropMenuConfig.menuBgColor
    // 线条颜色
    var lineColor = Config.MenuCellConfig.lineColor
    // cell高度
    public var menuCellHeight = Config.MenuCellConfig.menuCellHeight
    /**
    *  table最大高度限制
    *  默认：5 * cellHeight
    */
    var menuMaxHeight = Config.MenuCellConfig.menuMaxHeight
    /**
    *  小三角高度
    *  45°等腰三角形
    */
    public var triangleHeight = Config.DropMenuConfig.triangleHeight
    /**
    *  调整使下拉优先 当向下偏转屏幕距离足够，优先向下偏转
    */
    public var adjustPullDown = Config.DropMenuConfig.adjustPullDown
    /**
    *  pullMenu样式
    */
    public var menuStyle = Config.initialMenuStyle ?? DropMenuStyle.MenuDarkStyle {
        didSet {
            switch menuStyle {
            case .MenuDarkStyle:
                coverBgColor = .clear
                menuBgColor = UIColor.black.withAlphaComponent(0.6)
            case .MenuLightStyle:
                coverBgColor = UIColor.gray.withAlphaComponent(0.3)
                menuBgColor = .white
            }
            refreshUI()
        }
    }
    /**
    *  click
    */
    public var selectionAction: SelectionClosure?
    
    // 文字
    fileprivate var titleArray = [String]()
    // 图片
    fileprivate var imageArray = [UIImage]()
    // 图文Model
    fileprivate var menuArray = [DropMenuModel]()
    
    fileprivate lazy var contentView: UIView = self.makeContentView()
    fileprivate lazy var mTable: UITableView = self.makeTableView()
    fileprivate var anchorRect = CGRect.zero
    
    public class func pullDropDrownMenu(anchorView: UIView) -> DropDownMenuView {
        return pullDropDrownMenu(anchorView: anchorView, titleArray: [])
    }

    public class func pullDropDrownMenu(anchorView: UIView, titleArray:[String]) -> DropDownMenuView {
        return pullDropDrownMenu(anchorView: anchorView, titleArray: titleArray, imageArray: [])
    }

    public class func pullDropDrownMenu(anchorView: UIView, titleArray:[String], imageArray:[UIImage]) -> DropDownMenuView {
        //如果titleArray.count != imageArray.count 以 titeArray 为数据
        var menuArray = [DropMenuModel]()
        if titleArray.count != imageArray.count {
            for item in titleArray {
                var model = DropMenuModel()
                model.title = item
                menuArray.append(model)
            }
        }
        
        if titleArray.count == imageArray.count {
            for i in 0 ..< titleArray.count {
                var model = DropMenuModel()
                model.title = titleArray[i]
                model.image = imageArray[i]
                menuArray.append(model)
            }
        }
        
        let menuView = pullDropDrownMenu(anchorView: anchorView, menuArray: menuArray)
        return menuView
    }

    public class func pullDropDrownMenu(anchorView: UIView, menuArray:[DropMenuModel]) -> DropDownMenuView {
        let window = UIApplication.shared.delegate?.window!
        let menuView = DropDownMenuView()
        menuView.frame = UIScreen.main.bounds
        window!.addSubview(menuView)
        menuView.anchorRect = anchorView.convert(anchorView.bounds, to: window!)
        menuView.menuArray = menuArray
        menuView.menuStyle = .MenuDarkStyle
//        menuView.refreshUI()
        return menuView
    }
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeContentView() -> UIView {
        let view  = UIView()
        return view
    }
    
    private func makeTableView() -> UITableView {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.cornerRadius = 5.0
        tableView.backgroundColor = menuBgColor
        tableView.separatorStyle = .none
        return tableView
    }
    
    private func setupUI() {
        addSubview(contentView)
        mTable.register(DropMenuCell.self, forCellReuseIdentifier: "SHBDropMenuCell")
        contentView.addSubview(mTable)
    }
    
    private func refreshUI() {
        drawmTableFrame()
        mTable.reloadData()
    }

    //-function
    private func animateRemoveView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0.0
            self.contentView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            self.contentView.alpha = 0.0
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    private func cacuateCellWidth() -> CGFloat{
        var maxTitleWidth: CGFloat = 0.0
        
        for obj in menuArray {
            let width = obj.title?.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: Config.menuTitleFontSize)]).width
            var titleWidth = width ?? 0.0
            if obj.image != nil {
                titleWidth += Config.menuContentMargin + Config.menuImageWidth
            }
           
            if titleWidth > maxTitleWidth {
                maxTitleWidth = titleWidth
            }
        }
        return (maxTitleWidth + Config.menuContentMargin * 2)
    }
    
    private func drawmTableFrame() {
        var layerAnchor = CGPoint.zero
        var layerPosition = CGPoint.zero
        var x: CGFloat = anchorRect.midX
        var y: CGFloat = 0.0
        var h: CGFloat = CGFloat(menuArray.count) * menuCellHeight
        let w: CGFloat = cacuateCellWidth()
        //最大高度围栏限制
        if h > menuMaxHeight {
            h = menuMaxHeight
        }
        //X中点位置：
        //居左：table右偏
        //居右：table左偏
        if x > bounds.midX {
            x = x - 3 * w / 4.0
            layerAnchor.x = 1.0
            layerPosition.x = x + w
        }else {
            x = x - w / 4.0
            layerAnchor.x = 0.0
            layerPosition.x = x
        }
        //围栏
        if x < Config.menuBorderMinMargin {
            x = Config.menuBorderMinMargin
            layerPosition.x = x
        }
        
        if ((x + w ) > bounds.size.width) {
            x = bounds.size.width - w - Config.menuBorderMinMargin
            layerPosition.x = x + w
        }
        
        //需要偏转Y对比中心点 默认比对屏幕中心点
        var offsetCenterY = bounds.midY
        //优先菜单下拉
        if adjustPullDown {
            //下偏移区间距离
            offsetCenterY = bounds.size.height - h - triangleHeight
        }
        //Y中心位置
        //居上：下拉
        //居下：上拉
        if anchorRect.midY < offsetCenterY {
            y = anchorRect.maxY
            mTable.frame = CGRect(x: 0.0, y: triangleHeight, width: w, height: h)
            layerAnchor.y = 0.0
            layerPosition.y = y
        }else {
            y = anchorRect.minY - triangleHeight - h
            mTable.frame = CGRect(x: 0.0, y: 0.0, width: w, height: h)
            layerAnchor.y = 1.0
            layerPosition.y = y + h
        }
        contentView.frame = CGRect(x: x, y: y, width: w, height: h + triangleHeight)
        drawTriangle()
        //动画锚点
        contentView.layer.position = layerPosition
        contentView.layer.anchorPoint = layerAnchor
    }
    
    private func drawTriangle() {
        var x: CGFloat = anchorRect.midX - contentView.frame.minX
        var y: CGFloat = 0.0
        var p = CGPoint.zero
        var q = CGPoint.zero
        let h: CGFloat = CGFloat(menuArray.count) * menuCellHeight
        //围栏
        if x < 2 * triangleHeight {
            x = 2 * triangleHeight
        }
        
        if x > (contentView.bounds.width - 2 * triangleHeight) {
            x = (contentView.bounds.width - 2 * triangleHeight)
        }
        
        //需要偏转Y对比中心点 默认比对屏幕中心点
        var offsetCenterY = bounds.midY
        //优先菜单下拉
        if adjustPullDown {
            //下偏移区间距离
            offsetCenterY = bounds.size.height - h - triangleHeight
        }
        //Y中心位置
        //居上：下拉
        //居下：上拉
        if anchorRect.midY < offsetCenterY {
            y = 0.0
            p = CGPoint(x: x + triangleHeight, y: y + triangleHeight)
            q = CGPoint(x: x - triangleHeight, y: y + triangleHeight)
        }else {
            y = contentView.frame.height
            p = CGPoint(x: x + triangleHeight, y: y - triangleHeight)
            q = CGPoint(x: x - triangleHeight, y: y - triangleHeight)
        }
        
        let triangleLayer = CAShapeLayer()
        triangleLayer.frame = contentView.bounds
        triangleLayer.fillColor = menuBgColor?.cgColor
        let bezier = UIBezierPath()
        bezier.move(to: CGPoint(x: x, y: y))
        bezier.addLine(to: p)
        bezier.addLine(to: q)
        bezier.lineJoinStyle = .round
        triangleLayer.path = bezier.cgPath
        contentView.layer.addSublayer(triangleLayer)
    
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        animateRemoveView()
    }
   
}

extension DropDownMenuView : UITableViewDelegate,UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return menuCellHeight
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SHBDropMenuCell", for: indexPath) as! DropMenuCell
        let cellModel = menuArray[indexPath.row]
        cell.menuModel = cellModel
        cell.dropMenuStyle = menuStyle
        cell.lineColor = lineColor
        cell.isFinalCell = indexPath.row == (menuArray.count - 1)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cellModel = menuArray[indexPath.row]
        selectionAction?(indexPath.row,cellModel.title ?? "title")
        animateRemoveView()
    }
    
}
