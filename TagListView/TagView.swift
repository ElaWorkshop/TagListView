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
    @IBInspectable var paddingTop: CGFloat = 2 {
        didSet {
            titleEdgeInsets.top = paddingTop
        }
    }
    @IBInspectable var paddingLeft: CGFloat = 5 {
        didSet {
            titleEdgeInsets.left = paddingLeft
        }
    }
    @IBInspectable var paddingBottom: CGFloat = 2 {
        didSet {
            titleEdgeInsets.bottom = paddingBottom
        }
    }
    @IBInspectable var paddingRight: CGFloat = 5 {
        didSet {
            titleEdgeInsets.right = paddingRight
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
    }
    
    // MARK: - layout
    
    override public func intrinsicContentSize() -> CGSize {
        var size = titleLabel?.text?.sizeWithAttributes([NSFontAttributeName: textFont]) ?? CGSizeZero
        
        size.height = textFont.pointSize + paddingTop + paddingBottom
        size.width += paddingLeft + paddingRight
        
        return size
    }
}
