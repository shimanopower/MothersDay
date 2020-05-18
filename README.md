# MothersDay
## A simple Mother's Day app/card that embeds a particle emitter into SwiftUI

From Core Animation we get CALayer which is responsible for rendering visual content and animations in UIViews. The particle emitter comes curtesy of two subclasses of CALayer: CAEmitterLayer and CAEmitterCell. For creating our confetti, CAEmitterLayer provides properties that define the confetti storm and CAEmitterCell provides properties that defnite the individual pieces of confetti. 

For the actual properties of CAEmitterLayer and CAEmitterCell I kindly borrowed Paul Hudson's values which can be found here: https://www.hackingwithswift.com/example-code/calayer/how-to-emit-particles-using-caemitterlayer

However, while UIViews are simply wrappers around CALayers, SwiftUI uses lower level classes to render its content to the screen. Since we have no access to CALayer directly in SwiftUI, we need to add our CALayers to a UIView and then use UIRepresentable protocol to wrap our UIView so that we can create an instance of a UIView object in our SwiftUI view. 

So here is our ConfettiView created as a struct conforming to UIViewRepresentable. To conform to the protocol we must implement this method: makeUIView(context: Context) -> UIView. SwiftUi will automatically call this method to create the view object. But this method is only called once so updating this view done through this method: updateUIView(_ uiView: UIView, context: Context.

  `struct ConfettiView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        // More code
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // We won't be updating so this method will go unused
    }
  }`
  
To create our particle emitter we create an instance of CAEmitterLayer():

  let particleEmitter = CAEmitterLayer()

To create the indvidual piece of confetti we are going to call a seperate method that takes a parameter of UIColor and returns a CAEmitterCell:

  func makeEmitterCell(color: UIColor) -> CAEmitterCell {
          let cell = CAEmitterCell()
          // More Code
          return cell
      }
      
Then we call that method to create our red, green, and blue confetti:

  let red = self.makeEmitterCell(color: UIColor.red)
  let green = self.makeEmitterCell(color: UIColor.green)
  let blue = self.makeEmitterCell(color: UIColor.blue)
  
Then we instantiate an instance of our view:

  let view = UIView()
  
Then we add our CAEmitterLayer() by accessing UIView's layer property:

  view.layer.addSublayer(particleEmitter)
  
Then we simply return the view:

  return view

The complete ConffetiView looks like this: 
  
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



[![Video](http://img.youtube.com/vi/R9CEKy4DSoM/0.jpg)](https://youtu.be/R9CEKy4DSoM "Video")
