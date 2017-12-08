//
//  CollectionViewLayout.swift
//  SwiftCollectionDemo
//
//  Created by 高鑫 on 2017/12/5.
//  Copyright © 2017年 高鑫. All rights reserved.
//

import UIKit

class CollectionViewLayout: UICollectionViewLayout {
    
    let normalCellH : CGFloat = 100
    let previewCellH : CGFloat = 200
    let dragOffest : CGFloat = 180
    var attributes = [UICollectionViewLayoutAttributes]()
    
    var previewItemIndex : Int {
        get{
            return max(0, Int(self.collectionView!.contentOffset.y / dragOffest))
        }
    }

    var nextItemOffset: CGFloat {
        get {
            return (self.collectionView!.contentOffset.y / dragOffest) - CGFloat(previewItemIndex)
        }
    }
    
    var width : CGFloat {
        get {
            return self.collectionView!.bounds.width
        }
    }

    var height : CGFloat {
        get {
            return self.collectionView!.bounds.height
        }
    }
    
    var numberOfItem : Int {
        get {
            return self.collectionView!.numberOfItems(inSection: 0)
        }
    }
    
    override var collectionViewContentSize: CGSize {
        let contentH = (CGFloat(numberOfItem) * dragOffest) + (height - dragOffest)
        return CGSize(width: width, height: contentH)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for i in attributes {
            if i.frame.intersects(rect) {
                layoutAttributes.append(i)
            }
        }
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func prepare() {
        super.prepare()
        self.attributes.removeAll()
        var frame : CGRect = .zero
        var y : CGFloat = 0
        
        for item in 0..<numberOfItem {
            let indexPath = IndexPath(item: item, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.zIndex = item
            var height = normalCellH
            
            if indexPath.item == previewItemIndex {
                let yOffest = normalCellH * nextItemOffset
                y = self.collectionView!.contentOffset.y - yOffest
                height = previewCellH
            } else if indexPath.item == (previewItemIndex + 1) && indexPath.item != numberOfItem {
                let maxY = y + normalCellH
                height = normalCellH + max((previewCellH - normalCellH) * nextItemOffset, 0)
                y = maxY - height
            }
            
            frame = CGRect(x: 0, y: y, width: width, height: height)
            attributes.frame = frame
            self.attributes.append(attributes)
            y = frame.maxY
        }
        self.collectionView?.reloadData()
        
    }

}
