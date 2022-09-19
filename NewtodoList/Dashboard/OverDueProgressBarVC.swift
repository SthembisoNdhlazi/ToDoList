//
//  OverDueProgressBarVC.swift
//  NewtodoList
//
//  Created by Bronwyn dos Santos on 2022/09/13.
//

import Foundation
import UIKit

class OverDueProgressBarVC: UIView{

var dashboardClass = dashboardVC()

@IBInspectable public  var startGradientColor: UIColor = UIColor.green
@IBInspectable public  var endGradientColor: UIColor = UIColor.systemTeal
@IBInspectable public  var textColor: UIColor = UIColor.black
@IBInspectable public  var backgroundCircleColor: UIColor = UIColor.lightGray


var backgroundLayer : CAShapeLayer!
var foregroundLayer : CAShapeLayer!
var textLayer : CATextLayer!
var gradientLayer: CAGradientLayer!

var doneprogress : CGFloat = 0.1
var overdueprogress : CGFloat = 0.1






override func draw(_ rect: CGRect) {
   
   prepareView()
   
}


func prepareView(){
   
   guard layer.sublayers == nil else{return} // stops it from duplicating layers
   let width = bounds.width
   let height = bounds.height
   
   let lineWidth = 0.1 * min(width, height)
   
   foregroundLayer = createCircularLayer(rect: bounds, strokeColor: UIColor.green.cgColor , fillColor: UIColor.clear.cgColor, lineWidth: lineWidth)
   
   backgroundLayer = createCircularLayer(rect: bounds, strokeColor: backgroundCircleColor.cgColor, fillColor: UIColor.clear.cgColor, lineWidth: lineWidth)
   
  gradientLayer = CAGradientLayer()
   gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
   gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
   gradientLayer.colors = [startGradientColor.cgColor, endGradientColor.cgColor]
   gradientLayer.frame = bounds
   gradientLayer.mask = foregroundLayer
   
   textLayer = createATextLayer(rect: bounds, textColor: textColor.cgColor)

  
   layer.addSublayer(backgroundLayer)
   layer.addSublayer(gradientLayer)
   layer.addSublayer(textLayer)
   
}
    

func overdueUpdateProgress(){
   let overdueTextValue = (dashboardClass.overduevalue/dashboardClass.overduetotal) * 100
    
   let overdueFormattedText = String(format: "%.0f", overdueTextValue)
    
   textLayer?.string = "\(overdueFormattedText)%"
    
   textLayer?.fontSize = 26
    
   foregroundLayer?.strokeEnd = overdueTextValue
   print("hello")
}



    



private func createCircularLayer(rect: CGRect,strokeColor: CGColor, fillColor: CGColor, lineWidth: CGFloat) -> CAShapeLayer{
   
   //drawing code
   let width = rect.width
   let height = rect.height
   
   let center = CGPoint(x: width / 2, y: height / 2)
   let radius = (min(width, height) - lineWidth) / 2
   
   let startAngle = -CGFloat.pi / 2
   let endAngle = startAngle + 2 * CGFloat.pi
   
   let circularPath = UIBezierPath(arcCenter: center, radius: radius
                                   , startAngle: startAngle, endAngle: endAngle, clockwise: true)
   
  let shapeLayer = CAShapeLayer()
   
   shapeLayer.path = circularPath.cgPath
   
   shapeLayer.strokeColor = strokeColor
   shapeLayer.fillColor = fillColor
   shapeLayer.lineWidth = lineWidth
   shapeLayer.lineCap = .round
   
   return shapeLayer
}

private func createATextLayer(rect: CGRect, textColor: CGColor) -> CATextLayer{
   let width = rect.width
   let height = rect.height
   
   let fontSize = min(width, height) / 4
   let offset = min(width, height) * 0.1
   
   let layer = CATextLayer()
   layer.string = "0"
   
   layer.backgroundColor = UIColor.clear.cgColor
   layer.foregroundColor = textColor
   layer.fontSize = fontSize
   layer.frame = CGRect(x: 0, y: (height - fontSize - offset) / 2, width: width, height: fontSize + offset)
   layer.alignmentMode = .center
   
   return layer
   
 
}

}
