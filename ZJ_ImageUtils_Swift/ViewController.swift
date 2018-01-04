//
//  ViewController.swift
//  ZJ_ImageUtils_Swift
//
//  Created by 张剑 on 16/3/4.
//  Copyright © 2016年 张剑. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView01: UIImageView!
    @IBOutlet weak var imageView02: UIImageView!
    @IBOutlet weak var imageView03: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView01.layer.cornerRadius = imageView01.frame.width/2;
        imageView01.layer.masksToBounds = true;
        imageView01.image = ZJ_ImageUtils.imageFromText(UIColor.grayColor(), str: "小明", imageWidth: 64);
        
        imageView02.layer.cornerRadius = imageView02.frame.width/2;
        imageView02.layer.masksToBounds = true;
        imageView02.image = ZJ_ImageUtils.imageFromText(UIColor.greenColor(), str: "小红帽", imageWidth: 64);
        
        imageView03.layer.cornerRadius = imageView03.frame.width/2;
        imageView03.layer.masksToBounds = true;
        imageView03.image = ZJ_ImageUtils.imageFromText(UIColor.lightGrayColor(), str: "花", imageWidth: 64);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

