//
//  Dx.UIButton.swift
//  Layoutless
//
//  Created by finos.son.le on 11/01/2021.
//  Copyright © 2021 Declarative Hub. All rights reserved.
//

import Foundation

extension Declarative where Base: UIButton {
    public func title(_ title: TextContent) -> Base {
        style { (it) in
            switch title {
            case .string(let str):
                it.setTitle(str, for: .normal)
            case .atributedString(let attr):
                it.setAttributedTitle(attr, for: .normal)
            }
        }
    }
}
