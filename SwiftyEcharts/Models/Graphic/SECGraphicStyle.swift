//
//  SECGraphicStyle.swift
//  SwiftyEcharts
//
//  Created by Pluto Y on 11/02/2017.
//  Copyright © 2017 com.pluto-y. All rights reserved.
//

/// 通用 `Graphic` 的样式接口
public protocol SECGraphicStyle : SECShadowable {
    /// 填充色。
    var fill: SECColor? { get set }
    /// 笔画颜色。
    var stroke: SECColor? { get set }
    /// 笔画宽度。
    var lineWidth: Float? { get set }
}

/// 通用的 `Graphic` 的样式实现
public struct SECCommonGraphicStyle : SECGraphicStyle {
    /// MARK: SECGraphicStyle
    public var fill: SECColor?
    public var stroke: SECColor?
    public var lineWidth: Float?
    public var shadowBlur: Float?
    public var shadowOffsetX: Float?
    public var shadowOffsetY: Float?
    public var shadowColor: SECColor?
    
    public init() {}
}

extension SECCommonGraphicStyle : SECEnumable {
    public enum Enums {
        case fill(SECColor), stroke(SECColor), lineWidth(Float), shadowBlur(Float), shadowOffsetX(Float), shadowOffsetY(Float), shadowColor(SECColor)
    }
    
    public typealias ContentEnum = Enums
    
    public init(_ elements: Enums...) {
        for ele in elements {
            switch ele {
            case let .fill(fill):
                self.fill = fill
            case let .stroke(stroke):
                self.stroke = stroke
            case let .lineWidth(lineWidth):
                self.lineWidth = lineWidth
            case let .shadowBlur(shadowBlur):
                self.shadowBlur = shadowBlur
            case let .shadowOffsetX(shadowOffsetX):
                self.shadowOffsetX = shadowOffsetX
            case let .shadowOffsetY(shadowOffsetY):
                self.shadowOffsetY = shadowOffsetY
            case let .shadowColor(shadowColor):
                self.shadowColor = shadowColor
            }
        }
    }
}

extension SECCommonGraphicStyle : SECMappable {
    public func mapping(map: SECMap) {
        map["fill"] = fill
        map["stroke"] = stroke
        map["lineWidth"] = lineWidth
        map["shadowBlur"] = shadowBlur
        map["shadowOffsetX"] = shadowOffsetX
        map["shadowOffsetY"] = shadowOffsetY
        map["shadowColor"] = shadowColor
    }
}
