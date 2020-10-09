//
//  UICollectionView+CellReusable.swift
//  
//
//  Created by youzy01 on 2020/9/28.
//

import UIKit

extension UICollectionView {
    // MARK: - 注册
    /// 注册cell
    func registerCell<C: UICollectionViewCell>(_ cell: C.Type) where C: CellConfigurable {
        if let nib = C.nib {
            register(nib, forCellWithReuseIdentifier: C.reuseableIdentifier)
        } else {
            register(cell, forCellWithReuseIdentifier: C.reuseableIdentifier)
        }
    }

    /// 注册header
    func registerHeaderView<C: UICollectionReusableView>(_ reusableView: C.Type) where C: CellConfigurable {
        if let nib = C.nib {
            register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: C.reuseableIdentifier)
        } else {
            register(reusableView, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: C.reuseableIdentifier)
        }
    }

    /// 注册footer
    func registerFooterView<C: UICollectionReusableView>(_ reusableView: C.Type) where C: CellConfigurable {
        if let nib = C.nib {
            register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: C.reuseableIdentifier)
        } else {
            register(reusableView, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: C.reuseableIdentifier)
        }
    }

    // MARK: - 复用
    /// 复用cell
    func dequeReusableCell<C: UICollectionViewCell>(indexPath: IndexPath) -> C where C: CellConfigurable {
        return dequeueReusableCell(withReuseIdentifier: C.reuseableIdentifier, for: indexPath) as! C
    }

    /// 复用header
    func dequeReusableHeaderView<C: UICollectionReusableView>(indexPath: IndexPath) -> C where C: CellConfigurable {
        let header = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: C.reuseableIdentifier, for: indexPath) as! C
        return header
    }

    /// 复用footer
    func dequeReusableFooterView<C: UICollectionReusableView>(indexPath: IndexPath) -> C where C: CellConfigurable {
        let footer = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: C.reuseableIdentifier, for: indexPath) as! C
        return footer
    }
}
