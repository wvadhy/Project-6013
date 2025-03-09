//
//  BadgeViewController.swift
//  Compute
//
//  Created by William Halliday on 26/02/2025.
//

import UIKit

class BadgeViewController: UIViewController {
    
    @IBOutlet weak var rushGodView: UIView!
    @IBOutlet weak var deepDiverView: UIView!
    @IBOutlet weak var trenchView: UIView!
    @IBOutlet weak var veteranView: UIView!
    @IBOutlet weak var mainFrameView: UIView!
    @IBOutlet weak var cryptoView: UIView!
    @IBOutlet weak var curiousView: UIView!
    @IBOutlet weak var fullMarksView: UIView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews(setup: true)
//        badgeCollectionView.dataSource = self
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        setupViews(setup: false)
    }
    
    func setupViews(setup s: Bool) {
        rushGodView.customView(setup: s)
        deepDiverView.customView(setup: s)
        trenchView.customView(setup: s)
        veteranView.customView(setup: s)
        mainFrameView.customView(setup: s)
        cryptoView.customView(setup: s)
        curiousView.customView(setup: s)
        fullMarksView.customView(setup: s)
    }
    
}

//extension BadgeViewController: UICollectionViewDataSource {
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 6
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        print("creating cell")
//        let cell = badgeCollectionView.dequeueReusableCell(withReuseIdentifier: "BadgeCollectionViewCell", for: indexPath) as! BadgeCollectionViewCell
//        
//        return cell
//    }
//    
//    
//}
