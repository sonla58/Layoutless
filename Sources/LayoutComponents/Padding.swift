//
//  Pading.swift
//  Layoutless
//
//  Created by finos.son.le on 11/01/2021.
//  Copyright © 2021 Declarative Hub. All rights reserved.
//

import Foundation

public struct Padding {
    public var layouts: [AnyLayout]
    public var container: UIView
    public var insets: UIEdgeInsets
    var isSafeArea: Bool
    
    public init(_ container: UIView = UIView(), safeArea: Bool = false, insets: UIEdgeInsets, configure: @escaping (UIView) -> Void = {_ in}, layouts: [AnyLayout]) {
        self.container = container
        self.insets = insets
        self.isSafeArea = safeArea
        configure(container)
        self.layouts = layouts
    }
    
    public init(_ container: UIView = UIView(), safeArea: Bool = false,insets: UIEdgeInsets, configure: @escaping (UIView) -> Void = {_ in}, @LayoutBuilder layoutBuilder: () -> [AnyLayout]) {
        self.container = container
        self.insets = insets
        self.isSafeArea = safeArea
        configure(container)
        self.layouts = layoutBuilder()
    }
    
    public init(_ container: UIView = UIView(), safeArea: Bool = false, inset: CGFloat, configure: @escaping (UIView) -> Void = {_ in}, @LayoutBuilder layoutBuilder: () -> [AnyLayout]) {
        self.container = container
        self.insets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        self.isSafeArea = safeArea
        configure(container)
        self.layouts = layoutBuilder()
    }
    
    public init(_ container: UIView = UIView(), safeArea: Bool = false, lrbt: (l: CGFloat, r: CGFloat, t: CGFloat, b: CGFloat), configure: @escaping (UIView) -> Void = {_ in}, @LayoutBuilder layoutBuilder: () -> [AnyLayout]) {
        self.container = container
        self.insets = UIEdgeInsets(top: lrbt.t, left: lrbt.l, bottom: lrbt.b, right: lrbt.r)
        self.isSafeArea = safeArea
        configure(container)
        self.layouts = layoutBuilder()
    }
}

extension Padding: LayoutProtocol {
    public func makeLayoutNode(_ compositeRevertable: Revertable) -> UIView {
        Layout { revertable in
            revertable.append(self.fillingParent(insets: insets, relativeToSafeArea: isSafeArea).makeLayoutNode(revertable).layout(in: container))
            return self.container
        }.makeLayoutNode(compositeRevertable)
    }
}
