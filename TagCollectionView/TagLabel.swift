//
//  TagLabel.swift
//  TagCollectionView
//
//  Created by Alexey Donov on 07.08.16.
//  Copyright © 2016 Alexey Donov. All rights reserved.
//

import UIKit

class TagLabel: UILabel {

    var edgeInsets: UIEdgeInsets
    
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = (newValue > 0)
        }
    }
    
    override init(frame: CGRect) {
        edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        edgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        super.init(coder: aDecoder)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: UIEdgeInsetsInsetRect(rect, edgeInsets))
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += edgeInsets.left + edgeInsets.right
        contentSize.height += edgeInsets.top + edgeInsets.bottom
        return contentSize
    }

}
