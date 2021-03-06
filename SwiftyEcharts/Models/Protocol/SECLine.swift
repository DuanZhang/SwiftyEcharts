//
//  SECLineStyleContainer.swift
//  SwiftyEcharts
//
//  Created by Pluto Y on 01/12/2016.
//  Copyright © 2016 com.pluto-y. All rights reserved.
//

/// 线的类型
///
/// - solid: 实线
/// - dashed: 虚线
/// - dotted: 点线
public enum SECLineType: String, SECJsonable {
    case solid = "solid", dashed = "dashed", dotted = "dotted"
    
    public var jsonString: String {
        return "\"\(self.rawValue)\""
    }
}


public protocol SECLine {
    var lineStyle: SECLineStyle? { get set }
}
