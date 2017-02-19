//
//  SECBarOptions.swift
//  SwiftyEcharts
//
//  Created by Pluto-Y on 16/01/2017.
//  Copyright © 2017 com.pluto-y. All rights reserved.
//

import SwiftyEcharts

public struct SECBarOptions {
    
    // MARK: 柱状图动画延迟
    // FIXME: (未成功)
    /// 地址: http://echarts.baidu.com/demo.html#bar-animation-delay
    static func barAnimationDelayOption() -> SECOption {
        func calculateData(index: Float, function: (Double) -> Double) -> Float {
            var tmp: Float = Float(function(Double(index) / 5.0))
            tmp *= (index / 5.0 - 1.0)
            tmp += index / 6.0
            tmp *= 5.0
            return tmp
        }
        var xAxisData: [SECJsonable] = []
        var data1: [SECJsonable] = []
        var data2: [SECJsonable] = []
        for i in 0..<100 {
            xAxisData.append("类目\(i)")
            data1.append(calculateData(Float(i), function: sin))
            data2.append(calculateData(Float(i), function: cos))
        }
        return SECOption(
            .title(SECTitle(
                .text("柱状图动画延迟")
                )),
            .legend(SECLegend(
                .data(["bar", "bar2"]),
                .align(.left)
                )),
            .toolbox(SECToolbox(
                .feature(SECTFeature(
                    .magicType(SECTFMagicType(
                        .type([.stack, .tiled])
                        )),
                    .dataView(SECTFDataView(
                        )),
                    .saveAsImage(SECTFSaveAsImage(
                        .pixelRatio(2)
                        ))
                    ))
                )),
            .tooltip(SECTooltip()),
            .xAxis([
                SECAxis(
                    .data(xAxisData),
                    .silent(false),
                    .splitLine(SECSplitLine(
                        .show(false)
                        ))
                )
                ]),
            .yAxis([
                SECAxis()
                ]),
            .series([
                SECBarSerie(
                    .name("bar"),
                    .data(data1),
                    .animationDelay(.function("function seriesDelay(idx){ return idx * 10; }"))
                ),
                SECBarSerie(
                    .name("bar2"),
                    .data(data2),
                    .animationDelay(.function("function seriesDelay2(idx){ return idx * 10 + 100; }"))
                )
                ]),
            .animationEasing(.elasticOut),
            .animationDelayUpdate(.function("function optionDelayUpdate(idx){ return idx * 5; }"))
        )
    }
    
}
