//
//  PuzzleCollectionViewController.swift
//  CollectionViewCatPicPuzzle
//
//  Created by Joel Bell on 10/5/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit
import Darwin

class CollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var headerReusableView: HeaderReusableView!
    var footerReusableView: FooterReusableView!
    
    var sectionInsets: UIEdgeInsets!
    var spacing: CGFloat!
    var itemSize: CGSize!
    var referenceSize: CGSize!
    var numberOfRows: CGFloat!
    var numberOfColumns: CGFloat!
    
    var imageSlices : [UIImage] = [] //i assume this is bad, what is the proper way to do this?
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return referenceSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return referenceSize
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.register(HeaderReusableView.self, forSupplementaryViewOfKind:
            UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        self.collectionView?.register(FooterReusableView.self, forSupplementaryViewOfKind:
            UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        self.configureLayout()
        for number in 1...12 {
            self.imageSlices.append(UIImage(named: "\(number)")!) //why do i need to force unwrap this?
        }
        self.randomizeCells()
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionHeader {
            headerReusableView = (self.collectionView?.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath)) as! HeaderReusableView
            return headerReusableView
        } else {
            footerReusableView = (self.collectionView?.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath)) as! FooterReusableView
            return footerReusableView
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    }
    
    func configureLayout() {
        self.numberOfRows = 4
        self.numberOfColumns = 3
        self.spacing = 2
        self.sectionInsets = UIEdgeInsetsMake(spacing, spacing, spacing, spacing)
        self.referenceSize = CGSize(width: UIScreen.main.bounds.width, height: 60)
        let itemSizeWidth = (UIScreen.main.bounds.width / self.numberOfColumns) - (self.numberOfColumns)
        let itemSizeHeight = (UIScreen.main.bounds.height / self.numberOfRows) - (spacing * 2) - (spacing * self.numberOfRows)
        itemSize = CGSize(width: itemSizeWidth,height: itemSizeHeight)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageSlices.count
    }
    
    func randomizeCells() {
        var tempArray : [UIImage] = []
        print("\n")
        while imageSlices.count > 0 {
            let randomNumber = Int(arc4random_uniform(UInt32(imageSlices.count - 1)))
            tempArray.append(imageSlices[randomNumber])
            imageSlices.remove(at: randomNumber)
        }
        self.imageSlices = tempArray
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView?.dequeueReusableCell(withReuseIdentifier: "puzzleCell", for: indexPath) as! CollectionViewCell
        cell.imageView.image = imageSlices[indexPath.item]
        return cell
    }
}
