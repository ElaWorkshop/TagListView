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
    
    @IBInspectable public var tagHighlightedBackgroundColor: UIColor? {
        didSet {
            if let color = tagHighlightedBackgroundColor where highlighted {
                backgroundColor = color
            }
            else {
                backgroundColor = tagBackgroundColor
            }
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
    
    override public var highlighted: Bool {
        didSet {
            if let color = tagHighlightedBackgroundColor where highlighted {
                backgroundColor = color
            }
            else {
                backgroundColor = selected ? tagSelectedBackgroundColor : tagBackgroundColor
            }
        }
    }
    
    override public var selected: Bool {
        didSet {
            if selected {
                backgroundColor = tagSelectedBackgroundColor
                setTitleColor(selectedTextColor, forState: .Normal)
            }
            else {
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
    
    @IBInspectable var removeButtonIconSize: CGFloat = 12 {
        didSet {
            removeButton.iconSize = removeButtonIconSize
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
    
    public init(title: String) {
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
            titleEdgeInsets.right = paddingX  + removeButtonIconSize + paddingX
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
            size.width += removeButtonIconSize + paddingX
        }
        return size
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        if enableRemoveButton {
            removeButton.frame.size.width = paddingX + removeButtonIconSize + paddingX
            removeButton.frame.origin.x = self.frame.width - removeButton.frame.width
            removeButton.frame.size.height = self.frame.height
            removeButton.frame.origin.y = 0
        }
    }
}
