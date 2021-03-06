//
//  LinesController.swift
//  SwiftyEcharts
//
//  Created by Pluto Y on 25/02/2017.
//  Copyright © 2017 com.pluto-y. All rights reserved.
//

import UIKit
import SwiftyEcharts

class LinesController: BaseDemoController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menus = ["雨量流量关系图", "大数据量面积图(暂缺)", "堆叠区域图", "Confidence Band(暂缺)", "动态数据 + 时间坐标轴(暂缺)", "雨量流量关系图", "Beijing AQI(暂缺)", "Try Dragging these Points(暂缺)", "Different Easing Functions(暂缺)", "对数轴示例", "未来一周气温变化", "Click to Add Points(暂缺)", "极坐标双数值轴", "极坐标双数值轴", "一天用电量分布", "折线图堆叠", "Step Line", "高度(km)与气温(°C)变化关系"]
        
        optionClosures = [SECLineOptions.areaRainfallOption, SECLineOptions.areaSimpleOption, SECLineOptions.areaStackOption, SECLineOptions.confidenceBandOption, SECLineOptions.dynamicData2Option, SECLineOptions.gridMultipleOption, SECLineOptions.lineApiOption, SECLineOptions.lineDraggableOption, SECLineOptions.lineEasingOption, SECLineOptions.lineLogOption, SECLineOptions.lineMarkerOption, SECLineOptions.linePenOption, SECLineOptions.linePolarOption, SECLineOptions.linePolar2Option, SECLineOptions.lineSectionsOption, SECLineOptions.lineStackOption, SECLineOptions.lineStepOption, SECLineOptions.lineYCategoryOption]
        
        self.title = "折线图"
        
    }
}

