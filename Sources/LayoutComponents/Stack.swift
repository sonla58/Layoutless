//
//  Stack.swift
//  Layoutless
//
//  Created by finos.son.le on 11/01/2021.
//  Copyright © 2021 Declarative Hub. All rights reserved.
//

import UIKit

public protocol LayoutlessStackType: LayoutProtocol {
    var axis: NSLayoutConstraint.Axis { get set }
    var distribution: UIStackView.Distribution { get set }
    var spacing: CGFloat { get set }
    var alignment: UIStackView.Alignment { get set }
    var configure: (UIStackView) -> Void { get set }
    var layouts: [AnyLayout] { get set }
}

public extension LayoutlessStackType {
    func makeLayoutNode(_ compositeRevertable: Revertable) -> UIStackView {
        Layout { revertable in
            let stackView = UIStackView()
            stackView.axis = axis
            stackView.spacing = spacing
            stackView.distribution = distribution
            stackView.alignment = alignment
            layouts.forEach {
                revertable.append($0.layout(in: stackView))
            }
            configure(stackView)
            return stackView
        }.makeLayoutNode(compositeRevertable)
    }
}

public struct VStackView: LayoutlessStackType {
    public var axis: NSLayoutConstraint.Axis = .vertical
    public var distribution: UIStackView.Distribution
    public var spacing: CGFloat
    public var alignment: UIStackView.Alignment
    public var configure: (UIStackView) -> Void
    public var layouts: [AnyLayout]
    
    public init(
        spacing: CGFloat = 0,
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .fill,
        configure: @escaping (UIStackView) -> Void = { _ in },
        layouts: [AnyLayout]
    ) {
        self.spacing = spacing
        self.distribution = distribution
        self.alignment = alignment
        self.configure = configure
        self.layouts = layouts
    }
    
    public init(
        spacing: CGFloat = 0,
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .fill,
        configure: @escaping (UIStackView) -> Void = { _ in },
        @LayoutBuilder layoutBuilder: () -> [AnyLayout]
    ) {
        self.spacing = spacing
        self.distribution = distribution
        self.alignment = alignment
        self.configure = configure
        self.layouts = layoutBuilder()
    }
}

public struct HStackView: LayoutlessStackType {
    public var axis: NSLayoutConstraint.Axis = .horizontal
    public var distribution: UIStackView.Distribution
    public var spacing: CGFloat
    public var alignment: UIStackView.Alignment
    public var configure: (UIStackView) -> Void
    public var layouts: [AnyLayout]
    
    public init(
        spacing: CGFloat = 0,
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .fill,
        configure: @escaping (UIStackView) -> Void = { _ in },
        layouts: [AnyLayout]
    ) {
        self.spacing = spacing
        self.distribution = distribution
        self.alignment = alignment
        self.configure = configure
        self.layouts = layouts
    }
    
    public init(
        spacing: CGFloat = 0,
        distribution: UIStackView.Distribution = .fill,
        alignment: UIStackView.Alignment = .fill,
        configure: @escaping (UIStackView) -> Void = { _ in },
        @LayoutBuilder layoutBuilder: () -> [AnyLayout]
    ) {
        self.spacing = spacing
        self.distribution = distribution
        self.alignment = alignment
        self.configure = configure
        self.layouts = layoutBuilder()
    }
}

public struct ZStackView {
    public var layouts: [AnyLayout]
    public var container: UIView
    
    public init(_ container: UIView = UIView(), configure: @escaping (UIView) -> Void = {_ in}, layouts: [AnyLayout]) {
        self.container = container
        configure(container)
        self.layouts = layouts
    }
    
    public init(_ container: UIView = UIView(), configure: @escaping (UIView) -> Void = {_ in}, @LayoutBuilder layoutBuilder: () -> [AnyLayout]) {
        self.container = container
        configure(container)
        self.layouts = layoutBuilder()
    }
}

extension ZStackView: LayoutProtocol {
    public func makeLayoutNode(_ compositeRevertable: Revertable) -> UIView {
        Layout { revertable in
            return LayoutGroup(layouts)
        }
        .embedding(in: container)
        .makeLayoutNode(compositeRevertable)
    }
}
