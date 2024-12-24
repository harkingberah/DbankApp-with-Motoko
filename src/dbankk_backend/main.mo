import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DBank {
  stable var currentValue : Float = 300.0; // Initial value as Float
  stable var startTime = Time.now(); // Store the time when the canister starts
  // currentValue := 300.0;
  // startTime := Time.now();
  // Add money to the current value
  public func topUp(amount : Float) {
    currentValue += amount;
    Debug.print(debug_show (currentValue));
  };

  // Withdraw money from the current value
  public func withdraw(amount : Float) {
    if (currentValue >= amount) {
      currentValue -= amount;
      Debug.print(debug_show (currentValue));
    } else {
      Debug.print("Amount too large, insufficient funds.");
    };
  };

  // Query the current balance
  public query func checkBalance() : async Float {
    return currentValue;
  };

  // Calculate compound interest
  public func compound() {
    let currentTime = Time.now(); // Get the current time
    let timeElapsedNs = currentTime - startTime; // Calculate elapsed time in nanoseconds
    let timeElapsedS = timeElapsedNs / 1_000_000_000; // Convert to seconds

    // Update the currentValue with compound interest formula
    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedS));

    // Reset startTime to the current time
    startTime := currentTime;

    Debug.print(debug_show (currentValue));
  };
};
