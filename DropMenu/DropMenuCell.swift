//
//  DropMenuCell.swift
//  DropMenu
//
//  Created by song on 2020/8/4.
//

import UIKit

class DropMenuCell: UITableViewCell {
    
    lazy var menuImageView: UIImageView = self.makeMenuImageView()
    lazy var menuTitleLabel: UILabel = self.makeMenuTitleLable()
    
    
    var lineColor: UIColor = .white
    
    var isFinalCell = false {
        didSet {
            if isFinalCell {
                lineLayer?.removeFromSuperlayer()
            }else {
                drawLineSep()
            }
        }
    }
    
    fileprivate var selectedBgView: UIView?
    fileprivate var lineLayer: CALayer?
    
    var menuModel: DropMenuModel? {
        didSet {
            guard let menuModel = menuModel else { return }
            if (menuModel.image != nil) {
                menuImageView.isHidden = false
                menuImageView.image = menuModel.image
                menuImageView.frame = CGRect(x: Config.menuContentMargin, y: (self.bounds.size.height - Config.menuImageWidth)*0.5, width: Config.menuImageWidth, height: Config.menuImageWidth)
                menuTitleLabel.frame = CGRect(x: Config.menuContentMargin * 2 + Config.menuImageWidth, y: 0, width: self.bounds.size.width - (Config.menuContentMargin * 3 + Config.menuImageWidth), height: self.bounds.size.height)
            }else {
                menuImageView.isHidden = true
                menuTitleLabel.frame = CGRect(x: Config.menuContentMargin, y: 0, width: self.bounds.size.width - Config.menuContentMargin * 2, height: self.bounds.size.height)
            }
            menuTitleLabel.text = menuModel.title
            
        }
    }
    
    var dropMenuStyle: DropMenuStyle? {
        didSet {
            guard let style = dropMenuStyle else { return }
            switch style {
            case .MenuDarkStyle:
                selectedBgView?.backgroundColor = UIColor.black.withAlphaComponent(0.2)
                menuTitleLabel.textColor = .white
                lineColor = .white
            case .MenuLightStyle:
                selectedBgView?.backgroundColor = UIColor.groupTableViewBackground
                menuTitleLabel.textColor = .black
                lineColor = .lightGray
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    private func makeMenuImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }
    
    private func makeMenuTitleLable() -> UILabel {
        let titleLablel = UILabel()
        titleLablel.font = UIFont.systemFont(ofSize: Config.menuTitleFontSize)
        return titleLablel
    }
    
    
    private func setupUI() {
        backgroundColor = .clear
        selectedBgView = UIView(frame: bounds)
        selectedBackgroundView = selectedBgView
        addSubview(menuImageView)
        addSubview(menuTitleLabel)
        
    }
    
    private func drawLineSep() {
        let lineLayer = CAShapeLayer()
        lineLayer.strokeColor = lineColor.cgColor
        lineLayer.frame = bounds
        lineLayer.lineWidth = 0.5
        let sepline = UIBezierPath()
        sepline.move(to: CGPoint(x: Config.menuContentMargin, y: bounds.size.height - lineLayer.lineWidth))
        sepline.addLine(to: CGPoint(x: bounds.size.width - Config.menuContentMargin, y: bounds.size.height - lineLayer.lineWidth))
        lineLayer.path = sepline.cgPath
        layer.addSublayer(lineLayer)
        self.lineLayer = lineLayer
    }
    
}
