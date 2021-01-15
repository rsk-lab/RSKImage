//
// RSKImageProtocol.swift
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
import RSKBezierPath
import UIKit

/// The protocol to be adopted by a type of object that represents an image.
public protocol RSKImageProtocol {
    
    // MARK: - Public Properties
    
    /// The underlying Quartz image data.
    var cgImage: CGImage? { get }
    
    /// The path that consists of straight and curved line segments that represent the shape of the image.
    var cgPath: CGPath? { get }
    
    // MARK: - Public Initializers
    
    ///
    /// Initializes and returns a new `RSKImage` object with the specified `cgImage`, `cgPath`, `scale` and `orientation`.
    ///
    /// - Parameters:
    ///     - cgImage: The underlying Quartz image data.
    ///     - cgPath: The path that consists of straight and curved line segments that represent the shape of the image.
    ///     - scale: The scale factor to assume when interpreting the image data.
    ///     - orientation: The orientation of the image data.
    ///
    init(cgImage: CGImage, cgPath: CGPath, scale: CGFloat, orientation: UIImage.Orientation)
    
    ///
    /// Initializes and returns a new `RSKImage` object with a `cgImage` and `cgPath`that are created from the specified `color`, `size`, `cornerRadii`, `borderColor`, `borderWidth`, `opaque` and `scale`.
    ///
    /// - Parameters:
    ///     - color: The color used to create the image.
    ///     - size: The size of the image to create.
    ///     - cornerRadii: A dictionary with bitmask values that identifies the corners that you want rounded as keys and radii of each corner oval as values.
    ///     - borderColor: The color of the image's border.
    ///     - borderWidth: The width of the image's border, inset from the image bounds.
    ///     - opaque: A Boolean flag indicating whether the image is opaque.
    ///     - scale: The scale factor to apply to the bitmap. If you specify a `nil` value, the scale factor is set to the scale factor of the device’s main screen.
    ///
    init(color: CGColor, size: CGSize, cornerRadii: [UIRectCorner: CGFloat], borderColor: CGColor?, borderWidth: CGFloat, opaque: Bool, scale: CGFloat?)
    
    ///
    /// Initializes and returns a new `RSKImage` object with a `cgImage` and `cgPath` that are created from the specified `linearGradient`, `linearGradientStartPoint`, `linearGradientEndPoint`, `linearGradientOptions`, `size`, `cornerRadii`, `borderColor`, `borderWidth`, `opaque` and `scale`.
    ///
    /// - Parameters:
    ///     - linearGradient: The linear gradient used to create the image.
    ///     - linearGradientStartPoint: The coordinate that defines the starting point of the linear gradient.
    ///     - linearGradientEndPoint: The coordinate that defines the ending point of the linear gradient.
    ///     - linearGradientOptions: Option flags (`drawsBeforeStartLocation` or `drawsAfterEndLocation`) that control whether the fill is extended beyond the starting or ending point.
    ///     - size: The size of the image to create.
    ///     - cornerRadii: A dictionary with bitmask values that identifies the corners that you want rounded as keys and radii of each corner oval as values.
    ///     - borderColor: The color of the image's border.
    ///     - borderWidth: The width of the image's border, inset from the image bounds.
    ///     - opaque: A Boolean flag indicating whether the image is opaque.
    ///     - scale: The scale factor to apply to the bitmap. If you specify a `nil` value, the scale factor is set to the scale factor of the device’s main screen.
    ///
    init(linearGradient: CGGradient, linearGradientStartPoint: CGPoint, linearGradientEndPoint: CGPoint, linearGradientOptions: CGGradientDrawingOptions, size: CGSize, cornerRadii: [UIRectCorner: CGFloat], borderColor: CGColor?, borderWidth: CGFloat, opaque: Bool, scale: CGFloat?)
}

public extension RSKImageProtocol {
    
    // MARK: - Public Initializers
    
    init(color: CGColor, size: CGSize, cornerRadii: [UIRectCorner: CGFloat], borderColor: CGColor?, borderWidth: CGFloat, opaque: Bool, scale: CGFloat?) {
        
        let bounds = CGRect(origin: .zero, size: size)
        let scale = scale ?? UIScreen.main.scale
        
        let format = UIGraphicsImageRendererFormat()
        format.opaque = opaque
        format.scale = scale
        
        let graphicsImageRenderer = UIGraphicsImageRenderer(bounds: bounds, format: format)
        
        var cgPath: CGPath!
        let uiImage = graphicsImageRenderer.image { (context) in
            
            cgPath = RSKBezierPath(rect: bounds, cornerRadii: cornerRadii).cgPath
            
            context.cgContext.addPath(cgPath)
            context.cgContext.setFillColor(color)
            context.cgContext.fillPath()
            
            if let borderColor = borderColor,
               borderWidth > 0.0 {
                
                let inset = borderWidth / 2.0
                let bounds = bounds.insetBy(dx: inset, dy: inset)
                let cornerRadii = cornerRadii.mapValues { (cornerRadius) -> CGFloat in
                    
                    max(cornerRadius - inset, 0.0)
                }
                
                let cgPath = RSKBezierPath(rect: bounds, cornerRadii: cornerRadii).cgPath
                
                context.cgContext.setLineWidth(borderWidth)
                context.cgContext.setStrokeColor(borderColor)
                context.cgContext.addPath(cgPath)
                context.cgContext.strokePath()
            }
        }
        
        self.init(cgImage: uiImage.cgImage!, cgPath: cgPath, scale: scale, orientation: .up)
    }
    
    init(linearGradient: CGGradient, linearGradientStartPoint: CGPoint, linearGradientEndPoint: CGPoint, linearGradientOptions: CGGradientDrawingOptions, size: CGSize, cornerRadii: [UIRectCorner: CGFloat], borderColor: CGColor?, borderWidth: CGFloat, opaque: Bool, scale: CGFloat?) {
        
        let bounds = CGRect(origin: .zero, size: size)
        let scale = scale ?? UIScreen.main.scale
        
        let format = UIGraphicsImageRendererFormat()
        format.opaque = opaque
        format.scale = scale
        
        let graphicsImageRenderer = UIGraphicsImageRenderer(bounds: bounds, format: format)
        
        var cgPath: CGPath!
        let uiImage = graphicsImageRenderer.image { (context) in
            
            cgPath = RSKBezierPath(rect: bounds, cornerRadii: cornerRadii).cgPath
            
            context.cgContext.addPath(cgPath)
            context.cgContext.clip()
            context.cgContext.drawLinearGradient(linearGradient, start: linearGradientStartPoint, end: linearGradientEndPoint, options: linearGradientOptions)
            
            if let borderColor = borderColor,
               borderWidth > 0.0 {
                
                let inset = borderWidth / 2.0
                let bounds = bounds.insetBy(dx: inset, dy: inset)
                let cornerRadii = cornerRadii.mapValues { (cornerRadius) -> CGFloat in
                    
                    max(cornerRadius - inset, 0.0)
                }
                
                let cgPath = RSKBezierPath(rect: bounds, cornerRadii: cornerRadii).cgPath
                
                context.cgContext.setLineWidth(borderWidth)
                context.cgContext.setStrokeColor(borderColor)
                context.cgContext.addPath(cgPath)
                context.cgContext.strokePath()
            }
        }
        
        self.init(cgImage: uiImage.cgImage!, cgPath: cgPath, scale: scale, orientation: .up)
    }
}
