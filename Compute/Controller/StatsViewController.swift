//
//  StatsViewController.swift
//  Compute
//
//  Created by William Halliday on 19/02/2025.
//

import Charts
import UIKit
import FirebaseAuth

class StatsViewController: UIViewController, ChartViewDelegate {
    
    @IBOutlet weak var pieView: UIView!
    @IBOutlet weak var streakView: UIView!
    @IBOutlet weak var growthView: UIView!
    @IBOutlet weak var pieGrowthView: UIView!
    @IBOutlet weak var growthRateView: UIView!
    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var accountStatsView: UIView!
    @IBOutlet weak var codeRushHighScore: UILabel!
    @IBOutlet weak var codeRushAverage: UILabel!
    @IBOutlet weak var pointsView: UIView!
    @IBOutlet weak var rankView: UIView!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var pointsItem: UIBarButtonItem!
    @IBOutlet weak var nameLabel: UILabel!
    
    var statsBrain: StatsBrain = StatsBrain()
    var coins: Int = UserData.shared.coins
    var rank: Int = UserData.shared.rank
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
            
        codeRushHighScore.text = String(CodeRushBrain.shared.calculateHighScore())
        
        codeRushAverage.text = String(CodeRushBrain.shared.calculateAverage())
        
        rankLabel.text = "\(rank)"
        pointsItem.title = "₡ \(coins)"
        nameLabel.text = UserData.shared.name
        
        let barChart = statsBrain.createBarChart()
        let pieChart = statsBrain.createPieChart()
        let lineChart = statsBrain.createLineChart()
        let pieGrowthChart = statsBrain.createPieChart()
        
        pieChart.delegate = self
        lineChart.delegate = self
        pieGrowthChart.delegate = self
        
        pieView.addSubview(pieChart)
        growthRateView.addSubview(lineChart)
        pieGrowthView.addSubview(pieGrowthChart)
        
        setupViews(setup: true)
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print(signOutError)
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupViews(setup: false)
    }
    
    func setupViews(setup s: Bool) -> Void {
        streakView.customView(setup: s)
        growthView.customView(setup: s)
        rateView.customView(setup: s)
        accountStatsView.customView(setup: s)
        pointsView.customView(setup: s)
        rankView.customView(setup: s)
    }

}

extension UIView {
    
    enum GlowEffect: Float {
        case small = 0.4, normal = 2, big = 15
    }

    func doGlowAnimation(withColor color: UIColor, withEffect effect: GlowEffect = .normal) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowRadius = .zero
        layer.shadowOpacity = 1
        layer.shadowOffset = .zero
    
        let glowAnimation = CABasicAnimation(keyPath: "shadowRadius")
        glowAnimation.fromValue = Int.zero
        glowAnimation.toValue = effect.rawValue
        glowAnimation.beginTime = CACurrentMediaTime()
        glowAnimation.duration = CFTimeInterval(0.3)
        glowAnimation.fillMode = .removed
        glowAnimation.autoreverses = true
        glowAnimation.isRemovedOnCompletion = true
        layer.add(glowAnimation, forKey: "shadowGlowingAnimation")
    }
    
  func dropShadow(color: UIColor, opacity: Float = 1, offSet: CGSize, radius: CGFloat = 4, scale: Bool = true) {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius

    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
    
  func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
    gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
    gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
    gradientLayer.locations = [0, 1]
    gradientLayer.frame = bounds

    layer.insertSublayer(gradientLayer, at: 0)
  }
    
  func customView(setup valid: Bool = false, color bgc: UIColor = .mainColour) -> Void {
      if (valid == true){
          layer.cornerRadius = 10
          layer.masksToBounds = true
      }
      dropShadow(color: bgc, offSet: CGSize(width: -1, height: 1))
  }
    
}
