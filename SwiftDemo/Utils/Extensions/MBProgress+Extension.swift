//
//  MBProgress+Extension.swift
//  SwiftDemo
//
//  Created by 玉堂赵 on 2021/4/5.
//

import Foundation

extension MBProgressHUD {
   static var kDuration:TimeInterval {
        2.0
    }
    
    ///展示文本信息
    static func showMessage(msg:String, detailMsg:String? = nil) {
        let hud = createHud(msg: msg, view: getWindow(),duration:kDuration,callBack: nil)
        hud.mode = .text
        if detailMsg != nil {
         hud.detailsLabel.text = detailMsg
        }
    }
    
    ///展示指示器
    @discardableResult
    static func showLoadActivity(msg:String,view:UIView? = nil) -> MBProgressHUD {
        let hud = createHud(msg: msg, view: view ?? getWindow(),duration: kDuration,callBack: nil)
        hud.mode = .indeterminate
        return hud
    }
    
    ///隐藏指示器并提示信息
    static func showRequestMessage(msg:String,view:UIView? = nil) {
        
        let hud = MBProgressHUD.forView(view ?? getWindow())
        if hud != nil {
            DispatchQueue.main.async {
                hud!.mode = .text;
                hud!.label.text = msg;
                hud!.label.numberOfLines = 0;
                hud?.hide(animated: true, afterDelay: kDuration)
            }
        }else {
            showMessage(msg: msg)
        }
    }
    
    
    static func createHud(msg: String? ,
                          view: UIView,
                          duration: TimeInterval?,
                          callBack: (() -> ())? ) -> MBProgressHUD {
        
        //        let shwoView = view ?? UIApplication.shared.delegate?.window
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        if msg != nil {
            hud.label.text = msg
        }
        // 隐藏时候从父控件中移除
        hud.removeFromSuperViewOnHide = true;
        hud.areDefaultMotionEffectsEnabled = false;
        hud.minSize = .zero;
        hud.margin = 10;
        if callBack != nil {
            hud.completionBlock = callBack!
        }
        hud.detailsLabel.font =  MediumFont(15.0)
        hud.label.font =  MediumFont(15.0)
        hud.backgroundView.color = .clear
        hud.backgroundView.style = .solidColor;
        hud.bezelView.style = .solidColor;
        // 注释下面配置代码默认显示浅灰->
        hud.bezelView.color = UIColor.hexString("#141414", alpha: 0.9)
        hud.label.textColor = .white
        hud.label.numberOfLines = 0;
        hud.contentColor =  .white
        if duration != nil  {
            hud.hide(animated: true, afterDelay: duration!)
        }
        return hud
    }
    
    ///获取窗口
    static func getWindow() -> UIWindow {
         var window:UIWindow
         if #available(iOS 13.0, *) {
             window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).last!
         }else {
             window = UIApplication.shared.keyWindow!
         }
         return window
     }
     
}
