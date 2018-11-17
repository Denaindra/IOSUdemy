//
//  ViewController.swift
//  MagicBall
//
//  Created by gayan perera on 11/17/18.
//  Copyright © 2018 gayan perera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private let status = ["ball1","ball2","ball3","ball4","ball5"]
    
    @IBOutlet weak var magicBallImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func AskBtnClick(_ sender: Any) {
        RollingBall()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func RollingBall(){
         magicBallImg.image = UIImage.init(named: status[Int(arc4random_uniform(5))])
        
    }
}

