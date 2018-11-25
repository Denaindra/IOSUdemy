//
//  ChangeCityViewController.swift
//  Weather App
//
//  Created by gayan perera on 11/22/18.
//  Copyright © 2018 gayan perera. All rights reserved.
//

import UIKit

protocol CheckCityDeligate {
   func UserEnterNewCity(city:String)
}

class ChangeCityViewController: UIViewController {

    
    @IBOutlet weak var chnageCity: UITextField!
    var delegate : CheckCityDeligate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Backbtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func GetWeatherDetails(_ sender: Any) {
        delegate?.UserEnterNewCity(city: chnageCity.text!)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
