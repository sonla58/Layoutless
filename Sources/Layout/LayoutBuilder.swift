//
//  LayoutBuilder.swift
//  Layoutless
//
//  Created by finos.son.le on 11/01/2021.
//  Copyright © 2021 Declarative Hub. All rights reserved.
//

import Foundation

@_functionBuilder
public struct LayoutBuilder {
    
    public typealias Expression = AnyLayout
    public typealias Component = [AnyLayout]
    
    public static func buildBlock(_ layouts: Component...) -> Component {
        layouts.flatMap { $0 }
    }
    
    public static func buildExpression(_ layout: Expression) -> Component {
        [layout]
    }
    
    public static func buildExpression(_ layouts: Component) -> Component {
        layouts
    }
    
    public static func buildIf(_ layouts: Component?) -> Component {
        layouts ?? []
    }
    
    public static func buildEither(first layout: Component) -> Component {
        layout
    }
    
    public static func buildEither(second layout: Component) -> Component {
        layout
    }
}
