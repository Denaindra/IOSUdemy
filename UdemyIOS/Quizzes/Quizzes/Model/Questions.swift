import Foundation

class Question{
    
    let questionText:String!
    let answer:Bool
    
    init(text:String,correctAnszwer:Bool) {
        questionText = text
        answer = correctAnszwer
    }
}
