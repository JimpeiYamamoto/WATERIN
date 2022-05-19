//
//  V_LogDetailViewController.swift
//  20210105WaterCheck
//
//  Created by 水代謝システム工学研究室 on 2022/05/19.
//

import Foundation
import UIKit
import Charts

extension LogDetaillViewController{
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> (Bool) {
        var bool = false
        switch indexPath.row {
        case 0:
            bool = false
        case 1:
            bool = false
        case 2:
            bool = false
        default:
            bool = true
        }
        return bool
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = view.frame.size.height
        switch indexPath.row {
        case 0:
            height /= 10
        case 1:
            height /= 2
        case 2:
            height /= 12
        default:
            height /= 10
        }
        return height
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func setView()
    {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
                    title: "自分の結果",
                    style: .plain,
                    target: nil,
                    action: nil
        )
        daySegment.backgroundColor = .white
        daySegment.setTitleTextAttributes( [NSAttributedString.Key.foregroundColor:UIColor.black], for: .normal)
        let height = view.frame.size.height
        let width = view.frame.size.width
        cate_tf.frame = CGRect(x: width/40*2, y: height/40*5, width: width/40*30, height: height/40*3)
        changeCategoryButton.frame = CGRect(x: width/40*34, y: height/40*5, width: width/40*4, height: height/40*3)
        daySegment.frame = CGRect(x: width/40*2, y: height/40*9, width: width/40*36, height: height/40*2)
        tableView.frame = CGRect(x: 0, y: height/40*12, width: width, height: height/40*29)
    }
    
    func setCellView0(dateTf:UITextField, backButton:UIButton, nextButton:UIButton, cell:UITableViewCell) {
        nextButton.imageView?.contentMode = .scaleAspectFit
        nextButton.contentHorizontalAlignment = .fill
        nextButton.contentVerticalAlignment = .fill
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.contentHorizontalAlignment = .fill
        backButton.contentVerticalAlignment = .fill
        dateTf.adjustsFontSizeToFitWidth = true
        dateTf.layer.borderWidth = 1
        dateTf.layer.borderColor = UIColor.black.cgColor
        let c_w = (cell.frame.size.width) / 100
        let c_h = (cell.frame.size.height) / 100
        backButton.frame = CGRect(x: c_w * 3, y: c_h * 10, width: c_w * 20, height: c_h * 80)
        nextButton.frame = CGRect(x: c_w * 77, y: c_h *  10, width: c_w * 20, height: c_h * 80)
        dateTf.frame = CGRect(x: c_w * 26, y: c_h * 10, width: c_w * 48, height: c_h * 80)
    }
    
    func setCellView1(tableView:UITableView, cell:UITableViewCell,  chartView:LineChartView) {
        let x = cell.frame.size.width / 80 * 2
        var y = cell.frame.size.height / 80 * 4
        let width = cell.frame.size.height / 80 * 3
        let height = cell.frame.size.height / 80 * 3
        for index in 0...7 {
            let scaleLabel = tableView.viewWithTag(24 - index * 2)
            scaleLabel?.frame = CGRect(x: x, y: y, width: width, height: height)
            y += cell.frame.size.height/80 * 10
        }
        cell.selectionStyle = .none
        chartView.frame = CGRect(x: cell.frame.size.width/40*3,
                                 y: cell.frame.size.height/40,
                                 width: cell.frame.size.width/40*36,
                                 height: cell.frame.size.height/40*38)
    }
    
    func setCellView2(tableView : UITableView, cell: UITableViewCell) {
        let timeLabel = tableView.viewWithTag(4) as! UILabel
        let subLabel = tableView.viewWithTag(10) as! UILabel
        let ataiLabel = tableView.viewWithTag(11) as! UILabel
        let height_cell = cell.frame.size.height
        let width_cell = cell.frame.size.width
        subLabel.frame = CGRect(x: width_cell/40*2, y: height_cell/40*2, width: width_cell/40*8, height: height_cell/40*36)
        timeLabel.frame = CGRect(x: width_cell/40*12, y: height_cell/40*2, width: width_cell/40*12, height: height_cell/40*36)
        ataiLabel.frame = CGRect(x: width_cell/40*26, y: height_cell/40*2, width: width_cell/40*14, height: height_cell/40*36)
    }
    
    func setOtherCellView(cell : UITableViewCell, subLabel:UILabel, dateLabel:UILabel, yearLabel:UILabel, ataiLabel:UILabel) {
        let height_cell = cell.frame.size.height
        let width_cell = cell.frame.size.width
        subLabel.frame = CGRect(x: width_cell/40*2, y: height_cell/40*2, width: width_cell/40*8, height: height_cell/40*36)
        dateLabel.frame = CGRect(x: width_cell/40*12, y: height_cell/40*2, width: width_cell/40*12, height: height_cell/40*25)
        yearLabel.frame = CGRect(x: width_cell/40*12, y: height_cell/40*29, width: width_cell/40*12, height: height_cell/40*9)
        ataiLabel.frame = CGRect(x: width_cell/40*26, y: height_cell/40*2, width: width_cell/40*14, height: height_cell/40*36)
    }
    
    
}
