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
    var lineColor: UIColor = UIColor.white.withAlphaComponent(0.54)

    weak var tagView: TagView?

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()

        path.lineWidth = lineWidth
        path.lineCapStyle = .round

        let iconFrame = CGRect(
            x: (rect.width - iconSize) / 2.0,
            y: (rect.height - iconSize) / 2.0,
            width: iconSize,
            height: iconSize
        )

        // lineWidth/2 is so the edge of the stroke is not cut off
        path.move(to: CGPoint(x: iconFrame.minX + lineWidth/2, y: iconFrame.minY + lineWidth/2))
        path.addLine(to: CGPoint(x: iconFrame.maxX - lineWidth/2, y: iconFrame.maxY - lineWidth/2))
        path.move(to: CGPoint(x: iconFrame.maxX - lineWidth/2, y: iconFrame.minY + lineWidth/2))
        path.addLine(to: CGPoint(x: iconFrame.minX + lineWidth/2, y: iconFrame.maxY - lineWidth/2))

        lineColor.setStroke()

        path.stroke()
    }

}
