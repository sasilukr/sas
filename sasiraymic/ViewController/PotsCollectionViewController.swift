//
//  PotsCollectionViewController.swift
//  sasiraymic
//
//  Created by Sasi Ruangrongsorakai on 1/1/18.
//  Copyright © 2018 com.sasiluk. All rights reserved.
//

import Foundation

class PotsCollectionViewController: UIViewController  {
    
    var collectionView: UICollectionView?

    var pots = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
        self.collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self
        self.collectionView?.register(PotCollectionViewCell.self, forCellWithReuseIdentifier: "PotCollectionViewCell")
        
        self.view.addSubview(self.collectionView!)
        func successBlock(results: NSArray) -> Void {
            if let results = results as? [[String: Any]] {
                // TODO find better way to validate data
                self.pots.removeAll()
                for result in results {
                    if let pot = result["attachment"] as? String {
                        self.pots.append(result)
                    }
                }
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
            }
        }
        func failureBlock(responseObject: Any?) -> Void {
            print("\(#function)")
        }
        
        ApiClient.shared.getPots(success: successBlock, failure: failureBlock)

    }
}


extension PotsCollectionViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dimension = ((UIScreen.main.bounds.width-20)/3)
        return CGSize(width: dimension, height: dimension)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pots.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard indexPath.item >= 0, indexPath.item < pots.count,
            let imageUrlString = self.pots[indexPath.item]["attachment"] as? String
            else {
                return UICollectionViewCell()
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PotCollectionViewCell",
                                                      for: indexPath) as! PotCollectionViewCell
        
        cell.setup(url: imageUrlString)
        return cell
        
    }
    
}

