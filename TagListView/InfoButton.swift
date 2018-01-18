//
//  InfoButton.swift
//  Lokus
//
//  Created by João Borges on 18/01/2018.
//  Copyright © 2018 mobinteg. All rights reserved.
//

import Foundation

internal class InfoButton: UIButton {
    
    var iconSize: CGFloat = 15
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
        
        path.move(to: iconFrame.origin)
        path.addLine(to: CGPoint(x: iconFrame.maxX, y: iconFrame.maxY))
        path.move(to: CGPoint(x: iconFrame.maxX, y: iconFrame.minY))
        path.addLine(to: CGPoint(x: iconFrame.minX, y: iconFrame.maxY))
        
        lineColor.setStroke()
        
        path.stroke()
    }
}
