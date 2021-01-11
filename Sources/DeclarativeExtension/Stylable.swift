//
//  Stylable.swift
//  Layoutless
//
//  Created by finos.son.le on 11/01/2021.
//  Copyright © 2021 Declarative Hub. All rights reserved.
//

import Foundation

public protocol Stylable {
    associatedtype Base
    
    func style(_ base: Base)
}

extension Declarative {
    @discardableResult
    public func style(_ styleBlock: (Base) -> Void) -> Base {
        styleBlock(base)
        return base
    }
    
    @discardableResult
    public func style<StyleType: Stylable>(_ style: StyleType...) -> Base {
        style.forEach { (e) in
            if let base = base as? StyleType.Base {
                e.style(base)
            }
        }
        return base
    }
}
