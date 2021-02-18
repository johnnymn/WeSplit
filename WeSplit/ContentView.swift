import SwiftUI

struct ContentView: View {
  // The @State property wrapper
  // allows us to associate state
  // to an immutable view struct.
  @State private var tapCount = 0

  var body: some View {
    // Place a navigation at
    // the top of the screen.
    NavigationView {
      // Forms are scrolling lists
      // of static controls.
      Form {
        Section {
          Text("Hello World!")
        }
      }.navigationBarTitle("Swift")
    }

    // A button that mutates state.
    Button("Tap Count: \(tapCount)") {
      self.tapCount += 1
    }
  }
}

// Here we can customize the preview
// that will be show on Xcode's canvas.
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
