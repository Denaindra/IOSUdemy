import UIKit
import Firebase


class ChatViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    
    @IBOutlet weak var chatViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatTableView: UITableView!
    private var messages:[Message] = [Message]()
    @IBOutlet weak var chatBtn: UIButton!
    @IBOutlet weak var chatTextFeild: UITextField!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self,selector: #selector(keyboardWillShow),name: UIResponder.keyboardWillShowNotification,object:nil)
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(ViewTapped))
        view.addGestureRecognizer(tapgesture)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textFeildCell = UINib(nibName: "ChatTableViewCell", bundle: nil)
        self.chatTableView.register(textFeildCell, forCellReuseIdentifier: "CustomViewCell")
        chatTableView.rowHeight = UITableView.automaticDimension
        chatTableView.estimatedRowHeight = 10
        Retrivemessages()
    }
    
    @IBAction func UserLoguot(_ sender: UIBarButtonItem) {
        do{
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }
        catch{
            print("erro")
        }
    }
    
    @IBAction func MessageSend(_ sender: UIButton) {
        chatTextFeild.endEditing(true)
        chatTextFeild.isEnabled = false
        sender.isEnabled = false
        
        let messageDB = Database.database().reference().child("FireChatMessages")
        let messageDictionary = ["Sender":Auth.auth().currentUser?.email,"MessageBody":chatTextFeild.text!]
        
        messageDB.childByAutoId().setValue(messageDictionary){
            (error,reference) in
            
            if error != nil {
                print(error)
            } else {
                print("Meesage saved successfully !")
                self.chatTextFeild.isEnabled = true
                sender.isEnabled = true
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ChatTableViewCell = chatTableView.dequeueReusableCell(withIdentifier: "CustomViewCell") as! ChatTableViewCell
        cell.senderName.text = messages[indexPath.row].sender
        cell.senderMessage.text = messages[indexPath.row].messageBody
        cell.profileImage.image = UIImage(named: "egg")
        
        if messages[indexPath.row].sender == Auth.auth().currentUser?.email as String? {
            SetbackgroudColorForCurrentUser(auth: true,image:cell.profileImage)
        }
        else {
            SetbackgroudColorForCurrentUser(auth: false,image:cell.profileImage)
        }
        
        return cell
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.1)
        {
            self.chatViewBottomConstraint.constant = 0;
            self.view.layoutIfNeeded()
        }
    }
    func Retrivemessages(){
        let messageDB = Database.database().reference().child("FireChatMessages")
        messageDB.observe(.childAdded, with: { (snapshot) in
            let snapshoutvalue = snapshot.value as! Dictionary<String,String>
            let message = Message()
            message.messageBody = snapshoutvalue["MessageBody"]!
            message.sender = snapshoutvalue["Sender"]!
            self.messages.append(message)
            self.chatTableView.reloadData()
        })
    }
    
    @objc func ViewTapped (){
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        let userInfo:NSDictionary = notification.userInfo! as NSDictionary
        let keyboardFrame:NSValue = userInfo.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue
        UIView.animate(withDuration: 0.1)
        {
            self.chatViewBottomConstraint.constant = keyboardFrame.cgRectValue.height;
            self.view.layoutIfNeeded()
        }
    }
    
    func SetbackgroudColorForCurrentUser(auth:Bool,image:UIImageView)
    {
        if auth {
            image.backgroundColor = UIColor.green
        } else {
            image.backgroundColor = UIColor.red
        }
    }
}
