//
//  CloseButton.swift
//  TagListViewDemo
//
//  Created by Benjamin Wu on 2/11/16.
//  Copyright © 2016 Ela. All rights reserved.
//

import UIKit

internal class CloseButton: UIButton {

    var iconSize: CGFloat = 10
    var lineWidth: CGFloat = 1
    var lineColor: UIColor = UIColor.whiteColor().colorWithAlphaComponent(0.54)

    weak var tagView: TagView?

    override func drawRect(rect: CGRect) {
        let path = UIBezierPath()

        path.lineWidth = lineWidth
        path.lineCapStyle = .Round

        let iconFrame = CGRect(
            x: (rect.width - iconSize) / 2.0,
            y: (rect.height - iconSize) / 2.0,
            width: iconSize,
            height: iconSize
        )

        path.moveToPoint(iconFrame.origin)
        path.addLineToPoint(CGPoint(x: iconFrame.maxX, y: iconFrame.maxY))
        path.moveToPoint(CGPoint(x: iconFrame.maxX, y: iconFrame.minY))
        path.addLineToPoint(CGPoint(x: iconFrame.minX, y: iconFrame.maxY))

        lineColor.setStroke()

        path.stroke()
    }

}
