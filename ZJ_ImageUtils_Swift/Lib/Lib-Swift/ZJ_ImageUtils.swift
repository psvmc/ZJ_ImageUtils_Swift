//
//  ImageUtils.swift
//  ecms_ios
//
//  Created by 张剑 on 15/6/29.
//
//

import Foundation
import UIKit

///图片工具类
class ZJ_ImageUtils{
    
    ///文子转图片
    static func imageFromText(bgColor:UIColor,str:NSString,imageWidth:CGFloat)->UIImage{
        
        let size = CGSizeMake(imageWidth, imageWidth);
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0);
        let context:CGContextRef =  UIGraphicsGetCurrentContext()!;//获取画笔上下文
        
        CGContextSetAllowsAntialiasing(context, true) //抗锯齿设置
        
        
        //设置背景色
        bgColor.set();
        UIRectFill(CGRectMake(0, 0, size.width, size.height));
        
        let fontWidth = imageWidth/1.4/2;
        
        
        let y = (imageWidth - fontWidth*1.3)/2;
        //画字符串
        let font = UIFont.systemFontOfSize(fontWidth);
        
        let attrs = [NSFontAttributeName:font,NSForegroundColorAttributeName:UIColor.whiteColor()];
        
        if(str.length>=2){
            let subStr:NSString = str.substringFromIndex(str.length-2);
            let x = (imageWidth - subStr.sizeWithAttributes(attrs).width)/2;
            subStr.drawAtPoint(CGPointMake(x, y), withAttributes:attrs);
        }else if(str.length==1){
            let x = (imageWidth - str.sizeWithAttributes(attrs).width)/2;
            str.drawAtPoint(CGPointMake(x, y), withAttributes:attrs);
        }else{
            
        }
        
        // 转成图片
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
        
    }
    
    ///指定大小缩放
    static func imageZoomBySize(sourceImage:UIImage,newSize:CGSize)->UIImage{
        UIGraphicsBeginImageContext(newSize);
        sourceImage.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height));
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return newImage;
    }
    
    ///等比例缩放,最大宽度,小图片不放大
    static func imageZoomByWidth(sourceImage:UIImage,maxWidth:CGFloat) -> UIImage{
        let imageSize = sourceImage.size;
        let width = imageSize.width;
        let height = imageSize.height;
        let targetWidth = (width >= maxWidth ? maxWidth : width);
        let targetHeight = (targetWidth / width) * height;
        if(targetWidth==width){
            return sourceImage;
        }else{
            return imageZoomBySize(sourceImage, newSize: CGSizeMake(targetWidth, targetHeight))
        }
        
    }
    
    ///等比例缩放,最大高度,小图片不放大
    static func imageZoomByHeight(sourceImage:UIImage,maxHeight:CGFloat) -> UIImage{
        let imageSize = sourceImage.size;
        let width = imageSize.width;
        let height = imageSize.height;
        let targetHeight = (height >= maxHeight ? maxHeight : height);
        let targetWidth = (targetHeight / height) * width;
        if(targetHeight==height){
            return sourceImage;
        }else{
            return imageZoomBySize(sourceImage, newSize: CGSizeMake(targetWidth, targetHeight))
        }
    }
    
    ///等比例缩放,最大高度,最大宽度,小图片不放大
    static func imageZoomByWidthHeight(sourceImage:UIImage,maxWidth:CGFloat,maxHeight:CGFloat) -> UIImage{
        let imageSize = sourceImage.size;
        let width = imageSize.width;
        let height = imageSize.height;
        
        if(width < maxWidth && height < maxHeight){
            return sourceImage;
        }else{
            let widthRatio = width / maxWidth;
            let heightRatio = height / maxHeight;
            let maxRatio = widthRatio > heightRatio ? widthRatio : heightRatio;
            let targetHeight = height / maxRatio;
            let targetWidth = width / maxRatio;
            print("targetWidth:\(targetWidth)")
            print("targetHeight:\(targetHeight)")
            return imageZoomBySize(sourceImage, newSize: CGSizeMake(targetWidth, targetHeight))
        }
    }
    
    ///压缩JPG
    static func imageCompressJPG(sourceImage:UIImage)->NSData{
        return UIImageJPEGRepresentation(sourceImage, 0.7)!;
    }
    
    ///压缩PNG
    static func imageCompressPng(sourceImage:UIImage)->NSData{
        return UIImagePNGRepresentation(sourceImage)!;
    }
    
    ///图片模糊处理
    static func mohu(sourceImage:UIImage) -> UIImage{
        let context:CIContext = CIContext(options: nil);
        let inputImage = CIImage(image: sourceImage);
        
        // create gaussian blur filter
        
        let filter = CIFilter(name: "CIGaussianBlur")!;
        filter.setValue(inputImage, forKey: kCIInputImageKey);
        filter.setValue(NSNumber(float: 1.0), forKey: "inputRadius");
        
        // blur image
        
        let result:CIImage = filter.valueForKey(kCIOutputImageKey) as! CIImage;
        
        let cgImage:CGImageRef = context.createCGImage(result, fromRect: result.extent);
        let image = UIImage(CGImage: cgImage);
        return image;
    }
    
    ///保存image为jpg文件
    static func saveJpg(sourceImage:UIImage) -> (Bool,String){
        let newImage = imageZoomByWidthHeight(sourceImage, maxWidth: 800, maxHeight: 800);
        let uuidStr = ZJ_StringUtils.getUUID();
        let documentsPath: AnyObject = NSSearchPathForDirectoriesInDomains(.DocumentDirectory,.UserDomainMask,true)[0]
        let jpgPath = documentsPath.stringByAppendingString("/\(uuidStr).jpg");
        print(sourceImage)
        let result = UIImageJPEGRepresentation(newImage, 0.7)!.writeToFile(jpgPath, atomically: true);
        if(result){
            return (true,jpgPath);
        }else{
            return (false,jpgPath);
        }
    }
}
