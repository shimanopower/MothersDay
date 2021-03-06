# Mother's Day App
## A simple Mother's Day app/card that embeds a particle emitter into SwiftUI

From Core Animation we get CALayer which is responsible for rendering visual content and animations in UIViews. The particle emitter is derived from two subclasses of CALayer: CAEmitterLayer and CAEmitterCell. For creating our confetti, CAEmitterLayer provides properties that define the confetti storm and CAEmitterCell provides properties that definite the individual pieces of confetti. 

Although, UIViews are simply wrappers around CALayers, SwiftUI doesn't provide a way to use CALayers directly. So we need to wrap our CALayer in a UIView and then use UIViewRepresentable protocol to wrap our UIView. Then we can create an instance of a UIView object capable of using a CALayer in our SwiftUI view. 

So here is our ConfettiView created as a struct conforming to UIViewRepresentable:

    struct ConfettiView: UIViewRepresentable {
        func makeUIView(context: Context) -> UIView {
            // More code
        }

        func updateUIView(_ uiView: UIView, context: Context) {
            // We won't be updating so this method will go unused
        }
    }
    
Conforming to UIViewRepresentable requires us to implement the makeUIView method. SwiftUI will automatically call this method to create the view object. But this method is only called once. So updating this view is done through the updateView method.
  
To create our particle emitter we create an instance of CAEmitterLayer:

    let particleEmitter = CAEmitterLayer()

To create the individual piece of confetti we are going to call a separate method that takes a parameter of UIColor and returns a CAEmitterCell:

    func makeEmitterCell(color: UIColor) -> CAEmitterCell {
        let cell = CAEmitterCell()
        // More Code
        return cell
    }
      
Then we call that method to create our red, green, and blue confetti:

    let red = self.makeEmitterCell(color: UIColor.red)
    let green = self.makeEmitterCell(color: UIColor.green)
    let blue = self.makeEmitterCell(color: UIColor.blue)
  
Then we add our CAEmitterLayer by accessing UIView's layer property:

    let view = UIView()
    view.layer.addSublayer(particleEmitter)
  
Then we simply return the view:

    return view
    
For the actual properties of CAEmitterLayer and CAEmitterCell I used Paul Hudson's values which can be found here: https://www.hackingwithswift.com/example-code/calayer/how-to-emit-particles-using-caemitterlayer 

But play around with the properties yourself as particle emitters are a lot of fun. :) 

The complete ConfettiView looks like this: 
  
    struct ConfettiView: UIViewRepresentable {
        func makeUIView(context: Context) -> UIView {
            let particleEmitter = CAEmitterLayer()
            let view = UIView()

            particleEmitter.emitterPosition = CGPoint(x: view.center.x, y: -96)
            particleEmitter.emitterShape = .line
            particleEmitter.emitterSize = CGSize(width: view.frame.size.width, height: 1)

            let red = self.makeEmitterCell(color: UIColor.red)
            let green = self.makeEmitterCell(color: UIColor.green)
            let blue = self.makeEmitterCell(color: UIColor.blue)

            particleEmitter.emitterCells = [red, green, blue]

            view.layer.addSublayer(particleEmitter)

            return view
        }
    
        func makeEmitterCell(color: UIColor) -> CAEmitterCell {
            let cell = CAEmitterCell()
            cell.birthRate = 3
            cell.lifetime = 7.0
            cell.lifetimeRange = 0
            cell.color = color.cgColor
            cell.velocity = 200
            cell.velocityRange = 50
            cell.emissionLongitude = CGFloat.pi
            cell.emissionRange = CGFloat.pi / 4
            cell.spin = 2
            cell.spinRange = 3
            cell.scaleRange = 0.5
            cell.scaleSpeed = -0.05
            cell.contents = UIImage(named: "polygon")?.cgImage

            return cell
        }

        func updateUIView(_ uiView: UIView, context: Context) {
        }
    }
  
Then the only thing left is simply to create an instance of ConfettiView in our SwiftUI view:

    struct AnimalHouseChildView: View {
        var child: AnimalHouseChild
    
        var body: some View {
            ZStack {
                VStack {
                    Spacer()
                    Text("Happy Mother's Day!")
                        .font(.largeTitle)
                    Spacer()
                    child.image?
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Spacer()
                    Text(child.mothersDayMessage)
                        .font(.title)
                    Spacer()
                }
                ConfettiView()
            }
        }
    }
 
Final Result can be seen here:

[![Video](http://img.youtube.com/vi/R9CEKy4DSoM/0.jpg)](https://youtu.be/R9CEKy4DSoM "Video")
