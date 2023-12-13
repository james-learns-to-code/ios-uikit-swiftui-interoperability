//
//  CollectionViewController.swift
//  UIKitSwiftUI
//
//  Created by Dongseok Lee on 12/13/23.
//

import UIKit
import SwiftUI

class CollectionViewController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
    }
}

extension CollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        cell.contentConfiguration = UIHostingConfiguration {
            CellView()
        }
        return cell
    }
}

struct CellView: View {
    var body: some View {
        Label("Heart Rate", systemImage: "heart.fill")
    }
}
