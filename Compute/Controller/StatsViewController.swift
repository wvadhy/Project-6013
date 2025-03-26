//
//  StatsViewController.swift
//  Compute
//
//  Created by William Halliday on 19/02/2025.
//

import Charts
import UIKit
import FirebaseAuth

class StatsViewController: UIViewController, ChartViewDelegate, UISearchBarDelegate {
    
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
    @IBOutlet weak var learningTimeLabel: UILabel!
    @IBOutlet weak var tasksCompletedLabel: UILabel!
    @IBOutlet weak var totalPointsButton: UIButton!
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var statsBrain: StatsBrain = StatsBrain()
    var searchLogic: SearchBarLogic = SearchBarLogic()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        Task {
            let points = await UserData.shared.query(for: "pointsTotal")
            let gold = await UserData.shared.query(for: "gold")
            rankLabel.text = await UserData.shared.query(for: "rank")
            pointsItem.title = "£\(gold)"
            nameLabel.text = await UserData.shared.query(for: "name")
            tasksCompletedLabel.text = await UserData.shared.query(for: "totalGamesPlayed")
            totalPointsButton.setTitle("\(points) total points", for: .normal)
            
            codeRushHighScore.text = await CodeRushBrain.shared.getHighScore()
            codeRushAverage.text = await CodeRushBrain.shared.getAverage()
        }
        
        let barChart = statsBrain.createBarChart()
        let pieChart = statsBrain.createPieChart()
        let lineChart = statsBrain.createLineChart()
        let pieGrowthChart = statsBrain.createPieChart()
        
        pieChart.delegate = self
        lineChart.delegate = self
        pieGrowthChart.delegate = self
        searchBar.delegate = self
        
        pieView.addSubview(pieChart)
        growthRateView.addSubview(lineChart)
        pieGrowthView.addSubview(pieGrowthChart)
        
        setupViews(setup: true)
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIBarButtonItem) -> Void {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print(signOutError)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) -> Void {
        print("Search clicked!")
        Task {
            let user: StatsData = await searchLogic.resolveQuery(for: searchBar.text ?? "None")
            if (user.validated) {
                updateStats(with: user)
            }
            searchBar.endEditing(true)
        }
    }
    
    func updateStats(with data: StatsData) -> Void {
        rankLabel.text = "\(data.rank)"
        nameLabel.text = data.name
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) -> Void {
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

    func doGlowAnimation(withColor color: UIColor, withEffect effect: GlowEffect = .normal) -> Void {
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
    
  func dropShadow(color: UIColor, opacity: Float = 1, offSet: CGSize, radius: CGFloat = 4, scale: Bool = true) -> Void {
    layer.masksToBounds = false
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius

    layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = scale ? UIScreen.main.scale : 1
  }
    
  func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) -> Void {
    let gradientLayer = CAGradientLayer()
    gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
    gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
    gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
    gradientLayer.locations = [0, 1]
    gradientLayer.frame = bounds

    layer.insertSublayer(gradientLayer, at: 0)
  }
    
  func customView(setup valid: Bool = false, color bgc: UIColor = .mainColour) -> Void {
      if (valid == true) {
          layer.cornerRadius = 10
          layer.masksToBounds = true
      }
      dropShadow(color: bgc, offSet: CGSize(width: -1, height: 1))
  }
    
}
