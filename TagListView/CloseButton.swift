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

        // If path starts at the edge of the frame, we only see half the width of the first part of the stroke. (The other half is outside the bounds of the frame, and are cut off.) Pulling the path in from the edges by lineWidth/2 allows the edge to not be cut off.
        path.move(to: CGPoint(x: iconFrame.minX + lineWidth/2, y: iconFrame.minY + lineWidth/2))
        path.addLine(to: CGPoint(x: iconFrame.maxX - lineWidth/2, y: iconFrame.maxY - lineWidth/2))
        path.move(to: CGPoint(x: iconFrame.maxX - lineWidth/2, y: iconFrame.minY + lineWidth/2))
        path.addLine(to: CGPoint(x: iconFrame.minX + lineWidth/2, y: iconFrame.maxY - lineWidth/2))

        lineColor.setStroke()

        path.stroke()
    }

}
