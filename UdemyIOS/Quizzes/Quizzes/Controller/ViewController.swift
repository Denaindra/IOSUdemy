//
//  ViewController.swift
//  Quizzes
//
//  Created by gayan perera on 11/18/18.
//  Copyright © 2018 gayan perera. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    
    @IBOutlet weak var quizzTex: UILabel!
    @IBOutlet weak var progressText: UILabel!
    @IBOutlet weak var scoreText: UILabel!
    // @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var progressWidth: NSLayoutConstraint!
    
    private let questionList = QuestionBank();
    private var pickedAnswer : Bool!
    private var questionNumber : Int = 0
    private var score : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UpdateUI()
        NextQuestion()
    }
    
    @IBAction func AnswerClick(_ sender: UIButton) {
        if sender.tag == 1 {
            pickedAnswer = true
        }else if sender.tag == 0 {
            pickedAnswer = false
        }
        
        questionNumber += 1
        CheckAnswer()
        NextQuestion();
        
    }
    
    func UpdateUI() {
        scoreText.text = "Score:\(score)"
        progressText.text = "\(questionNumber + 1)/13"
        progressWidth.constant = (view.frame.size.width / 13) * CGFloat(questionNumber + 1)

    }
    
    func CheckAnswer() {
        let curretAnswer = questionList.list[questionNumber].answer
        if curretAnswer == pickedAnswer{
            score += 1
            ProgressHUD.showSuccess("Correct")
        }
        else{
            ProgressHUD.showError("in Correct")
        }
        UpdateUI()
    }
    
    func NextQuestion() {
        
        if questionNumber <= 12 {
            quizzTex.text = questionList.list[questionNumber].questionText
        }
        else {
            let alert = UIAlertController(title: "Awsome", message: "Tour completed all questions", preferredStyle:.alert)
            alert.addAction(UIAlertAction(title: "Restart", style:.default, handler: { action in
                self.StartOver()
            }))
            present(alert,animated: true, completion: nil)
        }
    }
    func StartOver()
    {
        questionNumber = 0;
        NextQuestion()
    }

}

