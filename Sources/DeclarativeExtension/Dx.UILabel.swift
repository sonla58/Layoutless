//
//  Dx+UILabel.swift
//  Layoutless
//
//  Created by finos.son.le on 11/01/2021.
//  Copyright © 2021 Declarative Hub. All rights reserved.
//

import Foundation

extension Declarative where Base: UILabel {
    @discardableResult
    public func text(_ text: TextContent) -> Base {
        style { (it: UILabel) in
            switch text {
            case .string(let value):
                it.text = value
            case .atributedString(let value):
                it.attributedText = value
            }
        }
    }
    
    public func color(_ color: UIColor) -> Base {
        style { (it: UILabel) in
            it.textColor = color
        }
    }
    
    public func font(_ font: UIFont) -> Base {
        style { (it: UILabel) in
            it.font = font
        }
    }
}

public enum TextContent {
    case string(String)
    case atributedString(NSAttributedString)
}

extension TextContent: ExpressibleByStringLiteral {
    public init(stringLiteral value: String) {
        self = .string(value)
    }
}
