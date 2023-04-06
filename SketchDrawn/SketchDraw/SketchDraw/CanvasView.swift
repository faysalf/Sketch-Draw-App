//
//  CanvasView.swift
//  SketchDraw
//
//  Created by Md. Faysal Ahmed on 28/12/22.
//

import UIKit

struct TouchPointsAndColor {
    var color: UIColor?
    var width: CGFloat?
    var opacity: CGFloat?
    var points: [CGPoint]?
    
    init(color: UIColor, points: [CGPoint]?) {
        self.color = color
        self.points = points
    }
}


class CanvasView: UIView {
    
    var lines = [TouchPointsAndColor]()
    var strokeWidth: CGFloat = 1.0
    var strokeColor: UIColor = .black
    var strokeOpacity: CGFloat = 1.0
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        
        lines.forEach { (line) in
            for (i, p) in (line.points?.enumerated())! {
                if i == 0 {
                    context.move(to: p)     // when starts writing
                } else {
                    context.addLine(to: p)  // when moving for writing
                }
                context.setStrokeColor(line.color?.withAlphaComponent(line.opacity ?? 1.0).cgColor ?? UIColor.black.cgColor)
                context.setLineWidth(line.width ?? 1.0)
            }
            context.setLineCap(.round)
            context.strokePath()        // all the path user have moved
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(TouchPointsAndColor(color: UIColor(), points: [CGPoint]()))
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first?.location(in: nil) else {
            return
        }
        
        guard var lastPoint = lines.popLast() else {return}
        lastPoint.points?.append(touch)
        lastPoint.color = strokeColor
        lastPoint.width = strokeWidth
        lastPoint.opacity = strokeOpacity
        lines.append(lastPoint)
        setNeedsDisplay()               //  draw method will call
    }
    
    
    func clearCanvasValue() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    func undoCanvasValue() {
        if lines.count > 0 {
            lines.removeLast()
            setNeedsDisplay()
        }
    }
    
    func saveImageToGallery() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        // Drawing on view hierarchy (anukromik) in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if (image != nil) {
            return image!
        }
        return UIImage()
    }
}
