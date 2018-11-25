//
//  ViewController.swift
//  BitcoinTracker
//
//  Created by gayan perera on 11/25/18.
//  Copyright © 2018 gayan perera. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    private let basedURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    private let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    private let currencySimble = ["$", "R$", "$", "¥", "€", "£", "$", "Rp", "₪", "₹", "¥", "$", "kr", "$", "zł", "lei", "₽", "kr", "$", "$", "R"]
    private var symbol:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let finalURL=BuildFinalUrl(currancy: currencyArray[row])
        GetSelectedAskPrice(currencyURL: finalURL)
        symbol = currencySimble[row]
    }
    
    func GetSelectedAskPrice(currencyURL:String) {
        
        Alamofire.request(currencyURL, method: .get).responseJSON{
            response in
            
            if response.result.isSuccess
            {
                let value:JSON = JSON(response.value!)
            
                if let askPrice = value["ask"].double{
                    self.UpdateUI(result: String(askPrice))
                }
            }
            else {
                self.UpdateUI(result: "Price Unavaialable")
            }
        }
    }
    func BuildFinalUrl(currancy:String) -> String {
        return basedURL + currancy
    }
    func UpdateUI(result:String){
        bitcoinPriceLabel.text = "\(symbol!)\(result)"
    }
}

