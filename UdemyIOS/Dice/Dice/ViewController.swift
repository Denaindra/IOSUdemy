//
//  ViewController.swift
//  Dice
//
//  Created by gayan perera on 11/17/18.
//  Copyright © 2018 gayan perera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dice1Img: UIImageView!
    @IBOutlet weak var dice2Img: UIImageView!
    
    private var rollDice1 : Int = 0;
    private var rollDice2 : Int = 0;
    
    let rollnumber = ["dice1","dice2","dice3","dice3","dice4","dice5","dice6"]
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        RollingCubicles()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func RollClick(_ sender: Any) {
        RollingCubicles()
    }
    
    func RollingCubicles() {
        rollDice1 = Int(arc4random_uniform(6))
        rollDice2 = Int(arc4random_uniform(6))
        
        dice1Img.image = UIImage.init(named: rollnumber[rollDice1])
        dice2Img.image = UIImage.init(named: rollnumber[rollDice2])

    }
    
    
}

