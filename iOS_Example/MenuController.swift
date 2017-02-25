//
//  ViewController.swift
//  iOS_Example
//
//  Created by Pluto Y on 25/11/2016.
//  Copyright © 2016 com.pluto-y. All rights reserved.
//

import UIKit
import SwiftyEcharts

class MenuController : UITableViewController {

    var echartsView: SECEchartsView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("选择了\(indexPath.row + 1)行")
        switch indexPath.row {
        case 0: // 折线图的Demo
            self.navigationController?.pushViewController(LinesController(), animated: true)
        default:
            print("敬请期待...")
        }
    }
    

}

