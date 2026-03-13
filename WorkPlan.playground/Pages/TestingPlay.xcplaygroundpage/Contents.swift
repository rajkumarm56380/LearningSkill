import Foundation
import Combine

protocol playCarprotocol {
    func MusicPlay()
}

extension playCarprotocol{
    func MusicPlay(){
        print("MusicPlay protocol method called")
    }
}

struct carMusic: playCarprotocol{
    func MusicPlay() {
        print("carMusic Class method called")
    }
}

let mcare = carMusic() // carMusic Class method called
let mare: playCarprotocol = carMusic() // MusicPlay protocol method called
mcare.MusicPlay()
mare.MusicPlay()

print("Current thread is main thread")
DispatchQueue.main.sync {
    // This block will never execute because the main thread is blocked waiting for it.
    print("This line will not be reached")
}
print("This line will also not be reached")
// The app will crash with a message like: "BUG IN CLIENT OF LIBDISPATCH: dispatch_sync called on queue already owned by current thread"

print("Current thread is main thread (A)")

DispatchQueue.global().async {
    DispatchQueue.main.async {
    // This block runs later on the main thread without blocking A.
        print("This runs later on the main thread (C)")
    }
}

print("This runs immediately after scheduling the async task (B)")

// Possible output:
// Current thread is main thread (A)
// This runs immediately after scheduling the async task (B)
// This runs later on the main thread (C)
