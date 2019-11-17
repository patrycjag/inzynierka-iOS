//
//  ActivityIndicatorView.swift
//  PracaInzynierska-iOS
//
//  Created by Lukasz Kepka on 16/11/2019.
//  Copyright © 2019 AGH. All rights reserved.
//

import UIKit

class ActivityIndicatorView: UIView {
    
    private lazy var loaderView: UIView = {
        var loadingView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        return loadingView
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndic = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        activityIndic.hidesWhenStopped = true
        activityIndic.style = UIActivityIndicatorView.Style.whiteLarge
        activityIndic.startAnimating()
        return activityIndic
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        activityIndicator.center = loaderView.center
        self.loaderView.addSubview(activityIndicator)
        loaderView.center = self.center
        self.addSubview(loaderView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
