//
//  TagListView.swift
//  TagListViewDemo
//
//  Created by Dongyuan Liu on 2015-05-09.
//  Copyright (c) 2015 Ela. All rights reserved.
//

import UIKit


@objc protocol TagListViewDelegate {
    optional func tagPressed(title: String) -> Void
}


@IBDesignable
public class TagListView: UIView {
    
    @IBInspectable public var textColor: UIColor = UIColor.whiteColor() {
        didSet {
            for tagView in tagViews {
                tagView.textColor = textColor
            }
        }
    }
    @IBInspectable public var tagBackgroundColor: UIColor = UIColor.blackColor() {
        didSet {
            for tagView in tagViews {
                tagView.backgroundColor = tagBackgroundColor
            }
        }
    }
    @IBInspectable public var cornerRadius: CGFloat = 0 {
        didSet {
            for tagView in tagViews {
                tagView.cornerRadius = cornerRadius
            }
        }
    }
    @IBInspectable public var borderWidth: CGFloat = 0 {
        didSet {
            for tagView in tagViews {
                tagView.borderWidth = borderWidth
            }
        }
    }
    @IBInspectable public var borderColor: UIColor? {
        didSet {
            for tagView in tagViews {
                tagView.borderColor = borderColor
            }
        }
    }
    @IBInspectable public var paddingY: CGFloat = 2 {
        didSet {
            for tagView in tagViews {
                tagView.paddingY = paddingY
            }
            layoutIfNeeded()
        }
    }
    @IBInspectable public var paddingX: CGFloat = 5 {
        didSet {
            for tagView in tagViews {
                tagView.paddingX = paddingX
            }
            layoutIfNeeded()
        }
    }
    @IBInspectable public var marginY: CGFloat = 2 {
        didSet {
            layoutIfNeeded()
        }
    }
    @IBInspectable public var marginX: CGFloat = 5 {
        didSet {
            layoutIfNeeded()
        }
    }
    public var textFont: UIFont = UIFont.systemFontOfSize(12) {
        didSet {
            for tagView in tagViews {
                tagView.textFont = textFont
            }
            layoutIfNeeded()
        }
    }
    
    @IBOutlet public var delegate: TagListViewDelegate?

    var tagViews: [TagView] = []
    var tagViewHeight: CGFloat = 0
    var rows = 0 {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    // MARK: - Interface Builder
    
    public override func prepareForInterfaceBuilder() {
        addTag("Welcome")
        addTag("to")
        addTag("TagListView")
    }
    
    // MARK: - Layout
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        for tagView in tagViews {
            tagView.removeFromSuperview()
        }
        
        var currentRow = 0
        var currentRowTagCount = 0
        var currentRowWidth: CGFloat = 0
        for tagView in tagViews {
            tagView.frame.size = tagView.intrinsicContentSize()
            tagViewHeight = tagView.frame.height
            
            if currentRowTagCount == 0 || currentRowWidth + tagView.frame.width + marginX > frame.width {
                currentRow += 1
                tagView.frame.origin.x = 0
                tagView.frame.origin.y = CGFloat(currentRow - 1) * (tagViewHeight + marginY)
                
                currentRowTagCount = 1
                currentRowWidth = tagView.frame.width + marginX
            }
            else {
                tagView.frame.origin.x = currentRowWidth
                tagView.frame.origin.y = CGFloat(currentRow - 1) * (tagViewHeight + marginY)
                
                currentRowTagCount += 1
                currentRowWidth += tagView.frame.width + marginX
            }
            
            addSubview(tagView)
        }
        rows = currentRow
    }
    
    // MARK: - Manage tags
    
    public override func intrinsicContentSize() -> CGSize {
        let height = CGFloat(rows) * (tagViewHeight + marginY) - marginY
        return CGSizeMake(frame.width, height)
    }
    
    public func addTag(title: String) {
        let tagView = TagView(title: title)

        tagView.textColor = textColor
        tagView.backgroundColor = tagBackgroundColor
        tagView.cornerRadius = cornerRadius
        tagView.borderWidth = borderWidth
        tagView.borderColor = borderColor
        tagView.paddingY = paddingY
        tagView.paddingX = paddingX
        tagView.textFont = textFont
        
        tagView.addTarget(self, action: "tagPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        
        addTagView(tagView)
    }
    
    private func addTagView(tagView: TagView) {
        tagViews.append(tagView)
        setNeedsLayout()
    }
    
    public func removeTag(title: String) {
        for (index, tagView) in enumerate(tagViews) {
            if tagView.currentTitle == title {
                tagView.removeFromSuperview()
                tagViews.removeAtIndex(index)
            }
        }
        setNeedsLayout()
    }
    
    public func removeAllTags() {
        for tagView in tagViews {
            tagView.removeFromSuperview()
        }
        tagViews = []
        setNeedsLayout()
    }
    
    // MARK: - Events
    
    func tagPressed(sender: UIButton!) {
        if let delegate = delegate, tagPressed = delegate.tagPressed {
            tagPressed(sender.currentTitle ?? "")
        }
    }

}
