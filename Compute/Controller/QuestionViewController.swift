import UIKit
import AVFoundation

class QuestionViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var answerOne: BounceButton!
    @IBOutlet weak var answerTwo: BounceButton!
    @IBOutlet weak var answerThree: BounceButton!
    
    @IBOutlet weak var imageOne: UIImageView!
    @IBOutlet weak var imageTwo: UIImageView!
    @IBOutlet weak var imageThree: UIImageView!
    
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var timeRemaining: UILabel!
    @IBOutlet weak var questionsRemaining: UILabel!
    
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var loader: UIImageView!
    
    var questions: [CodeRushQuestion] = []
    var currentQuestion: CodeRushQuestion = CodeRushQuestion(question: "",
                                                             answer_one: "",
                                                             answer_two: "",
                                                             answer_three: "",
                                                             correct_answer: "")
    var timeLeft = 50
    var player = AVAudioPlayer()
    var progress = 0.0
    var buttons: [UIButton] = []
    var images: [UIImageView] = []
    var current: Int = 0
    var remaining: Int = 0
    var language: String = "Python"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configButton(button: answerOne)
        configButton(button: answerTwo)
        configButton(button: answerThree)
        
        images.append(imageOne)
        images.append(imageTwo)
        images.append(imageThree)
        
        questionView.customView(setup: true, color: .black)
        
        loader.image = UIImage.gifImageWithName("computeLoader")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Task {
            questions = await CodeRushBrain.shared.getQuestions(for: language)
            generateNewPage(at: current)
            startCountDown()
            checkMode()
            
            UIView.animate(withDuration: 1) {
                self.coverView.alpha = 0
            }
        }
    }
    
    func startCountDown(){
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [self] timer in
            if (timeLeft < 10) {
                timeRemaining.textColor = .orange
                if (timeLeft == 0) {
                    performSegue(withIdentifier: Constants.rushResultSegue, sender: self)
                }
            }
            timeRemaining.text = "00:\(self.timeLeft)"
            timeLeft -= 1
        }
    }
    
    func generateNewPage(at index: Int){
        
        if (progressView.progress == 1.0) {
            performSegue(withIdentifier: Constants.rushResultSegue, sender: self)
        } else {
            
            remaining += 1
            
            questionsRemaining.text = "\(remaining)/10"
            
            currentQuestion = questions[index]
            
            questionLabel.text = currentQuestion.question
            
            resetButton(for: answerOne)
            resetButton(for: answerTwo)
            resetButton(for: answerThree)
            
            imageOne.image = nil
            imageTwo.image = nil
            imageThree.image = nil
            
            generateAnswers()
        }
    }
    
    func resetButton(for btn: UIButton) -> Void{
        btn.backgroundColor = .mainColour
        btn.isEnabled = true
    }
    
    func configButton(button btn: UIButton) -> Void {
        btn.layer.cornerRadius = 20
        btn.layer.masksToBounds = true
        btn.titleLabel?.adjustsFontSizeToFitWidth = true
        buttons.append(btn)
    }
    
    func generateAnswers(){
        answerOne.setTitle(currentQuestion.answer_one, for: .normal)
        answerTwo.setTitle(currentQuestion.answer_two, for: .normal)
        answerThree.setTitle(currentQuestion.answer_three, for: .normal)
    }
    
    @IBAction func btnPressed(_ sender: UIButton) {
        if (sender.titleLabel?.text! == currentQuestion.correct_answer) {
            CodeRushBrain.shared.goodAnswer()
            progressView.setProgress(CodeRushBrain.shared.pressed(questionLabel.text!), animated: true)
            playSound(answer: "correctAnswer")
        } else {
            playSound()
            CodeRushBrain.shared.badAnswer()
        }
        beforePage()
    }
    
    func beforePage(){
        for i in 0...buttons.count-1 {
            buttons[i].isEnabled = false
            if (buttons[i].titleLabel?.text! == currentQuestion.correct_answer) {
                UIView.animate(withDuration: 0.5, animations: { [self] () -> Void in
                    
                    buttons[i].backgroundColor = .correct
                    buttons[i].setTitle("Correct", for: .normal)
                    images[i].image = UIImage(named: "thumbsUpLight")
                    
                })
            }
            else {
                UIView.animate(withDuration: 0.5, animations: { [self] () -> Void in

                    buttons[i].backgroundColor = .wrong
                    buttons[i].setTitle("Wrong", for: .normal)
                    images[i].image = UIImage(named: "wrongCrossLight")

                })
            }
        }
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { [self] timer in
            current += 1
            generateNewPage(at: current)
        }
    }
    
    func playSound(answer a: String = "wrongAnswer") {
        
        let url = Bundle.main.url(forResource: a, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
        
    }
    
    func checkMode() -> Void {
        if (traitCollection.userInterfaceStyle != .dark) {
            questionView.setGradientBackground(colorTop: .white, colorBottom: .secondary)
        } else {
            questionView.setGradientBackground(colorTop: .black, colorBottom: .secondary)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) { checkMode() }
    
}
