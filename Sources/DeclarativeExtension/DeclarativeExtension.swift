//
//  DeclarativeExtension.swift
//  Layoutless
//
//  Created by finos.son.le on 11/01/2021.
//  Copyright © 2021 Declarative Hub. All rights reserved.
//

import Foundation

public struct Declarative<Base> {
    public let base: Base
    
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol DeclarativeCompatible {
    associatedtype DeclarativeBase
    
    /// Declarative extension
    var dx: Declarative<DeclarativeBase> { get set }
}

extension DeclarativeCompatible {
    public var dx: Declarative<Self> {
        get {
            Declarative(self)
        }
        
        // swiftlint:disable:next unused_setter_value
        set { }
    }
}

extension Declarative {
    @discardableResult
    public func storeReference(refStore: inout Base?) -> Base {
        if refStore != nil {
            return refStore!
        }
        refStore = base
        return base
    }
}
