import SwiftUI

struct ContentView: View {
  // The @State property wrapper
  // allows us to associate state
  // to an immutable view struct.
  @State private var checkAmount = ""
  @State private var numberOfPeople = 2
  @State private var tipPercentage = 2

  let tipPercentages = [0, 10, 15, 20, 25]

  // This is a computed property.
  var totalPerPerson: Double {
    let peopleCount = Double(numberOfPeople + 2)
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
        // Generate a list of numbers to populate
        // the Picker that we use to capture the
        // number of people.
        Picker("Number of people", selection: $numberOfPeople) {
          ForEach(2..<100) {
            Text("\($0)")
          }
        }

        // Capture the check amount with a text input.
        Section {
          // The UIKeyboardType.decimalPad
          // only allows typing numbers.
          TextField("Amount", text: $checkAmount)
                  .keyboardType(.decimalPad)
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
