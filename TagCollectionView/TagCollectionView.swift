//
//  TagCollectionView.swift
//  TagCollectionView
//
//  Created by Alexey Donov on 07.08.16.
//  Copyright © 2016 Alexey Donov. All rights reserved.
//

import UIKit

@IBDesignable
open class TagCollectionView: UIView {
    
    // MARK: API

    open dynamic var tags = [Tag]() {
        didSet {
            rebuildLabels()
        }
    }
    
    @IBInspectable
    open dynamic var tagFont: UIFont = UIFont.systemFont(ofSize: UIFont.labelFontSize) {
        didSet {
            layoutLabels()
        }
    }
    
    @IBInspectable
    open dynamic var tagTextColor: UIColor? {
        didSet {
            updateLabels()
        }
    }
    
    @IBInspectable
    open dynamic var tagBackgroundColor: UIColor? {
        didSet {
            updateLabels()
        }
    }
    
    @IBInspectable
    open dynamic var tagCornerRadius: CGFloat = 0 {
        didSet {
            updateLabels()
        }
    }
    
    @IBInspectable
    open dynamic var autoCornerRadius: Bool = true {
        didSet {
            updateLabels()
        }
    }
    
    @IBInspectable
    open dynamic var tagSpacing: CGFloat = 8 {
        didSet {
            layoutLabels()
        }
    }
    
    @IBInspectable
    open dynamic var rowSpacing: CGFloat = 8 {
        didSet {
            layoutLabels()
        }
    }
    
    // MARK: Implementation
    
    fileprivate var tagViews = [TagLabel]()
    
    fileprivate var tagViewCount: Int {
        get {
            return tagViews.count
        }
        set {
            if newValue == tagViews.count {
                return
            }
            if newValue < 0 {
                return
            }
            if newValue < tagViews.count {
                while tagViews.count > newValue {
                    tagViews[0].removeFromSuperview()
                    tagViews.removeFirst()
                }
            }
            if newValue > tagViews.count {
                while tagViews.count < newValue {
                    let tagView = TagLabel()
                    addSubview(tagView)
                    tagViews.append(tagView)
                }
            }
        }
    }
    
    fileprivate var calculatedHeight: CGFloat = 0 {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    fileprivate func rebuildLabels() {
        tagViewCount = tags.count
        
        for (index, tag) in tags.enumerated() {
            let tagLabel = tagViews[index]
            tagLabel.text = tag.name
            tagLabel.font = tagFont
            tagLabel.textColor = tag.textColor ?? tagTextColor ?? UIColor.white
            tagLabel.backgroundColor = tag.backgroundColor ?? tagBackgroundColor ?? tintColor
            tagLabel.cornerRadius = tagCornerRadius
        }
        
        setNeedsLayout()
    }
    
    fileprivate func layoutLabels() {
        var x: CGFloat = 0
        var y: CGFloat = 0
        var lastRowHeight: CGFloat = 0
        
        for tagLabel in tagViews {
            var cornerRadius: CGFloat = tagCornerRadius
            if autoCornerRadius {
                cornerRadius = tagLabel.intrinsicContentSize.height / 2
            }
            tagLabel.cornerRadius = cornerRadius
            tagLabel.edgeInsets = UIEdgeInsets(top: 0, left: cornerRadius, bottom: 0, right: cornerRadius)

            let tagViewSize = tagLabel.intrinsicContentSize
            
            if x + tagViewSize.width + tagSpacing > bounds.width {
                x = 0
                y += tagViewSize.height + rowSpacing
            }
            
            tagLabel.frame = CGRect(origin: CGPoint(x: x, y: y), size: tagViewSize)
            
            x += tagViewSize.width + tagSpacing
            lastRowHeight = tagViewSize.height
        }
        
        calculatedHeight = y + lastRowHeight
    }
    
    fileprivate func updateLabels() {
        for (index, tagLabel) in tagViews.enumerated() {
            let tag = tags[index]
            tagLabel.textColor = tag.textColor ?? tagTextColor ?? UIColor.white
            tagLabel.backgroundColor = tag.backgroundColor ?? tagBackgroundColor ?? tintColor
        }
    }
    
    // MARK: Layout
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        layoutLabels()
    }
    
    open override func prepareForInterfaceBuilder() {
        tags = [Tag(name: "TagCollectionView"), Tag(name: "Taggy"), Tag(name: "McTagface")]
    }
    
    open override var intrinsicContentSize : CGSize {
        var size = bounds.size
        size.height = calculatedHeight
        return size
    }

}
