//
//  ViewController.swift
//  SwiftCollectionDemo
//
//  Created by 高鑫 on 2017/12/5.
//  Copyright © 2017年 高鑫. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.backgroundColor = UIColor.Palette()[indexPath.item]
        return cell
    }

}

class CollectionViewCell: UICollectionViewCell {
    
}

extension UIColor {
    class func Palette() -> [UIColor] {
        let palette = [UIColor.darkGray,
                       UIColor.cyan,
                       UIColor.red,
                       UIColor.blue,
                       UIColor.yellow,
                       UIColor.orange,
                       UIColor.purple,
                       UIColor.green,
                       UIColor.yellow,
                       UIColor.brown]
        return palette
    }
}

