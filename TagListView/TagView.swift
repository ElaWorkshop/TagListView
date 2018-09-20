//
//  TagView.swift
//  TagListViewDemo
//
//  Created by Dongyuan Liu on 2015-05-09.
//  Copyright (c) 2015 Ela. All rights reserved.
//

import UIKit

@IBDesignable
open class TagView: UIButton {
    
    private let borderView = UIView()
    
    @IBInspectable open var cornerRadius: CGFloat = 0 {
        didSet {
            borderView.layer.cornerRadius = cornerRadius
//            borderView.layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable open var borderWidth: CGFloat = 0 {
        didSet {
            borderView.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable open var borderColor: UIColor? {
        didSet {
            reloadStyles()
        }
    }
    
    @IBInspectable open var textColor: UIColor = UIColor.white {
        didSet {
            reloadStyles()
        }
    }
    @IBInspectable open var selectedTextColor: UIColor = UIColor.white {
        didSet {
            reloadStyles()
        }
    }
    @IBInspectable open var titleLineBreakMode: NSLineBreakMode = .byTruncatingMiddle {
        didSet {
            titleLabel?.lineBreakMode = titleLineBreakMode
        }
    }
    @IBInspectable open var paddingY: CGFloat = 2 {
        didSet {
            titleEdgeInsets.top = paddingY
            titleEdgeInsets.bottom = paddingY
        }
    }
    @IBInspectable open var paddingX: CGFloat = 5 {
        didSet {
            titleEdgeInsets.left = paddingX
            updateRightInsets()
        }
    }
    
    @IBInspectable open var tagBackgroundColor: UIColor = UIColor.gray {
        didSet {
            reloadStyles()
        }
    }
    
    @IBInspectable open var highlightedBackgroundColor: UIColor? {
        didSet {
            reloadStyles()
        }
    }
    
    @IBInspectable open var selectedBorderColor: UIColor? {
        didSet {
            reloadStyles()
        }
    }
    
    @IBInspectable open var selectedBackgroundColor: UIColor? {
        didSet {
            reloadStyles()
        }
    }
    
    @IBInspectable open var textFont: UIFont = UIFont.systemFont(ofSize: 12) {
        didSet {
            titleLabel?.font = textFont
        }
    }
    
    private func reloadStyles() {
        if isHighlighted {
            if let highlightedBackgroundColor = highlightedBackgroundColor {
                // For highlighted, if it's nil, we should not fallback to backgroundColor.
                // Instead, we keep the current color.
                backgroundColor = highlightedBackgroundColor
            }
        }
        else if isSelected {
            backgroundColor = selectedBackgroundColor ?? tagBackgroundColor
            borderView.layer.borderColor = selectedBorderColor?.cgColor ?? borderColor?.cgColor
            setTitleColor(selectedTextColor, for: UIControl.State())
        }
        else if ishotKeyWordEnabled{
            hotKeyWordIcon.isHidden = !ishotKeyWordEnabled
            self.textFont = UIFont.boldSystemFont(ofSize: 12)
            backgroundColor = tagBackgroundColor
            borderView.layer.borderColor = borderColor?.cgColor
            setTitleColor(textColor, for: UIControl.State())
            
        }
        else {
            backgroundColor = tagBackgroundColor
            borderView.layer.borderColor = borderColor?.cgColor
            setTitleColor(textColor, for: UIControl.State())
        }
    }
    
    override open var isHighlighted: Bool {
        didSet {
            reloadStyles()
        }
    }
    
    override open var isSelected: Bool {
        didSet {
            reloadStyles()
        }
    }
    
    //MARK : higlited icon
    
    @IBInspectable open  var hotKeyWordIcon: UIImageView = UIImageView(image: UIImage(named: "orionFlame")){
        didSet{
            reloadStyles()
        }
    }
    @IBInspectable open  var ishotKeyWordEnabled: Bool = true{
        didSet{
            reloadStyles()
        }
    }
    
    
    // MARK: remove button
    
    let removeButton = CloseButton()
    
    @IBInspectable open var enableRemoveButton: Bool = false {
        didSet {
            removeButton.isHidden = !enableRemoveButton
            updateRightInsets()
        }
    }
    
    @IBInspectable open var enableHighlightIcon: Bool = false {
        didSet {
            removeButton.isHidden = !enableRemoveButton
            updateRightInsets()
        }
    }
    
    
    @IBInspectable open var removeButtonIconSize: CGFloat = 12 {
        didSet {
            removeButton.iconSize = removeButtonIconSize
            updateRightInsets()
        }
    }
    
    @IBInspectable open var removeIconLineWidth: CGFloat = 3 {
        didSet {
            removeButton.lineWidth = removeIconLineWidth
        }
    }
    @IBInspectable open var removeIconLineColor: UIColor = UIColor.white.withAlphaComponent(0.54) {
        didSet {
            removeButton.lineColor = removeIconLineColor
        }
    }
    
    /// Handles Tap (TouchUpInside)
    open var onTap: ((TagView) -> Void)?
    open var onLongPress: ((TagView) -> Void)?
    
    // MARK: - init
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    public init(title: String) {
        super.init(frame: CGRect.zero)
        setTitle(title, for: UIControl.State())
        
        setupView()
    }
    
    
    public init(title: String , isHotKeyword:Bool) {
        super.init(frame: CGRect.zero)
        setTitle(title, for: UIControl.State())
        ishotKeyWordEnabled = isHotKeyword
        hotKeyWordIcon.isHidden = !ishotKeyWordEnabled

        setupView()
    }
    
    
    
    private func setupView() {
        titleLabel?.lineBreakMode = titleLineBreakMode
        
        frame.size = intrinsicContentSize
        addSubview(removeButton)
        
        borderView.layer.borderColor = borderColor?.cgColor
        borderView.layer.borderWidth = borderWidth
        borderView.layer.cornerRadius = cornerRadius
        borderView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        borderView.frame = bounds
        addSubview(borderView)
        hotKeyWordIcon.backgroundColor = UIColor.white
        
        addSubview(hotKeyWordIcon)
        
        removeButton.tagView = self
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress))
        self.addGestureRecognizer(longPress)
    }
    
    @objc func longPress() {
        onLongPress?(self)
    }
    
    //    override open func draw(_ rect: CGRect) {
    //        UIColor.gray.set()
    //        UIBezierPath(rect: rect).stroke()
    //    }
    
    
    // MARK: - layout
    
    override open var intrinsicContentSize: CGSize {
        var size = titleLabel?.text?.size(withAttributes: [NSAttributedString.Key.font: textFont]) ?? CGSize.zero
        size.height = textFont.pointSize + paddingY * 2
        size.width += paddingX * 2
        if size.width < size.height {
            size.width = size.height
        }
        if enableRemoveButton {
            size.width += removeButtonIconSize + paddingX
        }
//        if ishotKeyWordEnabled {
//            size.height +=  10
//
//        }
        return size
    }
    
    private func updateRightInsets() {
        if enableRemoveButton {
            titleEdgeInsets.right = paddingX  + removeButtonIconSize + paddingX
        }
        else {
            titleEdgeInsets.right = paddingX
        }
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        if enableRemoveButton {
            removeButton.frame.size.width = paddingX + removeButtonIconSize + paddingX
            removeButton.frame.origin.x = self.frame.width - removeButton.frame.width
            removeButton.frame.size.height = self.frame.height
            removeButton.frame.origin.y = 0
        }
        
        if ishotKeyWordEnabled {
            hotKeyWordIcon.frame.size.width = 12
            hotKeyWordIcon.frame.size.height = 14
            hotKeyWordIcon.frame.origin.x = self.frame.origin.x + 5
            hotKeyWordIcon.frame.origin.y = self.frame.origin.y - 5
        }
    }
}

/// Swift < 4.2 support
#if !(swift(>=4.2))
private extension NSAttributedString {
typealias Key = NSAttributedStringKey
}
private extension UIControl {
typealias State = UIControlState
}
#endif
