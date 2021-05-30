//
//  ConstraintApplier.swift
//  FBS10_BEATINFO_Fitness_iPadOS
//
//  Created by Eric on 2021/1/12.
//

import UIKit

extension UIView {
    final class ConstraintApplier { 
        enum Relation {
            case equal
            case lessOrEqual
            case greaterOrEqual
        }
        
        let target: UIView
        var constraints: [NSLayoutConstraint] = []
        
        init(_ target: UIView) { self.target = target }
        
        func apply() {
            target.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate(constraints)
        }
        
        func top(_ relation: Relation = .equal,
                 to anchor: NSLayoutYAxisAnchor,
                 _ constant: CGFloat = 0) -> Self {
            append(target.top, relation, to: anchor, constant)
        }
        
        func bottom(_ relation: Relation = .equal,
                    to anchor: NSLayoutYAxisAnchor,
                    _ constant: CGFloat = 0) -> Self {
            append(target.bottom, relation, to: anchor, constant)
        }
        
        func verticallyAligned<T: AnchorUsing>(with target: T) -> Self {
            top(to: target.top)
                .bottom(to: target.bottom)
        }
        
        func leading(_ relation: Relation = .equal,
                     to anchor: NSLayoutXAxisAnchor,
                     _ constant: CGFloat = 0) -> Self {
            append(target.leading, relation, to: anchor, constant)
        }
        
        func trailing(_ relation: Relation = .equal,
                      to anchor: NSLayoutXAxisAnchor,
                      _ constant: CGFloat = 0) -> Self {
            append(target.trailing, relation, to: anchor, constant)
        }
        
        func horizontallyAligned<T: AnchorUsing>(with target: T) -> Self {
            leading(to: target.leading)
                .trailing(to: target.trailing)
        }
        
        func centerX(_ relation: Relation = .equal,
                     to anchor: NSLayoutXAxisAnchor,
                     _ constant: CGFloat = 0) -> Self {
            append(target.centerX, relation, to: anchor, constant)
        }
        
        func centerY(_ relation: Relation = .equal,
                     to anchor: NSLayoutYAxisAnchor,
                     _ constant: CGFloat = 0) -> Self {
            append(target.centerY, relation, to: anchor, constant)
        }
        
        private func append<AnchorType>(_ anchor: NSLayoutAnchor<AnchorType>,
                                        _ relation: Relation = .equal,
                                        to toAnchor: NSLayoutAnchor<AnchorType>,
                                        _ constant: CGFloat) -> Self {
            let constraint: NSLayoutConstraint
            switch relation {
            case .equal: constraint = anchor.to(toAnchor, constant)
            case .lessOrEqual: constraint = anchor.lessOrEqual(toAnchor, constant)
            case .greaterOrEqual: constraint = anchor.greaterOrEqual(toAnchor, constant)
            }
            constraints.append(constraint)
            return self
        }
        
        func width(_ relation: Relation = .equal,
                   to constant: CGFloat) -> Self {
            append(target.width, relation, to: constant)
        }
        
        func width(_ relation: Relation = .equal,
                   to dimension: NSLayoutDimension,
                   multiplier: CGFloat = 1) -> Self {
            append(target.width, relation, to: dimension, multiplier: multiplier)
        }
        
        func height(_ relation: Relation = .equal,
                    to constant: CGFloat) -> Self {
            append(target.height, relation, to: constant)
        }
        
        func height(_ relation: Relation = .equal,
                    to dimension: NSLayoutDimension,
                    multiplier: CGFloat = 1) -> Self {
            append(target.height, relation, to: dimension, multiplier: multiplier)
        }
        
        private func append(_ dimension: NSLayoutDimension,
                            _ relation: Relation = .equal,
                            to constant: CGFloat) -> Self {
            let constraint: NSLayoutConstraint
            switch relation {
            case .equal: constraint = dimension.to(constant)
            case .lessOrEqual: constraint = dimension.lessOrEqual(constant)
            case .greaterOrEqual: constraint = dimension.greaterOrEqual(constant)
            }
            constraints.append(constraint)
            return self
        }
        
        private func append(_ dimension: NSLayoutDimension,
                            _ relation: Relation = .equal,
                            to toDimension: NSLayoutDimension,
                            multiplier: CGFloat) -> Self {
            let constraint: NSLayoutConstraint
            switch relation {
            case .equal: constraint = dimension.to(toDimension, multiplier: multiplier)
            case .lessOrEqual: constraint = dimension.lessOrEqual(toDimension, multiplier: multiplier)
            case .greaterOrEqual: constraint = dimension.greaterOrEqual(toDimension, multiplier: multiplier)
            }
            constraints.append(constraint)
            return self
        }
    }
}

extension UIView {
    func addSubviews(_ constraintsAppliers: ConstraintApplier...) {
        constraintsAppliers.forEach {
            addSubview($0.target)
            $0.apply()
        }
    }
    
    func top(_ relation: ConstraintApplier.Relation = .equal,
             to anchor: NSLayoutYAxisAnchor,
             _ constant: CGFloat = 0) -> ConstraintApplier {
        ConstraintApplier(self).top(relation, to: anchor, constant)
    }
    
    func bottom(_ relation: ConstraintApplier.Relation = .equal,
                to anchor: NSLayoutYAxisAnchor,
                _ constant: CGFloat = 0) -> ConstraintApplier {
        ConstraintApplier(self).bottom(relation, to: anchor, constant)
    }
    
    func leading(_ relation: ConstraintApplier.Relation = .equal,
                 to anchor: NSLayoutXAxisAnchor,
                 _ constant: CGFloat = 0) -> ConstraintApplier {
        ConstraintApplier(self).leading(relation, to: anchor, constant)
    }
    
    func trailing(_ relation: ConstraintApplier.Relation = .equal,
                  to anchor: NSLayoutXAxisAnchor,
                  _ constant: CGFloat = 0) -> ConstraintApplier {
        ConstraintApplier(self).trailing(relation, to: anchor, constant)
    }
    
    func centerX(_ relation: ConstraintApplier.Relation = .equal,
                 to anchor: NSLayoutXAxisAnchor,
                 _ constant: CGFloat = 0) -> ConstraintApplier {
        ConstraintApplier(self).centerX(relation, to: anchor, constant)
    }
    
    func centerY(_ relation: ConstraintApplier.Relation = .equal,
                 to anchor: NSLayoutYAxisAnchor,
                 _ constant: CGFloat = 0) -> ConstraintApplier {
        ConstraintApplier(self).centerY(relation, to: anchor, constant)
    }
    
    func width(_ relation: ConstraintApplier.Relation = .equal,
               to constant: CGFloat) -> ConstraintApplier {
        ConstraintApplier(self).width(relation, to: constant)
    }
    
    func width(_ relation: ConstraintApplier.Relation = .equal,
               to dimension: NSLayoutDimension,
               multiplier: CGFloat = 1) -> ConstraintApplier {
        ConstraintApplier(self).width(relation, to: dimension, multiplier: multiplier)
    }
    
    func height(_ relation: ConstraintApplier.Relation = .equal,
                to constant: CGFloat) -> ConstraintApplier {
        ConstraintApplier(self).height(relation, to: constant)
    }
    
    func height(_ relation: ConstraintApplier.Relation = .equal,
                to dimension: NSLayoutDimension,
                multiplier: CGFloat = 1) -> ConstraintApplier {
        ConstraintApplier(self).height(relation, to: dimension, multiplier: multiplier)
    }
}

protocol AnchorUsing {
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
    
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    
    var centerXAnchor: NSLayoutXAxisAnchor { get }
    var centerYAnchor: NSLayoutYAxisAnchor { get }
    
    var widthAnchor: NSLayoutDimension { get }
    var heightAnchor: NSLayoutDimension { get }
}

extension UIView: AnchorUsing {}
extension UILayoutGuide: AnchorUsing {}

extension AnchorUsing {
    var top: NSLayoutYAxisAnchor { topAnchor }
    var bottom: NSLayoutYAxisAnchor { bottomAnchor }
    
    var leading: NSLayoutXAxisAnchor { leadingAnchor }
    var trailing: NSLayoutXAxisAnchor { trailingAnchor }
    
    var centerX: NSLayoutXAxisAnchor { centerXAnchor }
    var centerY: NSLayoutYAxisAnchor { centerYAnchor }
    
    var width: NSLayoutDimension { widthAnchor }
    var height: NSLayoutDimension { heightAnchor }
}

extension NSLayoutAnchor {
    @objc func to(_ anchor: NSLayoutAnchor<AnchorType>, _ constant: CGFloat = 0) -> NSLayoutConstraint {
        constraint(equalTo: anchor, constant: constant)
    }
    
    @objc func lessOrEqual(_ anchor: NSLayoutAnchor<AnchorType>, _ constant: CGFloat = 0) -> NSLayoutConstraint {
        constraint(lessThanOrEqualTo: anchor, constant: constant)
    }
    
    @objc func greaterOrEqual(_ anchor: NSLayoutAnchor<AnchorType>, _ constant: CGFloat = 0) -> NSLayoutConstraint {
        constraint(greaterThanOrEqualTo: anchor, constant: constant)
    }
}

extension NSLayoutDimension {
    func to(_ constant: CGFloat) -> NSLayoutConstraint {
        constraint(equalToConstant: constant)
    }
    
    func lessOrEqual(_ constant: CGFloat) -> NSLayoutConstraint {
        constraint(lessThanOrEqualToConstant: constant)
    }
    
    func greaterOrEqual(_ constant: CGFloat) -> NSLayoutConstraint {
        constraint(greaterThanOrEqualToConstant: constant)
    }
    
    func to(_ dimension: NSLayoutDimension, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        constraint(equalTo: dimension, multiplier: multiplier)
    }
    
    func lessOrEqual(_ dimension: NSLayoutDimension, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        constraint(lessThanOrEqualTo: dimension, multiplier: multiplier)
    }
    
    func greaterOrEqual(_ dimension: NSLayoutDimension, multiplier: CGFloat = 1) -> NSLayoutConstraint {
        constraint(greaterThanOrEqualTo: dimension, multiplier: multiplier)
    }
}
