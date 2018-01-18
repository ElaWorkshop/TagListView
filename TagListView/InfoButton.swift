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
}
