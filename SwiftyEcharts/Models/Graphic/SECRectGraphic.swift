//
//  SECRectGraphic.swift
//  SwiftyEcharts
//
//  Created by Pluto Y on 11/02/2017.
//  Copyright © 2017 com.pluto-y. All rights reserved.
//

/// 矩形类型的 `Graphic`
public struct SECRectGraphic : SECGraphic {
    
    public struct Shape {
        public var x: Float?
        public var y: Float?
        public var width: Float?
        public var height: Float?
        
        public init() {}
    }
    
    /// MARK: SECGraphic
    public var type: SECGraphicType {
        return .rect
    }
    public var id: String?
    public var action: SECGraphicAction?
    public var left: SECPosition?
    public var right: SECPosition?
    public var top: SECPosition?
    public var bottom: SECPosition?
    public var bounding: SECGraphicBounding?
    public var z: Float?
    public var zlevel: Float?
    public var silent: Bool?
    public var invisible: Bool?
    public var cursor: String?
    public var draggable: Bool?
    public var progressiv: Bool?
    
    /// 矩形的配置
    public var shape: Shape?
    /// 矩形样式配置
    public var style: SECCommonGraphicStyle?
    
    public init() {}
}

extension SECRectGraphic.Shape : SECEnumable {
    public enum Enums {
        case x(Float), y(Float), width(Float), height(Float)
    }
    
    public typealias ContentEnum = Enums
    
    public init(_ elements: Enums...) {
        for ele in elements {
            switch ele {
            case let .x(x):
                self.x = x
            case let .y(y):
                self.y = y
            case let .width(width):
                self.width = width
            case let .height(height):
                self.height = height
            }
        }
    }
}

extension SECRectGraphic.Shape : SECMappable {
    public func mapping(map: SECMap) {
        map["x"] = x
        map["y"] = y
        map["width"] = width
        map["height"] = height
    }
}

extension SECRectGraphic : SECEnumable {
    public enum Enums {
        case id(String), action(SECGraphicAction), left(SECPosition), right(SECPosition), top(SECPosition), bottom(SECPosition), bounding(SECGraphicBounding), z(Float), zlevel(Float), silent(Bool), invisible(Bool), cursor(String), draggable(Bool), progressiv(Bool), shape(Shape), style(SECCommonGraphicStyle)
    }
    
    public typealias ContentEnum = Enums
    
    public init(_ elements: Enums...) {
        for ele in elements {
            switch ele {
            case let .id(id):
                self.id = id
            case let .action(action):
                self.action = action
            case let .left(left):
                self.left = left
            case let .right(right):
                self.right = right
            case let .top(top):
                self.top = top
            case let .bottom(bottom):
                self.bottom = bottom
            case let .bounding(bounding):
                self.bounding = bounding
            case let .z(z):
                self.z = z
            case let .zlevel(zlevel):
                self.zlevel = zlevel
            case let .silent(silent):
                self.silent = silent
            case let .invisible(invisible):
                self.invisible = invisible
            case let .cursor(cursor):
                self.cursor = cursor
            case let .draggable(draggable):
                self.draggable = draggable
            case let .progressiv(progressiv):
                self.progressiv = progressiv
            case let .shape(shape):
                self.shape = shape
            case let .style(style):
                self.style = style
            }
        }
    }
}

extension SECRectGraphic : SECMappable {
    public func mapping(map: SECMap) {
        map["type"] = type
        map["id"] = id
        map["$action"] = action
        map["left"] = left
        map["right"] = right
        map["top"] = top
        map["bottom"] = bottom
        map["bounding"] = bounding
        map["z"] = z
        map["zlevel"] = zlevel
        map["silent"] = silent
        map["invisible"] = invisible
        map["cursor"] = cursor
        map["draggable"] = draggable
        map["progressiv"] = progressiv
        map["shape"] = shape
        map["style"] = style
    }
}
