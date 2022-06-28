//
//  GameNumberIndicator.swift
//  Casino Games App
//
//  Created by Łukasz Czechowicz on 23/06/2022.
//

import Foundation
import UIKit

final class GameNumberIndicator: UILabel {
    private static let margin:CGFloat = 5.0
    override init(frame: CGRect) {
        super.init(frame: frame)
        isHidden = true
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        
        font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        textColor = .white
        textAlignment = .center
        backgroundColor = .blue
        layer.cornerRadius = 5
        clipsToBounds = true
        
    }
    
    var gameNumber: Int = 0 {
        didSet {
            guard gameNumber > 0 else {
                isHidden = true
                return
            }
            
            isHidden = false
            text = "\(gameNumber)"
        }
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: Self.margin, bottom: 0, right: Self.margin)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        get {
            var contentSize = super.intrinsicContentSize
            contentSize.height += 0 + 0
            contentSize.width += Self.margin + Self.margin
            return contentSize
        }
    }
}
