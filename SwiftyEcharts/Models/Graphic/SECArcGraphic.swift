//
//  SECArcGraphic.swift
//  SwiftyEcharts
//
//  Created by Pluto Y on 12/02/2017.
//  Copyright © 2017 com.pluto-y. All rights reserved.
//

/// 圆弧类型的 `Graphic`
public struct SECArcGraphic : SECGraphic {
    
    /// 圆弧的大小和位置
    public struct Shape {
        public var cx: Float?
        public var cy: Float?
        public var r: Float?
        public var r0: Float?
        public var startAngle: Float?
        public var endAngle: Float?
        public var clockwise: Float?
        
        public init() {}
    }
    
    /// MARK: SECGraphic
    public var type: SECGraphicType {
        return .arc
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
    
    /// 圆弧的大小和位置
    public var shape: Shape?
    /// 圆弧的样式
    public var style: SECCommonGraphicStyle?
    
    public init() {}
}

extension SECArcGraphic.Shape : SECEnumable {
    public enum Enums {
        case cx(Float), cy(Float), r(Float), r0(Float), startAngle(Float), endAngle(Float), clockwise(Float)
    }
    
    public typealias ContentEnum = Enums
    
    public init(_ elements: Enums...) {
        for ele in elements {
            switch ele {
            case let .cx(cx):
                self.cx = cx
            case let .cy(cy):
                self.cy = cy
            case let .r(r):
                self.r = r
            case let .r0(r0):
                self.r0 = r0
            case let .startAngle(startAngle):
                self.startAngle = startAngle
            case let .endAngle(endAngle):
                self.endAngle = endAngle
            case let .clockwise(clockwise):
                self.clockwise = clockwise
            }
        }
    }
}

extension SECArcGraphic.Shape : SECMappable {
    public func mapping(map: SECMap) {
        map["cx"] = cx
        map["cy"] = cy
        map["r"] = r
        map["r0"] = r0
        map["startAngle"] = startAngle
        map["endAngle"] = endAngle
        map["clockwise"] = clockwise
    }
}

extension SECArcGraphic : SECEnumable {
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

extension SECArcGraphic : SECMappable {
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
