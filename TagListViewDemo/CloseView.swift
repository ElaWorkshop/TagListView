//
//  CloseView.swift
//  TagListViewDemo
//
//  Created by Benjamin Wu on 2/11/16.
//  Copyright © 2016 Ela. All rights reserved.
//

import UIKit

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