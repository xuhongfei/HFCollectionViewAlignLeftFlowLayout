//
//  HFCollectionViewAlignLeftFlowLayout.swift
//  ECommerce
//
//  Created by hongfei xu on 2018/10/9.
//  Copyright © 2018 xuhongfei. All rights reserved.
//

import UIKit

@objc
protocol HFCollectionViewDelegateAlignLeftFlowLayout: UICollectionViewDelegateFlowLayout {
    
}

extension UICollectionViewLayoutAttributes {
    func alignLeftFrameWithSectionInset(_ sectionInset: UIEdgeInsets) {
        var frame = self.frame
        frame.origin.x = sectionInset.left
        self.frame = frame
    }
}

class HFCollectionViewAlignLeftFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let originalAttributes = super.layoutAttributesForElements(in: rect)
        var updatedAttributes = originalAttributes
        for attributes in originalAttributes! {
            if attributes.representedElementKind == nil {
                let index = updatedAttributes!.firstIndex(of: attributes)
                if let i = index {
                    updatedAttributes![i] = self.layoutAttributesForItem(at: attributes.indexPath)!
                }
            }
        }
        
        return updatedAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        let currentItemAttributes = super.layoutAttributesForItem(at: indexPath)
        let sectionInset = evaluatedSectionInsetForItem(at: indexPath.section)
        
        let isFirstItemInSection = indexPath.item == 0
        let layoutWidth = collectionView!.frame.size.width - sectionInset.left - sectionInset.right
        
        if isFirstItemInSection == true {
            currentItemAttributes!.alignLeftFrameWithSectionInset(sectionInset)
            return currentItemAttributes
        }
        
        let previousIndexPath = IndexPath(item: indexPath.item - 1, section: indexPath.section)
        let previousFrame = layoutAttributesForItem(at: previousIndexPath)!.frame
        let previousFrameRightPoint = previousFrame.origin.x + previousFrame.size.width
        let currentFrame = currentItemAttributes!.frame
        let strecthedCurrentFrame = CGRect(x: sectionInset.left, y: currentFrame.origin.y, width: layoutWidth, height: currentFrame.size.height)
        
        
        let isFirstItemInRow = !previousFrame.intersects(strecthedCurrentFrame)
        if isFirstItemInRow == true {
            currentItemAttributes!.alignLeftFrameWithSectionInset(sectionInset)
            return currentItemAttributes
        }
        
        var frame = currentItemAttributes!.frame
        frame.origin.x = previousFrameRightPoint + evaluatedMinimumInteritemSpacingForSection(at: indexPath.section) 
        currentItemAttributes!.frame = frame
        return currentItemAttributes
    }
    
    func evaluatedMinimumInteritemSpacingForSection(at index: NSInteger) -> CGFloat {
        
        let delegate = self.collectionView!.delegate as! HFCollectionViewDelegateAlignLeftFlowLayout
        
        let spacing = delegate.collectionView?(collectionView!, layout: self, minimumInteritemSpacingForSectionAt: index)
        if spacing == nil {
            return minimumInteritemSpacing
        }
        return spacing!
    }
    
    func evaluatedSectionInsetForItem(at index: NSInteger) -> UIEdgeInsets {
        
        let delegate = self.collectionView!.delegate as! HFCollectionViewDelegateAlignLeftFlowLayout
            
        let insets = delegate.collectionView?(collectionView!, layout: self, insetForSectionAt: index)
        if insets == nil {
            return sectionInset
        }
        
        return insets!
        
    }
}
