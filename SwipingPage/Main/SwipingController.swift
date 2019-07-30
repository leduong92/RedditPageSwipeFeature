//
//  SwipingController.swift
//  SwipingPage
//
//  Created by Mai Le Duong on 7/30/19.
//  Copyright © 2019 Mai Le Duong. All rights reserved.
//

import UIKit

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout, MenuControllerDelegate {
    
    func didTapMenuItem(indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    
    fileprivate let menuController = MenuController(collectionViewLayout: UICollectionViewFlowLayout())
    
    fileprivate let cellID = "cellId"
    fileprivate let colors: [UIColor] = [.red, .green, .blue]
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let offset = x / 3
        menuController.menuBar.transform = CGAffineTransform(translationX: offset, y: 0)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        let item = x / view.frame.width
        let indexPath = IndexPath(item: Int(item), section: 0)
        menuController.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        navigationItem.title = "Reddit Page Swipe Feature"
        
        
        if let layout = collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        
        menuController.delegate = self
        menuController.collectionView.selectItem(at: [0, 0], animated: true, scrollPosition: .centeredHorizontally)
        collectionView.allowsSelection = true
        
        setupLayout()
        collectionView.register(MainCell.self, forCellWithReuseIdentifier: cellID)
    }
    
    fileprivate func setupLayout() {
    
        let menuView = menuController.view!
        menuView.backgroundColor = .yellow

        view.addSubview(menuView)
        menuView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: .init(width: 0, height: 60))
        
        collectionView.backgroundColor = .white
        collectionView.anchor(top: menuView.bottomAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MainCell
        cell.backgroundColor = colors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: view.frame.height - 60 - 44 - UIApplication.shared.statusBarFrame.height)
    }
}
