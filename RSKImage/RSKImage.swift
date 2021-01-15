//
// RSKImage.swift
//
// Copyright (c) 2021 R.SK Lab Ltd. All Rights Reserved.
//
// Licensed under the RPL-1.5 and R.SK Lab Professional licenses
// (the "Licenses"); you may not use this work except in compliance
// with the Licenses. You may obtain a copy of the Licenses in
// the LICENSE_RPL and LICENSE_RSK_LAB_PROFESSIONAL files.
//
// Unless required by applicable law or agreed to in writing,
// software distributed under the Licenses is distributed on
// an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
// either express or implied.
//

import CoreGraphics
import UIKit

/// The type of object that represents an image.
open class RSKImage: UIImage, RSKImageProtocol {
    
    // MARK: - Open Properties
    
    open private(set) var cgPath: CGPath?
    
    // MARK: - Public Initializers
    
    public required convenience init(cgImage: CGImage, cgPath: CGPath, scale: CGFloat, orientation: UIImage.Orientation) {
        
        self.init(cgImage: cgImage, scale: scale, orientation: orientation)
        
        self.cgPath = cgPath
    }
}
