//
//  SECMapSerie.swift
//  SwiftyEcharts
//
//  Created by Pluto Y on 03/03/2017.
//  Copyright © 2017 com.pluto-y. All rights reserved.
//

/// 地图。
///
/// 地图主要用于地理区域数据的可视化，配合 visualMap 组件用于展示不同区域的人口分布密度等数据。
///
/// 多个地图类型相同的系列会在同一地图上显示，这时候使用第一个系列的配置项作为地图绘制的配置。
///
/// Tip: 在 ECharts 3 中不再建议在地图类型的图表使用 markLine 和 markPoint。如果要实现点数据或者线数据的可视化，可以使用在地理坐标系组件上的散点图和线图。
///
/// 示例： http://echarts.baidu.com/gallery/editor.html?c=doc-example/map-example
public struct SECMapSerie: SECSeries, SECZable {
    
    /// 滚轮缩放的极限控制，通过min, max最小和最大的缩放值，默认的缩放为1。
    public struct ScaleLimit {
        /// 最小的缩放值
        public var min: Float?
        /// 最大的缩放值
        public var max: Float?
    }
    
    /// 地图系列中的数据内容数组。数组项可以为单个数值，如：
    ///
    ///     [12, 34, 56, 10, 23]
    ///
    /// 如果需要在数据中加入其它维度给 visualMap 组件用来映射到颜色等其它图形属性。每个数据项也可以是数组，如：
    ///
    ///     [[12, 14], [34, 50], [56, 30], [10, 15], [23, 10]]
    ///
    /// 这时候可以将每项数组中的第二个值指定给 visualMap 组件。
    ///
    /// 更多时候我们需要指定每个数据项的名称，这时候需要每个项为一个对象：
    ///
    ///     [{
    ///         // 数据项的名称
    ///         name: '数据1',
    ///         // 数据项值8
    ///         value: 10
    ///     }, {
    ///         name: '数据2',
    ///         value: 20
    ///     }]
    ///
    /// 需要对个别内容指定进行个性化定义时：
    ///
    ///     [{
    ///         name: '数据1',
    ///         value: 10
    ///     }, {
    ///         // 数据项名称
    ///         name: '数据2',
    ///         value : 56,
    ///         //自定义特殊 tooltip，仅对该数据项有效
    ///         tooltip:{},
    ///         //自定义特殊itemStyle，仅对该item有效
    ///         itemStyle:{}
    ///     }]
    public struct Data {
        /// 数据所对应的地图区域的名称，例如 '广东'，'浙江'。
        public var name: String?
        /// 该区域的数据值。
        public var value: Float?
        /// 该区域是否选中。
        public var selected: Bool?
        /// 该数据所在区域的多边形样式设置
        public var itemStyle: SECItemStyle?
        /// 该数据所在区域的标签样式设置
        public var label: SECLabel?
    }
    
    public var type: SECSerieType {
        return .map
    }
    
    /// 系列名称，用于tooltip的显示，legend 的图例筛选，在 setOption 更新数据和配置项时用于指定对应的系列。
    public var name: String?
    /// 地图类型。
    ///
    /// ECharts 3 中因为地图精度的提高，不再内置地图数据增大代码体积，你可以在地图下载界面下载到需要的地图文件引入并注册到 ECharts 中。
    ///
    /// ECharts 中提供了两种格式的地图数据，一种是可以直接 script 标签引入的 js 文件，引入后会自动注册地图名字和数据。还有一种是 JSON 文件，需要通过 AJAX 异步加载后手动注册。
    ///
    /// 下面是两种类型的使用示例：
    ///
    ///     JavaScript 引入示例
    ///     <script src="echarts.js"></script>
    ///     <script src="map/js/china.js"></script>
    ///     <script>
    ///     var chart = echarts.init(document.getElementById('main'));
    ///     chart.setOption({
    ///         series: [{
    ///             type: 'map',
    ///             map: 'china'
    ///         }]
    ///     });
    ///     </script>
    ///
    /// JSON 引入示例
    ///
    ///     $.get('map/json/china.json', function (chinaJson) {
    ///         echarts.registerMap('china', chinaJson);
    ///         var chart = echarts.init(document.getElementById('main'));
    ///         chart.setOption({
    ///             series: [{
    ///                 type: 'map',
    ///                 map: 'china'
    ///             }]
    ///         });
    ///     });
    ///
    /// ECharts 使用 geoJSON 格式的数据作为地图的轮廓，除了上述数据，你也可以通过其它手段获取地图的 geoJSON 数据注册到 ECharts 中。参见示例 USA Population Estimates
    public var map: String?
    /// 是否开启鼠标缩放和平移漫游。默认不开启。如果只想要开启缩放或者平移，可以设置成 'scale' 或者 'move'。设置成 true 为都开启
    public var roam: SECRoam?
    /// 当前视角的中心点，用经纬度表示
    ///
    /// 例如：
    ///
    ///     center: [115.97, 29.71]
    public var center: SECPosition?
    /// 这个参数用于 scale 地图的长宽比。
    ///
    /// 最终的 aspect 的计算方式是：geoBoundingRect.width / geoBoundingRect.height * aspectScale
    public var aspectScale: Float?
    /// 当前视角的缩放比例。
    public var zoom: Float?
    /// 滚轮缩放的极限控制，通过min, max最小和最大的缩放值，默认的缩放为1。
    public var scaleLimit: ScaleLimit?
    /// 自定义地区的名称映射，如：
    ///
    ///     {
    ///         'China' : '中国'
    ///     }
    public var nameMap: [String: SECJsonable]?
    /// 选中模式，表示是否支持多个选中，默认关闭，支持布尔值和字符串，字符串取值可选'single'表示单选，或者'multiple'表示多选。
    public var selectedMode: SECSelectedMode?
    /// 图形上的文本标签，可用于说明图形的一些数据信息，比如值，名称等，label选项在 ECharts 2.x 中放置于itemStyle.normal下，在 ECharts 3 中为了让整个配置项结构更扁平合理，label 被拿出来跟 itemStyle 平级，并且跟 itemStyle 一样拥有 normal, emphasis 两个状态。
    public var label: SECLabel?
    /// 地图区域的多边形 图形样式，有 normal 和 emphasis 两个状态。normal 是图形在默认状态下的样式；emphasis 是图形在高亮状态下的样式，比如在鼠标悬浮或者图例联动高亮时。
    public var itemStyle: SECItemStyle?
    
    /// MARK: SECZable
    public var zlevel: Float?
    public var z: Float?
    
    /// 组件离容器左侧的距离。
    ///
    /// left 的值可以是像 20 这样的具体像素值，可以是像 '20%' 这样相对于容器高宽的百分比，也可以是 'left', 'center', 'right'。
    ///
    /// 如果 left 的值为'left', 'center', 'right'，组件会根据相应的位置自动对齐。
    public var left: SECPosition?
    /// 组件离容器上侧的距离。
    ///
    /// top 的值可以是像 20 这样的具体像素值，可以是像 '20%' 这样相对于容器高宽的百分比，也可以是 'top', 'middle', 'bottom'。
    ///
    /// 如果 top 的值为'top', 'middle', 'bottom'，组件会根据相应的位置自动对齐。
    public var top: SECPosition?
    /// 组件离容器右侧的距离。
    ///
    /// right 的值可以是像 20 这样的具体像素值，可以是像 '20%' 这样相对于容器高宽的百分比。
    ///
    /// 默认自适应。
    public var right: SECPosition?
    /// 组件离容器下侧的距离。
    ///
    /// bottom 的值可以是像 20 这样的具体像素值，可以是像 '20%' 这样相对于容器高宽的百分比。
    ///
    /// 默认自适应。
    public var bottom: SECPosition?
    /// layoutCenter 和 layoutSize 提供了除了 left/right/top/bottom/width/height 之外的布局手段。
    ///
    /// 在使用 left/right/top/bottom/width/height 的时候，可能很难在保持地图高宽比的情况下把地图放在某个盒形区域的正中间，并且保证不超出盒形的范围。此时可以通过 layoutCenter 属性定义地图中心在屏幕中的位置，layoutSize 定义地图的大小。如下示例
    ///
    ///     layoutCenter: ['30%', '30%'],
    ///     // 如果宽高比大于 1 则宽度为 100，如果小于 1 则高度为 100，保证了不超过 100x100 的区域
    ///     layoutSize: 100
    ///
    /// 设置这两个值后 left/right/top/bottom/width/height 无效。
    public var layoutCenter: SECPosition?
    /// 地图的大小，见 layoutCenter。支持相对于屏幕宽高的百分比或者绝对的像素大小。
    public var layoutSize: SECLength?
    /// 默认情况下，map series 会自己生成内部专用的 geo 组件。但是也可以用这个 geoIndex 指定一个 geo 组件。这样的话，map 和 其他 series（例如散点图）就可以共享一个 geo 组件了。并且，geo 组件的颜色也可以被这个 map series 控制，从而用 visualMap 来更改。
    /// 当设定了 geoIndex 后，series-map.map 属性，以及 series-map.itemStyle 等样式配置不再起作用，而是采用 geo 中的相应属性。
    /// 参见：http://echarts.baidu.com/gallery/editor.html?c=geo-map-scatter
    public var geoIndex: UInt8?
    /// 多个拥有相同地图类型的系列会使用同一个地图展现，如果多个系列都在同一个区域有值，ECharts 会对这些值统计得到一个数据。这个配置项就是用于配置统计的方式，目前有：
    /// - 'sum' 取和。
    /// - 'average' 取平均值。
    /// - 'max' 取最大值。
    /// - 'min' 取最小值。
    public var mapValueCalculation: String?
    /// 在图例相应区域显示图例的颜色标识（系列标识的小圆点），存在 legend 组件时生效。
    public var showLegendSymbol: Bool?
    /// 地图系列中的数据内容数组。数组项可以为单个数值，如：
    ///
    ///     [12, 34, 56, 10, 23]
    ///
    /// 如果需要在数据中加入其它维度给 visualMap 组件用来映射到颜色等其它图形属性。每个数据项也可以是数组，如：
    ///
    ///     [[12, 14], [34, 50], [56, 30], [10, 15], [23, 10]]
    ///
    /// 这时候可以将每项数组中的第二个值指定给 visualMap 组件。
    ///
    /// 更多时候我们需要指定每个数据项的名称，这时候需要每个项为一个对象：
    ///
    ///     [{
    ///         // 数据项的名称
    ///         name: '数据1',
    ///         // 数据项值8
    ///         value: 10
    ///     }, {
    ///         name: '数据2',
    ///         value: 20
    ///     }]
    ///
    /// 需要对个别内容指定进行个性化定义时：
    ///
    ///     [{
    ///         name: '数据1',
    ///         value: 10
    ///     }, {
    ///         // 数据项名称
    ///         name: '数据2',
    ///         value : 56,
    ///         //自定义特殊 tooltip，仅对该数据项有效
    ///         tooltip:{},
    ///         //自定义特殊itemStyle，仅对该item有效
    ///         itemStyle:{}
    ///     }]
    public var data: [SECJsonable]?
    /// 图表标注。
    public var markPoint: SECMarkPoint?
    /// 图表标线。
    public var markLine: SECMarkLine?
    /// 图表标域，常用于标记图表中某个范围的数据，例如标出某段时间投放了广告。
    public var markArea: SECMarkArea?
    /// 图形是否不响应和触发鼠标事件，默认为 false，即响应和触发鼠标事件。
    public var silent: Bool?
}

extension SECMapSerie.ScaleLimit : SECEnumable {
    public enum Enums {
        case min(Float), max(Float)
    }
    
    public typealias ContentEnum = Enums
    
    public init(_ elements: Enums...) {
        for ele in elements {
            switch ele {
            case let .min(min):
                self.min = min
            case let .max(max):
                self.max = max
            }
        }
    }
}

extension SECMapSerie.ScaleLimit : SECMappable {
    public func mapping(map: SECMap) {
        map["min"] = min
        map["max"] = max
    }
}

extension SECMapSerie.Data : SECEnumable {
    public enum Enums {
        case name(String), value(Float), selected(Bool), itemStyle(SECItemStyle), label(SECLabel)
    }
    
    public typealias ContentEnum = Enums
    
    public init(_ elements: Enums...) {
        for ele in elements {
            switch ele {
            case let .name(name):
                self.name = name
            case let .value(value):
                self.value = value
            case let .selected(selected):
                self.selected = selected
            case let .itemStyle(itemStyle):
                self.itemStyle = itemStyle
            case let .label(label):
                self.label = label
            }
        }
    }
}

extension SECMapSerie.Data : SECMappable {
    public func mapping(map: SECMap) {
        map["name"] = name
        map["value"] = value
        map["selected"] = selected
        map["itemStyle"] = itemStyle
        map["label"] = label
    }
}

extension SECMapSerie : SECEnumable {
    public enum Enums {
        case name(String), map(String), roam(SECRoam), center(SECPosition), aspectScale(Float), zoom(Float), scaleLimit(ScaleLimit), nameMap([String: SECJsonable]), selectedMode(SECSelectedMode), label(SECLabel), itemStyle(SECItemStyle), zlevel(Float), z(Float), left(SECPosition), top(SECPosition), right(SECPosition), bottom(SECPosition), layoutCenter(SECPosition), layoutSize(SECLength), geoIndex(UInt8), mapValueCalculation(String), showLegendSymbol(Bool), data([SECJsonable]), markPoint(SECMarkPoint), markLine(SECMarkLine), markArea(SECMarkArea), silent(Bool)
    }
    
    public typealias ContentEnum = Enums
    
    public init(_ elements: Enums...) {
        for ele in elements {
            switch ele {
            case let .name(name):
                self.name = name
            case let .map(map):
                self.map = map
            case let .roam(roam):
                self.roam = roam
            case let .center(center):
                self.center = center
            case let .aspectScale(aspectScale):
                self.aspectScale = aspectScale
            case let .zoom(zoom):
                self.zoom = zoom
            case let .scaleLimit(scaleLimit):
                self.scaleLimit = scaleLimit
            case let .nameMap(nameMap):
                self.nameMap = nameMap
            case let .selectedMode(selectedMode):
                self.selectedMode = selectedMode
            case let .label(label):
                self.label = label
            case let .itemStyle(itemStyle):
                self.itemStyle = itemStyle
            case let .zlevel(zlevel):
                self.zlevel = zlevel
            case let .z(z):
                self.z = z
            case let .left(left):
                self.left = left
            case let .top(top):
                self.top = top
            case let .right(right):
                self.right = right
            case let .bottom(bottom):
                self.bottom = bottom
            case let .layoutCenter(layoutCenter):
                self.layoutCenter = layoutCenter
            case let .layoutSize(layoutSize):
                self.layoutSize = layoutSize
            case let .geoIndex(geoIndex):
                self.geoIndex = geoIndex
            case let .mapValueCalculation(mapValueCalculation):
                self.mapValueCalculation = mapValueCalculation
            case let .showLegendSymbol(showLegendSymbol):
                self.showLegendSymbol = showLegendSymbol
            case let .data(data):
                self.data = data
            case let .markPoint(markPoint):
                self.markPoint = markPoint
            case let .markLine(markLine):
                self.markLine = markLine
            case let .markArea(markArea):
                self.markArea = markArea
            case let .silent(silent):
                self.silent = silent
            }
        }
    }
}

extension SECMapSerie : SECMappable {
    public func mapping(map: SECMap) {
        map["type"] = type
        map["name"] = name
        map["map"] = map
        map["roam"] = roam
        map["center"] = center
        map["aspectScale"] = aspectScale
        map["zoom"] = zoom
        map["scaleLimit"] = scaleLimit
        map["nameMap"] = nameMap
        map["selectedMode"] = selectedMode
        map["label"] = label
        map["itemStyle"] = itemStyle
        map["zlevel"] = zlevel
        map["z"] = z
        map["left"] = left
        map["top"] = top
        map["right"] = right
        map["bottom"] = bottom
        map["layoutCenter"] = layoutCenter
        map["layoutSize"] = layoutSize
        map["geoIndex"] = geoIndex
        map["mapValueCalculation"] = mapValueCalculation
        map["showLegendSymbol"] = showLegendSymbol
        map["data"] = data
        map["markPoint"] = markPoint
        map["markLine"] = markLine
        map["markArea"] = markArea
        map["silent"] = silent
    }
}
