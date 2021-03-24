import SwiftUI

extension View {
  // Dismiss the keyboard.
  func endTextEditing() {
    UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil, from: nil, for: nil
    )
  }
}

struct ContentView: View {
  // The @State property wrapper
  // allows us to associate state
  // to an immutable view struct.
  @State private var checkAmount = ""
  @State private var numberOfPeople = "2"
  @State private var tipPercentage = 2

  let tipPercentages = [0, 10, 15, 20, 25]

  // This is a computed property.
  var totalPerPerson: Double {
    let peopleCount = Double(numberOfPeople) ?? 1
    let tipSelection = Double(tipPercentages[tipPercentage])
    // When we cast a string to a Double
    // the result is a `Double?` so we will
    // set this to 0 if the casting fails.
    let orderAmount = Double(checkAmount) ?? 0
    let tipAmount = (orderAmount * tipSelection) / 100

    return (orderAmount + tipAmount) / peopleCount
  }

  var body: some View {
    // The NavigationView let iOS
    // slide into new views as needed.
    NavigationView {
      Form {
        // Capture the number of people with a text input.
        Section(header: Text("Number of people")) {
          // The UIKeyboardType.decimalPad
          // only allows typing numbers.
          TextField("Number of people", text: $numberOfPeople)
                  .keyboardType(.numberPad)
        }.onTapGesture {
          // Dismiss the keyboard by tapping
          // anywhere on this section.
          self.endTextEditing()
        }

        // Capture the check amount with a text input.
        Section(header: Text("Check amount")) {
          // The UIKeyboardType.decimalPad
          // only allows typing numbers.
          TextField("Amount", text: $checkAmount)
                  .keyboardType(.decimalPad)
        }.onTapGesture {
          self.endTextEditing()
        }

        // Use a picker to get the tip percentage.
        Section(header: Text("How much tip do you want to leave?")) {
          Picker("Tip percentage", selection: $tipPercentage) {
            ForEach(0..<tipPercentages.count) {
              Text("\(tipPercentages[$0])%")
            }
          }.pickerStyle(SegmentedPickerStyle())
        }

        Section(header: Text("Amount per person")) {
          // Format string to only 2 decimals.
          Text("$\(totalPerPerson, specifier: "%.2f")")
        }.onTapGesture {
          self.endTextEditing()
        }
      }.navigationBarTitle("WeSplit")
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
