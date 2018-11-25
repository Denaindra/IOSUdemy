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
        self.dismiss(animated: true, completion: nil)
    }

}
