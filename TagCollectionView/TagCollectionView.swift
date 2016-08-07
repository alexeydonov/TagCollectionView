//
//  TagCollectionView.swift
//  TagCollectionView
//
//  Created by Alexey Donov on 07.08.16.
//  Copyright © 2016 Alexey Donov. All rights reserved.
//

import UIKit

@IBDesignable
public class TagCollectionView: UIView {
    
    // MARK: API

    public dynamic var tags = [Tag]() {
        didSet {
            rebuildLabels()
        }
    }
    
    @IBInspectable
    public dynamic var tagFont: UIFont = UIFont.systemFontOfSize(UIFont.labelFontSize()) {
        didSet {
            layoutLabels()
        }
    }
    
    @IBInspectable
    public dynamic var tagTextColor: UIColor? {
        didSet {
            updateLabels()
        }
    }
    
    @IBInspectable
    public dynamic var tagBackgroundColor: UIColor? {
        didSet {
            updateLabels()
        }
    }
    
    @IBInspectable
    public dynamic var tagCornerRadius: CGFloat = 0 {
        didSet {
            updateLabels()
        }
    }
    
    @IBInspectable
    public dynamic var autoCornerRadius: Bool = true {
        didSet {
            updateLabels()
        }
    }
    
    @IBInspectable
    public dynamic var tagSpacing: CGFloat = 8 {
        didSet {
            layoutLabels()
        }
    }
    
    @IBInspectable
    public dynamic var rowSpacing: CGFloat = 8 {
        didSet {
            layoutLabels()
        }
    }
    
    // MARK: Implementation
    
    private var tagViews = [TagLabel]()
    
    private var tagViewCount: Int {
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
    
    private var calculatedHeight: CGFloat = 0 {
        didSet {
            invalidateIntrinsicContentSize()
        }
    }
    
    private func rebuildLabels() {
        tagViewCount = tags.count
        
        print("New label count = \(tagViewCount)")
        
        for (index, tag) in tags.enumerate() {
            let tagLabel = tagViews[index]
            tagLabel.text = tag.name
            tagLabel.font = tagFont
            tagLabel.textColor = tag.textColor ?? tagTextColor ?? UIColor.whiteColor()
            tagLabel.backgroundColor = tag.backgroundColor ?? tagBackgroundColor ?? tintColor
            tagLabel.cornerRadius = tagCornerRadius
        }
        
        setNeedsLayout()
    }
    
    private func layoutLabels() {
        var x: CGFloat = 0
        var y: CGFloat = 0
        var lastRowHeight: CGFloat = 0
        
        for tagLabel in tagViews {
            var cornerRadius: CGFloat = tagCornerRadius
            if autoCornerRadius {
                cornerRadius = tagLabel.intrinsicContentSize().height / 2
            }
            tagLabel.cornerRadius = cornerRadius
            tagLabel.edgeInsets = UIEdgeInsets(top: 0, left: cornerRadius, bottom: 0, right: cornerRadius)

            let tagViewSize = tagLabel.intrinsicContentSize()
            
            if x + tagViewSize.width + tagSpacing > bounds.width {
                x = 0
                y += tagViewSize.height + rowSpacing
            }
            
            tagLabel.frame = CGRect(origin: CGPointMake(x, y), size: tagViewSize)
            
            x += tagViewSize.width + tagSpacing
            lastRowHeight = tagViewSize.height
        }
        
        calculatedHeight = y + lastRowHeight
    }
    
    private func updateLabels() {
        for (index, tagLabel) in tagViews.enumerate() {
            let tag = tags[index]
            tagLabel.textColor = tag.textColor ?? tagTextColor ?? UIColor.whiteColor()
            tagLabel.backgroundColor = tag.backgroundColor ?? tagBackgroundColor ?? tintColor
        }
    }
    
    // MARK: Layout
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        layoutLabels()
    }
    
    public override func prepareForInterfaceBuilder() {
        tags = [Tag(name: "TagCollectionView"), Tag(name: "Taggy"), Tag(name: "McTagface")]
    }
    
    public override func intrinsicContentSize() -> CGSize {
        var size = bounds.size
        size.height = calculatedHeight
        print("Intrinsic content size = \(size)")
        return size
    }

}
