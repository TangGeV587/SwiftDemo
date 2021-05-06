//
//  UIImage+Extension.swift
//  SwiftDemo
//
//  Created by 玉堂赵 on 2021/4/4.
//

import Foundation

extension UIImage {
   
    
    //MARK:-  颜色生成图片
    class func imageFromColor(color:UIColor)-> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let resultImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resultImage
    }
    
    //MARK:- 裁剪圆形图片
    class func imagewithImage(image:UIImage) -> UIImage{
                let width = image.size.width
                let height = image.size.height
                let redius = ((width <= height) ? width : height)/2;
                let rect = CGRect(x: width/2-redius,y: height/2-redius,width: redius*2,height: redius*2);
                let sourceImageRef = image.cgImage
                let newImageRef =  sourceImageRef?.cropping(to: rect)
                let newImage = UIImage(cgImage: newImageRef!)
                     UIGraphicsBeginImageContextWithOptions(CGSize(width:newImage.size.width,height: newImage.size.height), false, 0);
                let path = UIBezierPath(arcCenter: CGPoint(x: newImage.size.width / 2, y: newImage.size.height / 2), radius: redius, startAngle: 0, endAngle:CGFloat(Double.pi * 2.0), clockwise: false)
                    path.addClip()
                newImage.draw(at: CGPoint.zero)
                let imageCut = UIGraphicsGetImageFromCurrentImageContext()
             return imageCut!
     }
    
    //MARK:- 重绘图片
    func reSizeImage(reSize:CGSize)->UIImage {
        //UIGraphicsBeginImageContext(reSize)
          UIGraphicsBeginImageContextWithOptions(reSize,false,UIScreen.main.scale)
          self.draw(in: CGRect(x: 0,y: 0,width: reSize.width,height: reSize.height))
          let reSizeImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
              UIGraphicsEndImageContext()
       return reSizeImage
    }
    
    //MARK:- 等比缩放
    func scaleImage(scaleSize:CGFloat)->UIImage {
            let reSize = CGSize(width:self.size.width * scaleSize,height: self.size.height * scaleSize)
         return reSizeImage(reSize: reSize)
     }
    
    //MARK:- 设置图片圆角
    public func roundImage(byRoundingCorners: UIRectCorner = UIRectCorner.allCorners, cornerRadi: CGFloat) -> UIImage? {
            return roundImage(byRoundingCorners: byRoundingCorners, cornerRadii: CGSize(width: cornerRadi, height: cornerRadi))
        }
        
        public func roundImage(byRoundingCorners: UIRectCorner = UIRectCorner.allCorners, cornerRadii: CGSize) -> UIImage? {
            
            let imageRect = CGRect(origin: CGPoint.zero, size: size)
            UIGraphicsBeginImageContextWithOptions(size, false, scale)
            defer {
                UIGraphicsEndImageContext()
            }
            let context = UIGraphicsGetCurrentContext()
            guard context != nil else {
                return nil
            }
            context?.setShouldAntialias(true)
            let bezierPath = UIBezierPath(roundedRect: imageRect,
                                          byRoundingCorners: byRoundingCorners,
                                          cornerRadii: cornerRadii)
            bezierPath.close()
            bezierPath.addClip()
            self.draw(in: imageRect)
            return UIGraphicsGetImageFromCurrentImageContext()
        }
    
    //MARK:- String生成二维码
    public static func generateQRImage(QRCodeString: String, logo: UIImage?, size: CGSize = CGSize(width: 50, height: 50)) -> UIImage? {
            guard let data = QRCodeString.data(using: .utf8, allowLossyConversion: false) else {
                return nil
            }
            let imageFilter = CIFilter(name: "CIQRCodeGenerator")
            imageFilter?.setValue(data, forKey: "inputMessage")
            imageFilter?.setValue("H", forKey: "inputCorrectionLevel")
            let ciImage = imageFilter?.outputImage
            
            // 创建颜色滤镜
            let colorFilter = CIFilter(name: "CIFalseColor")
            colorFilter?.setDefaults()
            colorFilter?.setValue(ciImage, forKey: "inputImage")
            colorFilter?.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
            colorFilter?.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1")
            
            // 返回二维码图片
            let qrImage = UIImage(ciImage: (colorFilter?.outputImage)!)
            let imageRect = size.width > size.height ?
                CGRect(x: (size.width - size.height) / 2, y: 0, width: size.height, height: size.height) :
                CGRect(x: 0, y: (size.height - size.width) / 2, width: size.width, height: size.width)
            UIGraphicsBeginImageContextWithOptions(imageRect.size, false, UIScreen.main.scale)
            defer {
                UIGraphicsEndImageContext()
            }
            qrImage.draw(in: imageRect)
            if logo != nil {
                let logoSize = size.width > size.height ?
                    CGSize(width: size.height * 0.25, height: size.height * 0.25) :
                    CGSize(width: size.width * 0.25, height: size.width * 0.25)
                logo?.draw(in: CGRect(x: (imageRect.size.width - logoSize.width) / 2, y: (imageRect.size.height - logoSize.height) / 2, width: logoSize.width, height: logoSize.height))
            }
            return UIGraphicsGetImageFromCurrentImageContext()

}
}

