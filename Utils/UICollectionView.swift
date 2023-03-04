//
//  UICollectionView.swift
//  MybkMobile
//
//  Created by DucTran on 25/02/2023.
//

import Foundation
import UIKit

public extension UICollectionView {
    
    // MARK: - Register
    
    func registerClass<T: UICollectionViewCell>(_ class: T.Type) {
        register(T.self, forCellWithReuseIdentifier: String(describing: T.self))
    }
    
    func registerNib<T: UICollectionViewCell>(_ class: T.Type) {
        register(UINib(nibName: String(describing: T.self), bundle: Bundle(for: T.self)), forCellWithReuseIdentifier: String(describing: T.self))
    }
    
    func registerClassReusableView<T: UICollectionReusableView>(_ class: T.Type, for kind: String) {
        register(T.self, forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: T.self))
    }
    
    func registerNibReusableView<T: UICollectionReusableView>(_ class: T.Type, for kind: String) {
        register(UINib(nibName: String(describing: T.self), bundle: Bundle(for: T.self)), forSupplementaryViewOfKind: kind, withReuseIdentifier: String(describing: T.self))
    }
    
    // MARK: - Dequeue
    
    func dequeueCell<T: UICollectionViewCell>(_ cell: T.Type = T.self, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
    }
    
    func dequeueReusableView<T: UICollectionReusableView>(_ cell: T.Type = T.self, ofKind kind: String, for indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: T.self), for: indexPath) as! T
    }
    
}

public extension UICollectionView {
    func register<T: UICollectionViewCell>(_ aClass: T.Type) {
        let name = String(describing: aClass)
        let bundle = Bundle(for: T.self)
        if bundle.path(forResource: name, ofType: "nib") != nil {
            let nib = UINib(nibName: name, bundle: bundle)
            register(nib, forCellWithReuseIdentifier: name)
        } else {
            register(aClass, forCellWithReuseIdentifier: name)
        }
    }

    func register<T: UICollectionReusableView>(header aClass: T.Type) {
        let name = String(describing: aClass)
        let kind = UICollectionView.elementKindSectionHeader
        let bundle = Bundle(for: T.self)
        if bundle.path(forResource: name, ofType: "nib") != nil {
            let nib = UINib(nibName: name, bundle: bundle)
            register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: name)
        } else {
            register(aClass, forSupplementaryViewOfKind: kind, withReuseIdentifier: name)
        }
    }

    func register<T: UICollectionReusableView>(footer aClass: T.Type) {
        let name = String(describing: aClass)
        let kind = UICollectionView.elementKindSectionFooter
        let bundle = Bundle(for: T.self)
        if bundle.path(forResource: name, ofType: "nib") != nil {
            let nib = UINib(nibName: name, bundle: bundle)
            register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: name)
        } else {
            register(aClass, forSupplementaryViewOfKind: kind, withReuseIdentifier: name)
        }
    }

    func dequeue<T: UICollectionViewCell>(_ aClass: T.Type, forIndexPath indexPath: IndexPath) -> T {
        let name = String(describing: aClass)
        guard let cell = dequeueReusableCell(withReuseIdentifier: name, for: indexPath) as? T else {
            fatalError("\(name) is not registed")
        }
        return cell
    }

    func dequeue<T: UICollectionReusableView>(header aClass: T.Type, forIndexPath indexPath: IndexPath) -> T {
        let name = String(describing: aClass)
        let kind = UICollectionView.elementKindSectionHeader
        guard let header = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: name, for: indexPath) as? T else {
            fatalError("\(name) is not registed")
        }
        return header
    }

    func dequeue<T: UICollectionReusableView>(footer aClass: T.Type, forIndexPath indexPath: IndexPath) -> T {
        let name = String(describing: aClass)
        let kind = UICollectionView.elementKindSectionFooter
        guard let footer = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: name, for: indexPath) as? T else {
            fatalError("\(name) is not registed")
        }
        return footer
    }
}

