//
//  CollectionViewController.swift
//  spotlight
//
//  Created by Qiaochu Guo on 9/8/18.
//  Copyright © 2018 SpotLight. All rights reserved.
//

import UIKit

class DetailViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var posts = [Post]()
    var Keywords = String()
    var timeline  = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let postMark = Post()
        postMark.name = Keywords
        postMark.statusText = timeline
        
        posts.append(postMark)
        
        navigationItem.title = "Feed Detail"
        navigationtitle = navigationItem.title!
        
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.backgroundColor = UIColor(white:0.95, alpha: 1)
        
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection numberOfItemInSection: Int) -> Int{
        return posts.count
    }
    
    override func collectionView(_ collectionView:UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let FeedCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        FeedCell.post = posts[indexPath.item]
        return FeedCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let statusText = posts[indexPath.item].statusText {
            
            let rect = NSString(string: statusText).boundingRect(with: CGSize(width: view.frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)], context: nil)
            
            let knownHeight: CGFloat = 8+44+8+16
            
            return CGSize(width: view.frame.width, height: rect.height+knownHeight)
        }
        
        return CGSize(width: view.frame.width, height: 500)
    }
    
}


