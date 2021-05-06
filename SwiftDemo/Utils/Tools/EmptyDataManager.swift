//
//  EmptyDataManager.swift
//  SwiftDemo
//
//  Created by 玉堂赵 on 2021/4/5.
//

import Foundation

enum EmptyViewType {
    case EmptyViewNotShowType,EmptyViewNoDataType,EmptyViewNoNetworkType,EmptyViewDataErrorType
}

class EmptyDataManager:NSObject,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    var errorType:EmptyViewType = .EmptyViewNoDataType
    var customEmptyView:UIView?
    
    var emptyImageName:String = "no_data_status"
    var emptyTitle:String = " "
    var emptyColor:UIColor = .white
    var error:NSError? {
        didSet {
            if error == nil {
                errorType = .EmptyViewNoDataType
            }else {
                if error!.code == -1009 {
                    errorType = .EmptyViewNoNetworkType
                }else {
                    errorType = .EmptyViewDataErrorType
                }
            }
        }
    }
    
    //MARK- - DZNEmptyDataSetSource
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        UIImage(named: emptyImageName)
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        var errorMsg:String
        switch errorType {
        case .EmptyViewNoDataType:
            errorMsg = ""
        case .EmptyViewNoNetworkType:
            errorMsg = "网络连接失败"
        case .EmptyViewDataErrorType:
            errorMsg = error!.localizedDescription
        default:
            errorMsg = ""
        }
        return atttributeStr(true, text: errorMsg)
    }

    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        if errorType == .EmptyViewNoDataType {
           return atttributeStr(false, text: emptyTitle)
        }else {
            return atttributeStr(false, text: "请检查您的网络设置或重新加载")
        }
        
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        emptyColor
    }
    
//    func customView(forEmptyDataSet scrollView: UIScrollView!) -> UIView! {
//        customEmptyView
//    }
//
    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        if scrollView.isKind(of: UITableView.self) {
            let tableV = scrollView as! UITableView
            return (tableV.tableHeaderView?.height ?? 0.0) * 0.5
        }
        return 0.0
    }
    
    func spaceHeight(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        return 20
    }
    
    
    ///DZNEmptyDataSetDelegate
    
    func emptyDataSetWillAppear(_ scrollView: UIScrollView!) {
        scrollView.contentInset = .zero
        print("dddd")

    }
    
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return errorType !=  .EmptyViewNotShowType
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> NSAttributedString! {
        if errorType != .EmptyViewNoDataType {
            let attributes = [NSAttributedString.Key.font:SystemFont(15.0),
                              NSAttributedString.Key.foregroundColor: UIColor.black]
            return NSAttributedString(string: "重新加载", attributes: attributes as [NSAttributedString.Key : Any])
        }
        return nil
    }
    
    func buttonBackgroundImage(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> UIImage! {
        if errorType != .EmptyViewNoDataType {
            return UIImage(named: "btn_bg")
        }else {
            return nil
        }
    }
    
 

    func emptyDataSetDidAppear(_ scrollView: UIScrollView!) {
        let btn = scrollView.value(forKeyPath: "emptyDataSetView.button") as! UIButton
        for constraint in btn.superview!.constraints {
            if ( constraint.firstAttribute == NSLayoutConstraint.Attribute.leading) {
                constraint.constant = 108;
            } else if (constraint.secondAttribute == NSLayoutConstraint.Attribute.trailing) {
                constraint.constant = 108;
            }
        }
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        if scrollView.isKind(of: UITableView.self) {
            let tableV = scrollView as! UITableView
            tableV.mj_header?.beginRefreshing()
        }
    }
    
    
    
    
    ///MARK- 私有方法
    func atttributeStr(_ isTitle:Bool,text:String ) -> NSAttributedString {
        if isTitle == true {
            let attributes = [NSAttributedString.Key.font:MediumFont(14.0),
                              NSAttributedString.Key.foregroundColor: UIColor.black]
            return NSAttributedString(string: text, attributes: attributes as [NSAttributedString.Key : Any])
        }else {
            let paragraph = NSMutableParagraphStyle()
            paragraph.lineBreakMode = .byWordWrapping
            paragraph.alignment = .center
            let attributes = [NSAttributedString.Key.font:SystemFont(13.0),
                              NSAttributedString.Key.foregroundColor: UIColor.gray,
                              NSAttributedString.Key.paragraphStyle:paragraph]
            return NSAttributedString(string: text, attributes: attributes as [NSAttributedString.Key : Any])
        }
    }
    
    func getNoDataImage() -> String {
        switch errorType {
        case .EmptyViewNoDataType:
            emptyImageName = "no_data_status"
        case .EmptyViewNoNetworkType:
            emptyImageName = "no_network_status"
        default:
            emptyImageName = "no_network_status"
        }
        return emptyImageName
    }
    
    
}
