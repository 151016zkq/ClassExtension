//
//  ViewController.swift
//  ClassExtension
//
//  Created by 151016zkq on 04/02/2022.
//  Copyright (c) 2022 151016zkq. All rights reserved.
//

import UIKit
import ClassExtension
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.image2.image = self.view.clip()
    }
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

