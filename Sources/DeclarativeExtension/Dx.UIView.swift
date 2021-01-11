//
//  Dx.UIView.swift
//  Layoutless
//
//  Created by finos.son.le on 11/01/2021.
//  Copyright © 2021 Declarative Hub. All rights reserved.
//

import UIKit

extension UIView: DeclarativeCompatible { }

extension Declarative where Base: UIView {
    public func accessbilityID(id: String) -> Base {
        style { (it: UIView) in
            it.accessibilityIdentifier = id
        }
    }
    
    public func backgroundColor(color: UIColor) -> Base {
        style { (it: UIView) in
            it.backgroundColor = color
        }
    }
}
