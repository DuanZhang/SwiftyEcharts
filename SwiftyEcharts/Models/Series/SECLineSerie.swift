//
//  SECLineSerie.swift
//  SwiftyEcharts
//
//  Created by Pluto-Y on 03/01/2017.
//  Copyright © 2017 com.pluto-y. All rights reserved.
//

extension SECLineSerie {
    /// 折线图在数据量远大于像素点时候的降采样策略，开启后可以有效的优化图表的绘制效率，默认关闭，也就是全部绘制不过滤数据点。
    ///
    /// - average: 取过滤点的平均值
    /// - max: 取过滤点的最大值
    /// - min: 取过滤点的最小值
    /// - sum: 取过滤点的和
    public enum Sampling: String, SECJsonable {
        case average = "average"
        case max = "max"
        case min = "min"
        case sum = "sum"
        
        public var jsonString: String {
            return "\"\(self.rawValue)\""
        }
    }
}

extension SECLineSerie {
    public struct Data: SECSymbolized {
        
        public var name: String?
        public var value: Float?
        public var symbol: SECSymbol?
        public var symbolSize: Float?
        public var symbolRotate: Float?
        public var symbolOffset: SECPoint?
        public var label: SECLabel? // 官方文档显示只有 normal 的模式？
        public var itemStyle: SECItemStyle?
        
        public init() { }
    }
}

public typealias SECLineSerieData = SECLineSerie.Data

extension SECLineSerieData : SECEnumable {
    public enum Enums {
        case name(String), value(Float), symbol(SECSymbol), symbolSize(Float), symbolRotate(Float), symbolOffset(SECPoint), label(SECLabel), itemStyle(SECItemStyle)
    }
    
    public typealias ContentEnum = Enums
    
    public init(_ elements: Enums...) {
        for ele in elements {
            switch ele {
            case let .name(name):
                self.name = name
            case let .value(value):
                self.value = value
            case let .symbol(symbol):
                self.symbol = symbol
            case let .symbolSize(symbolSize):
                self.symbolSize = symbolSize
            case let .symbolRotate(symbolRotate):
                self.symbolRotate = symbolRotate
            case let .symbolOffset(symbolOffset):
                self.symbolOffset = symbolOffset
            case let .label(label):
                self.label = label
            case let .itemStyle(itemStyle):
                self.itemStyle = itemStyle
            }
        }
    }
}

extension SECLineSerieData : SECMappable {
    public func mapping(map: SECMap) {
        map["name"] = name
        map["value"] = value
        map["symbol"] = symbol
        map["symbolSize"] = symbolSize
        map["symbolRotate"] = symbolRotate
        map["symbolOffset"] = symbolOffset
        map["label"] = label
        map["itemStyle"] = itemStyle
    }
}

/// 折线/面积图
/// 折线图是用折线将各个数据点标志连接起来的图表，用于展现数据的变化趋势。可用于直角坐标系和极坐标系上。
///
/// - Note: 设置 areaStyle 后可以绘制面积图。
/// - Note: 配合分段型 visualMap 组件可以将折线/面积图通过不同颜色分区间。如下示例
public struct SECLineSerie : SECSymbolized, SECAnimatable, SECZable {
    
    /// 阶梯线图类型。
    ///
    /// 具体差别可以参考: http://echarts.baidu.com/gallery/editor.html?c=line-step
    public typealias Step = SECLocation
    
    /// 折线平滑后是否在一个维度上保持单调性，可以设置成'x', 'y'来指明是在 x 轴或者 y 轴上保持单调性。
    public enum SmoothMonotone : String, SECJsonable{
        case x = "x"
        case y = "y"
        
        public var jsonString: String {
            return "\"\(self.rawValue)\""
        }
    }
    
    /// 系列名称，用于tooltip的显示，legend 的图例筛选，在 setOption 更新数据和配置项时用于指定对应的系列。
    public var name: String?
    /// 该系列使用的坐标系
    public var coordinateSystem: SECCoordinateSystem?
    /// 使用的 x 轴的 index，在单个图表实例中存在多个 x 轴的时候有用。
    public var xAxisIndex: UInt?
    /// 使用的 y 轴的 index，在单个图表实例中存在多个 y轴的时候有用。
    public var yAxisIndex: UInt?
    /// 使用的极坐标系的 index，在单个图表实例中存在多个极坐标系的时候有用。
    public var polarIndex: UInt?
    // MARK: SECSymbolized
    public var symbol: SECSymbol?
    public var symbolSize: Float?
    public var symbolRotate: Float?
    public var symbolOffset: SECPoint?
    public var showSymbol: Bool?
    /// 标志图形默认只有主轴显示（随主轴标签间隔隐藏策略），如需全部显示可把 showAllSymbol 设为 true。
    public var showAllSymbol: Bool?
    /// 是否开启 hover 在拐点标志上的提示动画效果。
    public var hoverAnimation: Bool?
    /// 是否启用图例 hover 时的联动高亮。
    public var legendHoverLink: Bool?
    /// 数据堆叠，同个类目轴上系列配置相同的stack值后，后一个系列的值会在前一个系列的值上相加。
    ///
    /// 下面示例可以通过右上角 toolbox 中的堆叠切换看效果：
    ///
    /// http://echarts.baidu.com/gallery/editor.html?c=doc-example/line-stack-tiled
    public var stack: String?
    /// 是否连接空数据。
    public var connectNulls: Bool?
    /// 是否对超出部分裁剪，默认裁剪。
    public var clipOverflow: Bool?
    /// 是否是阶梯线图。可以设置为 true 显示成阶梯线图，也支持设置成 'start', 'middle', 'end' 分别配置在当前点，当前点与下个点的中间点，下个点拐弯。
    ///
    /// 不同的配置效果如下：
    ///
    /// http://echarts.baidu.com/gallery/editor.html?c=line-step
    public var step: Step?
    /// 图形上的文本标签，可用于说明图形的一些数据信息，比如值，名称等，label选项在 ECharts 2.x 中放置于itemStyle.normal下，在 ECharts 3 中为了让整个配置项结构更扁平合理，label 被拿出来跟 itemStyle 平级，并且跟 itemStyle 一样拥有 normal, emphasis 两个状态。
    public var label: SECLabel?
    /// 折线拐点标志的样式。
    public var itemStyle: SECItemStyle?
    /// 线条样式。
    ///
    /// 注： 修改 lineStyle 中的颜色不会影响图例颜色，如果需要图例颜色和折线图颜色一致，需修改 itemStyle.normal.color，线条颜色默认也会取改颜色。
    public var lineStyle: SECEmphasisLineStyle?
    /// 区域填充样式。
    public var areaStyle: SECEmphasisAreaStyle?
    /// 是否平滑曲线显示。
    public var smooth: Bool?
    /// 折线平滑后是否在一个维度上保持单调性，可以设置成'x', 'y'来指明是在 x 轴或者 y 轴上保持单调性。
    ///
    /// 通常在双数值轴上使用。
    public var smoothMonotone: SmoothMonotone?
    /// 折线图在数据量远大于像素点时候的降采样策略，开启后可以有效的优化图表的绘制效率，默认关闭，也就是全部绘制不过滤数据点。
    public var sampling: Sampling?
    /// 系列中的数据内容数组。数组项通常为具体的数据项。
    ///
    /// 通常来说，数据用一个二维数组表示。如下，每一列被称为一个『维度』。
    ///
    ///     series: [{
    ///         data: [
    ///             // 维度X   维度Y   其他维度 ...
    ///             [  3.4,    4.5,   15,   43],
    ///             [  4.2,    2.3,   20,   91],
    ///             [  10.8,   9.5,   30,   18],
    ///             [  7.2,    8.8,   18,   57]
    ///         ]
    ///     }]
    /// - 在 直角坐标系 (grid) 中『维度X』和『维度Y』会默认对应于 xAxis 和 yAxis。
    /// - 在 极坐标系 (polar) 中『维度X』和『维度Y』会默认对应于 radiusAxis 和 angleAxis。
    /// - 后面的其他维度是可选的，可以在别处被使用，例如：
    ///     - 在 visualMap 中可以将一个或多个维度映射到颜色，大小等多个图形属性上。
    ///     - 在 series.symbolSize 中可以使用回调函数，基于某个维度得到 symbolSize 值。
    ///     - 使用 tooltip.formatter 或 series.label.normal.formatter 可以把其他维度的值展示出来。
    ///
    /// 特别地，当只有一个轴为类目轴（axis.type 为 'category'）的时候，数据可以简化用一个一维数组表示。例如：
    ///
    /// xAxis: {
    /// data: ['a', 'b', 'm', 'n']
    /// },
    /// series: [{
    /// // 与 xAxis.data 一一对应。
    /// data: [23,  44,  55,  19]
    /// // 它其实是下面这种形式的简化：
    /// // data: [[0, 23], [1, 44], [2, 55], [3, 19]]
    /// }]
    /// 
    /// 『值』与 轴类型 的关系：
    ///
    /// 当某维度对应于数值轴（axis.type 为 'value' 或者 'log'）的时候：
    ///
    /// 其值可以为 number（例如 12）。（也可以容忍 string 形式的 number，例如 '12'）
    ///
    /// 当某维度对应于类目轴（axis.type 为 'category'）的时候：
    ///
    /// 其值须为类目的『序数』（从 0 开始）或者类目的『字符串值』。例如：
    ///
    ///     xAxis: {
    ///         type: 'category',
    ///         data: ['星期一', '星期二', '星期三', '星期四']
    ///     },
    ///     yAxis: {
    ///         type: 'category',
    ///         data: ['a', 'b', 'm', 'n', 'p', 'q']
    ///     },
    ///     series: [{
    ///         data: [
    ///             // xAxis    yAxis
    ///             [  0,        0,    2  ], // 意思是此点位于 xAxis: '星期一', yAxis: 'a'。
    ///             [  '星期四',  2,    1  ], // 意思是此点位于 xAxis: '星期四', yAxis: 'm'。
    ///             [  2,       'p',   2  ], // 意思是此点位于 xAxis: '星期三', yAxis: 'p'。
    ///             [  3,        3,    5  ]
    ///         ]
    ///     }]
    ///
    /// 双类目轴的示例可以参考 Github Punchcard 示例。
    ///
    /// 当某维度对应于时间轴（type 为 'time'）的时候：
    ///
    /// 值可以为一个时间戳（如 1484141700832），或者一个 Date 实例，或者字符串形式的值（如 '2012-12-12'，'2012/12/12'）。
    /// 
    /// 当需要对个别数据进行个性化定义时：
    ///
    /// 数组项可用对象，其中的 value 像表示具体的数值，如：
    ///
    ///     [
    ///         12,
    ///         34,
    ///         {
    ///             value : 56,
    ///             //自定义标签样式，仅对该数据项有效
    ///             label: {},
    ///             //自定义特殊 itemStyle，仅对该数据项有效
    ///             itemStyle:{}
    ///         },
    ///         10
    ///     ]
    ///     // 或
    ///     [
    ///         [12, 33],
    ///         [34, 313],
    ///         {
    ///             value: [56, 44],
    ///             label: {},
    ///             itemStyle:{}
    ///         },
    ///         [10, 33]
    ///     ]
    /// 
    /// 空值：
    ///
    /// 当某数据不存在时（ps：不存在不代表值为 0），可以用 '-' 或者 null 或者 undefined 或者 NaN 表示。
    ///
    /// 例如，无数据在折线图中可表现为该点是断开的，在其它图中可表示为图形不存在。
    public var data: [SECJsonable]?
    /// 图表标注。
    public var markPoint: SECMarkPoint?
    /// 图表标线。
    public var markLine: SECMarkLine?
    /// 图表标域，常用于标记图表中某个范围的数据，例如标出某段时间投放了广告。
    public var markArea: SECMarkArea?
    /// MARK: SECZable
    public var zlevel: Float?
    public var z: Float?
    /// 图形是否不响应和触发鼠标事件，默认为 false，即响应和触发鼠标事件。
    public var silent: Bool?
    
    /// 是否开启动画。
    public var animation: Bool?
    /// 是否开启动画的阈值，当单个系列显示的图形数量大于这个阈值时会关闭动画。
    public var animationThreshold: Float?
    /// 初始动画的时长，支持回调函数，可以通过每个数据返回不同的 delay 时间实现更戏剧的初始动画效果：
    ///
    ///     animationDuration: function (idx) {
    ///         // 越往后的数据延迟越大
    ///         return idx * 100;
    ///     }
    public var animationDuration: SECTime?
    /// 初始动画的缓动效果。不同的缓动效果可以参考
    public var animationEasing: SECAnimation?
    /// 初始动画的延迟，支持回调函数，可以通过每个数据返回不同的 delay 时间实现更戏剧的初始动画效果。
    ///
    /// 如下示例：
    ///
    ///     animationDuration: function (idx) {
    ///         // 越往后的数据延迟越大
    ///         return idx * 100;
    ///     }
    public var animationDelay: SECTime?
    /// 数据更新动画的时长。
    /// 支持回调函数，可以通过每个数据返回不同的 delay 时间实现更戏剧的更新动画效果：
    ///     animationDurationUpdate: function (idx) {
    ///         // 越往后的数据延迟越大
    ///         return idx * 100;
    ///     }
    public var animationDurationUpdate: SECTime?
    /// 数据更新动画的缓动效果。
    public var animationEasingUpdate: SECAnimation?
    /// 数据更新动画的延迟，支持回调函数，可以通过每个数据返回不同的 delay 时间实现更戏剧的更新动画效果。
    /// 如下示例：
    ///
    ///     animationDelayUpdate: function (idx) {
    ///         // 越往后的数据延迟越大
    ///         return idx * 100;
    ///     }
    public var animationDelayUpdate: SECTime?
    
    public init() { }
    
}

extension SECLineSerie : SECSeries {
    public var type: SECSerieType {
        return .line
    }
}

extension SECLineSerie : SECEnumable {
    public enum Enums {
        case name(String), coordinateSystem(SECCoordinateSystem), xAxisIndex(UInt), yAxisIndex(UInt), polarIndex(UInt), symbol(SECSymbol), symbolSize(Float), symbolRotate(Float), symbolOffset(SECPoint), showSymbol(Bool), showAllSymbol(Bool), hoverAnimation(Bool), legendHoverLink(Bool), stack(String), connectNulls(Bool), clipOverflow(Bool), step(Step), label(SECLabel), itemStyle(SECItemStyle), lineStyle(SECEmphasisLineStyle), areaStyle(SECEmphasisAreaStyle), smooth(Bool), smoothMonotone(SmoothMonotone), sampling(Sampling), data([SECJsonable]), markPoint(SECMarkPoint), markLine(SECMarkLine), markArea(SECMarkArea), zlevel(Float), z(Float), silent(Bool), animation(Bool), animationThreshold(Float), animationDuration(SECTime), animationEasing(SECAnimation), animationDelay(SECTime), animationDurationUpdate(SECTime), animationEasingUpdate(SECAnimation), animationDelayUpdate(SECTime)
    }
    
    public typealias ContentEnum = Enums
    
    public init(_ elements: Enums...) {
        for ele in elements {
            switch ele {
            case let .name(name):
                self.name = name
            case let .coordinateSystem(coordinateSystem):
                self.coordinateSystem = coordinateSystem
            case let .xAxisIndex(xAxisIndex):
                self.xAxisIndex = xAxisIndex
            case let .yAxisIndex(yAxisIndex):
                self.yAxisIndex = yAxisIndex
            case let .polarIndex(polarIndex):
                self.polarIndex = polarIndex
            case let .symbol(symbol):
                self.symbol = symbol
            case let .symbolSize(symbolSize):
                self.symbolSize = symbolSize
            case let .symbolRotate(symbolRotate):
                self.symbolRotate = symbolRotate
            case let .symbolOffset(symbolOffset):
                self.symbolOffset = symbolOffset
            case let .showSymbol(showSymbol):
                self.showSymbol = showSymbol
            case let .showAllSymbol(showAllSymbol):
                self.showAllSymbol = showAllSymbol
            case let .hoverAnimation(hoverAnimation):
                self.hoverAnimation = hoverAnimation
            case let .legendHoverLink(legendHoverLink):
                self.legendHoverLink = legendHoverLink
            case let .stack(stack):
                self.stack = stack
            case let .connectNulls(connectNulls):
                self.connectNulls = connectNulls
            case let .clipOverflow(clipOverflow):
                self.clipOverflow = clipOverflow
            case let .step(step):
                self.step = step
            case let .label(label):
                self.label = label
            case let .itemStyle(itemStyle):
                self.itemStyle = itemStyle
            case let .lineStyle(lineStyle):
                self.lineStyle = lineStyle
            case let .areaStyle(areaStyle):
                self.areaStyle = areaStyle
            case let .smooth(smooth):
                self.smooth = smooth
            case let .smoothMonotone(smoothMonotone):
                self.smoothMonotone = smoothMonotone
            case let .sampling(sampling):
                self.sampling = sampling
            case let .data(data):
                self.data = data
            case let .markPoint(markPoint):
                self.markPoint = markPoint
            case let .markLine(markLine):
                self.markLine = markLine
            case let .markArea(markArea):
                self.markArea = markArea
            case let .zlevel(zlevel):
                self.zlevel = zlevel
            case let .z(z):
                self.z = z
            case let .silent(silent):
                self.silent = silent
            case let .animation(animation):
                self.animation = animation
            case let .animationThreshold(animationThreshold):
                self.animationThreshold = animationThreshold
            case let .animationDuration(animationDuration):
                self.animationDuration = animationDuration
            case let .animationEasing(animationEasing):
                self.animationEasing = animationEasing
            case let .animationDelay(animationDelay):
                self.animationDelay = animationDelay
            case let .animationDurationUpdate(animationDurationUpdate):
                self.animationDurationUpdate = animationDurationUpdate
            case let .animationEasingUpdate(animationEasingUpdate):
                self.animationEasingUpdate = animationEasingUpdate
            case let .animationDelayUpdate(animationDelayUpdate):
                self.animationDelayUpdate = animationDelayUpdate
            }
        }
    }
}

extension SECLineSerie : SECMappable {
    public func mapping(map: SECMap) {
        map["type"] = type
        map["name"] = name
        map["coordinateSystem"] = coordinateSystem
        map["xAxisIndex"] = xAxisIndex
        map["yAxisIndex"] = yAxisIndex
        map["polarIndex"] = polarIndex
        map["symbol"] = symbol
        map["symbolRotate"] = symbolRotate
        map["symbolOffset"] = symbolOffset
        map["showSymbol"] = showSymbol
        map["showAllSymbol"] = showAllSymbol
        map["hoverAnimation"] = hoverAnimation
        map["legendHoverLink"] = legendHoverLink
        map["stack"] = stack
        map["connectNulls"] = connectNulls
        map["clipOverflow"] = clipOverflow
        map["step"] = step
        map["label"] = label
        map["itemStyle"] = itemStyle
        map["lineStyle"] = lineStyle
        map["areaStyle"] = areaStyle
        map["smooth"] = smooth
        map["smoothMonotone"] = smoothMonotone
        map["sampling"] = sampling
        map["data"] = data
        map["markPoint"] = markPoint
        map["markLine"] = markLine
        map["markArea"] = markArea
        map["zlevel"] = zlevel
        map["z"] = z
        map["silent"] = silent
        map["markPoint"] = markPoint
        map["animation"] = animation
        map["animationThreshold"] = animationThreshold
        map["animationDuration"] = animationDuration
        map["animationEasing"] = animationEasing
        map["animationDelay"] = animationDelay
        map["animationDurationUpdate"] = animationDurationUpdate
        map["animationEasingUpdate"] = animationEasingUpdate
        map["animationDelayUpdate"] = animationDelayUpdate
    }
}

