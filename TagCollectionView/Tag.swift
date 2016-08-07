//
//  Tag.swift
//  TagCollectionView
//
//  Created by Alexey Donov on 07.08.16.
//  Copyright © 2016 Alexey Donov. All rights reserved.
//

import Foundation

public class Tag: NSObject {
    
    public var name: String
    
    public var textColor: UIColor?
    public var backgroundColor: UIColor?
    
    public init(name: String, textColor: UIColor? = nil, backgroundColor: UIColor? = nil) {
        self.name = name
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
    
}