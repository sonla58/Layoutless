//
//  ForEach.swift
//  Layoutless
//
//  Created by finos.son.le on 11/01/2021.
//  Copyright © 2021 Declarative Hub. All rights reserved.
//

import UIKit

public struct ForEach<Item> {
    public var layouts: [AnyLayout]
    public var items: [Item]
    
    public init(_ items: [Item], layouts: [AnyLayout]) {
        self.items = items
        self.layouts = layouts
    }
    
    public init(_ items: [Item], @LayoutBuilder layoutBuilder: (Int, Item) -> [AnyLayout]) {
        self.items = items
        self.layouts = items.enumerated().reduce([AnyLayout](), { (seed, next) -> [AnyLayout] in
            seed + layoutBuilder(next.offset, next.element)
        })
    }
}

extension ForEach: LayoutProtocol {
    public func makeLayoutNode(_ compositeRevertable: Revertable) -> LayoutGroup {
        Layout { revertable in
            return LayoutGroup(layouts)
        }
        .makeLayoutNode(compositeRevertable)
    }
}
