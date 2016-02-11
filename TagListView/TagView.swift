//
//  TagView.swift
//  TagListViewDemo
//
//  Created by Dongyuan Liu on 2015-05-09.
//  Copyright (c) 2015 Ela. All rights reserved.
//

import UIKit

@IBDesignable
public class TagView: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.CGColor
        }
    }
    @IBInspectable var textColor: UIColor = UIColor.whiteColor() {
        didSet {
            setTitleColor(textColor, forState: .Normal)
        }
    }
    @IBInspectable var selectedTextColor: UIColor = UIColor.whiteColor() {
        didSet {
            setTitleColor(selected ? selectedTextColor : textColor, forState: .Normal)
        }
    }
    @IBInspectable var paddingY: CGFloat = 2 {
        didSet {
            titleEdgeInsets.top = paddingY
            titleEdgeInsets.bottom = paddingY
        }
    }
    @IBInspectable var paddingX: CGFloat = 5 {
        didSet {
            titleEdgeInsets.left = paddingX
            updateRightInsets()
        }
    }

    @IBInspectable public var tagBackgroundColor: UIColor = UIColor.grayColor() {
        didSet {
            backgroundColor = tagBackgroundColor
        }
    }
    
    @IBInspectable public var tagSelectedBackgroundColor: UIColor = UIColor.redColor() {
        didSet {
            backgroundColor = selected ? tagSelectedBackgroundColor : tagBackgroundColor
        }
    }
    
    var textFont: UIFont = UIFont.systemFontOfSize(12) {
        didSet {
            titleLabel?.font = textFont
        }
    }
    
    override public var selected: Bool {
        didSet {
            if selected {
                backgroundColor = tagSelectedBackgroundColor
                setTitleColor(selectedTextColor, forState: .Normal)
            } else {
                backgroundColor = tagBackgroundColor
                setTitleColor(textColor, forState: .Normal)
            }
        }
    }
    
    // MARK: remove button
    
    let removeButton = CloseButton()
    
    @IBInspectable var enableRemoveButton: Bool = false {
        didSet {
            removeButton.hidden = !enableRemoveButton
            updateRightInsets()
        }
    }
    
    @IBInspectable var removeButtonSize: CGFloat = 12 {
        didSet {
            removeButton.iconSize = removeButtonSize
            updateRightInsets()
        }
    }
    
    @IBInspectable var removeIconLineWidth: CGFloat = 3 {
        didSet {
            removeButton.lineWidth = removeIconLineWidth
        }
    }
    @IBInspectable var removeIconLineColor: UIColor = UIColor.whiteColor().colorWithAlphaComponent(0.54) {
        didSet {
            removeButton.lineColor = removeIconLineColor
        }
    }
    
    /// Handles Tap (TouchUpInside)
    public var onTap: ((TagView) -> Void)?
    
    // MARK: - init
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    init(title: String) {
        super.init(frame: CGRectZero)
        setTitle(title, forState: .Normal)
        
        setupView()
    }
    
    private func setupView() {
        frame.size = intrinsicContentSize()
        addSubview(removeButton)
        removeButton.tagView = self
    }
    
    // MARK: - layout

    private func updateRightInsets() {
        if enableRemoveButton {
            titleEdgeInsets.right = paddingX  + removeButtonSize + paddingX
        }
        else {
            titleEdgeInsets.right = paddingX
        }
    }
    
    override public func intrinsicContentSize() -> CGSize {
        var size = titleLabel?.text?.sizeWithAttributes([NSFontAttributeName: textFont]) ?? CGSizeZero
        size.height = textFont.pointSize + paddingY * 2
        size.width += paddingX * 2
        if enableRemoveButton {
            size.width += removeButtonSize + paddingX
        }
        return size
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if enableRemoveButton {
            removeButton.frame.size.width = paddingX + removeButtonSize + paddingX
            removeButton.frame.origin.x = self.frame.width - removeButton.frame.width
            removeButton.frame.size.height = self.frame.height
            removeButton.frame.origin.y = 0
        }
    }
}


class CloseButton: UIButton {

    var closeView = DrawCloseView()

    var iconSize: CGFloat = 10
    var lineWidth: CGFloat = 1 {
        didSet {
            closeView.lineWidth = lineWidth
        }
    }
    var lineColor: UIColor = UIColor.whiteColor().colorWithAlphaComponent(0.54) {
        didSet {
            closeView.lineColor = lineColor
        }
    }

    weak var tagView: TagView?
    
    init() {
        super.init(frame: CGRectZero)
        setup()
        closeView.backgroundColor = UIColor.clearColor()
        closeView.userInteractionEnabled = false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(closeView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        closeView.frame.size = CGSize(width: iconSize, height: iconSize)
        closeView.center = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
    }
}

public class DrawCloseView: UIView {
    
    var lineWidth: CGFloat = 1

    var lineColor = UIColor.whiteColor().colorWithAlphaComponent(0.54)
    
    public override func drawRect(rect: CGRect) {
        let path = UIBezierPath()
        
        path.lineWidth = lineWidth
        path.lineCapStyle = .Round
        
        path.moveToPoint(CGPoint(x: 0, y: 0))
        path.addLineToPoint(CGPoint(x: rect.width, y: rect.height))
        path.moveToPoint(CGPoint(x: rect.width, y: 0))
        path.addLineToPoint(CGPoint(x: 0, y: rect.height))
        
        lineColor.setStroke()
        
        path.stroke()
    }
}