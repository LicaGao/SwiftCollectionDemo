//
//  HorizontalCollectionViewLayout.swift
//  SwiftCollectionDemo
//
//  Created by 高鑫 on 2017/12/6.
//  Copyright © 2017年 高鑫. All rights reserved.
//

import UIKit

class HorizontalCollectionViewLayout: UICollectionViewFlowLayout {
    
    let distance : CGFloat = 200
    let zoom = 0.3
    let rotate = (Double.pi / 180) * 35
    var attributes = [UICollectionViewLayoutAttributes]()
    
    override func prepare() {
        super.prepare()
        self.itemSize = CGSize(width: 300, height: 300)
        self.scrollDirection = .horizontal
        self.minimumLineSpacing = 0.0
        let centerX = (UIScreen.main.bounds.width - self.itemSize.width) / 2
        self.sectionInset = UIEdgeInsets(top: 0, left: centerX, bottom: 0, right: centerX)
        
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let array = super.layoutAttributesForElements(in: rect)

        let visibleRect = CGRect(origin: self.collectionView!.contentOffset, size: self.collectionView!.bounds.size)
        for attributes in array! {
            let distance = visibleRect.midX - attributes.center.x

            if attributes.frame.intersects(rect) {
                let normalDistance = distance / self.distance
                if abs(distance) < self.distance {
                    let zoom = CGFloat(rotate) * normalDistance
                    var transform = CATransform3DIdentity
                    transform.m34 = 1.0 / 600
                    transform = CATransform3DRotate(transform, -zoom, 0, 1, 0)
                    attributes.transform3D = transform
                    attributes.zIndex = 1
                } else {
                    var transform = CATransform3DIdentity
                    transform.m34 = 1.0 / 600
                    if distance > 0 {
                        transform = CATransform3DRotate(transform, CGFloat(-rotate), 0, 1, 0)
                    } else {
                        transform = CATransform3DRotate(transform, CGFloat(rotate), 0, 1, 0)
                    }
                    attributes.transform3D = transform
                    attributes.zIndex = 1
                }
            }
        }
        return array
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var offsetAdjustment = MAXFLOAT
        let horizontalCenter = proposedContentOffset.x + (self.collectionView!.bounds.width / 2)
        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: self.collectionView!.bounds.size.width, height: self.collectionView!.bounds.size.height)
        let array = super.layoutAttributesForElements(in: targetRect)
        for attri in array! {
            let itemCenterX = attri.center.x
            if abs(itemCenterX - horizontalCenter) < CGFloat(abs(offsetAdjustment)) {
                offsetAdjustment = Float(itemCenterX - horizontalCenter)
            }
        }
        
        return CGPoint(x: proposedContentOffset.x + CGFloat(offsetAdjustment), y: proposedContentOffset.y)
    }
    
}
