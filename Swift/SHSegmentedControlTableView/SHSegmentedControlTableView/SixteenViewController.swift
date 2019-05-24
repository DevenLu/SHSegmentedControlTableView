//
//  SixteenViewController.swift
//  SHSegmentedControlTableView
//
//  Created by Joe.l on 2018/10/17.
//  Copyright © 2018年 angle. All rights reserved.
//

import UIKit
import SHSegmentedControl

class SixteenViewController: SHBaseViewController, SHSegTableViewDelegate {
    
    var segTableView:SHSegmentedControlTableView!
    
    var segmentControl:SHSegmentControl!
    
    var headerView:UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        let tab1 = TestOneTableView.init(frame: CGRect.init(), style: UITableViewStyle.plain)
        tab1.num = 15
        tab1.label = "一"
        
        let tab2 = TestOneTableView.init(frame: CGRect.init(), style: UITableViewStyle.plain)
        tab2.num = 5
        tab2.label = "二"
        
        let tab3 = TestOneTableView.init(frame: CGRect.init(), style: UITableViewStyle.plain)
        tab3.num = 30
        tab3.label = "三"
        
        let tab4 = TestOneTableView.init(frame: CGRect.init(), style: UITableViewStyle.plain)
        tab4.num = 30
        tab4.label = "四"
        
        let tab5 = TestOneTableView.init(frame: CGRect.init(), style: UITableViewStyle.plain)
        tab5.num = 30
        tab5.label = "五"
        
        let tab6 = TestOneTableView.init(frame: CGRect.init(), style: UITableViewStyle.plain)
        tab6.num = 30
        tab6.label = "六"
        
        let tab7 = TestOneTableView.init(frame: CGRect.init(), style: UITableViewStyle.plain)
        tab7.num = 30
        tab7.label = "七"
        
        self.headerView = self.getHeaderView()
        self.segmentControl = self.getSegmentControl()
        self.segTableView = self.getSegTableView()
        
        self.segTableView.tableViews = [tab1, tab2, tab3, tab4, tab5, tab6, tab7]
        
        self.view.addSubview(self.segTableView)
    }
    
    func segTableViewDidScrollY(_ offsetY: CGFloat) {
        
    }
    
    func segTableViewDidScroll(_ tableView: UIScrollView!) {
        
    }
    
    func segTableViewDidScrollSub(_ subTableView: UIScrollView!) {
        
    }
    
    func segTableViewDidScrollProgress(_ progress: CGFloat, originalIndex: Int, targetIndex: Int) {
        if progress == 1 {
            self.segmentControl.setSegmentSelectedIndex(targetIndex)
        }
    }
    
    func getHeaderView() -> UIView {
        if self.headerView != nil {
            return self.headerView
        }
        let header:UIView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 200))
        header.backgroundColor = UIColor.purple
        return header
    }
    func getSegTableView() -> SHSegmentedControlTableView {
        if self.segTableView != nil {
            return self.segTableView
        }
        let segTable:SHSegmentedControlTableView = SHSegmentedControlTableView.init(frame: self.view.bounds)
        segTable.delegateCell = self
        segTable.topView = self.headerView
        segTable.barView = self.segmentControl
        return segTable
    }
    func getSegmentControl() -> SHSegmentControl {
        if self.segmentControl != nil {
            return self.segmentControl
        }
        let segment:SHSegmentControl = SHSegmentControl.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH * 2, height: 45), items: ["分栏一","分栏二","分栏三","分栏四","分栏五","分栏六","分栏七"])
        segment.titleSelectColor = UIColor.red
        segment.bottomLineColor = UIColor.orange
        segment.bottomLineHeight = 5
        segment.reloadViews()
        weak var weakSelf = self
        segment.curClick = {(index: NSInteger) ->Void in
            // 使用?的好处 就是一旦 self 被释放，就什么也不做
            weakSelf?.segTableView.setSegmentSelect(index)
        }
        return segment
    }

}
