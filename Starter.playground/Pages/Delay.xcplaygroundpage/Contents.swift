import Combine
import SwiftUI
import PlaygroundSupport

let valuesPerSeconds = 1.0
let delayInSeconds = 1.5

// 1 Set source publisher sample subject
let sourcePublisher = PassthroughSubject<Date, Never>()

// 2 This wll delay emitted values on main scheduler
let delayedPublisher = sourcePublisher.delay(for: .seconds(delayInSeconds), scheduler: DispatchQueue.main)

// 3 Create time that delivers one value per seconds. Start with autoConnect
let subscription = Timer
    .publish(every: 1.0 / valuesPerSeconds, on: .main, in: .common)
    .autoconnect()
    .subscribe(sourcePublisher)

// 4 Create timeline view display values emmited by the timer
let sourceTimeline = TimelineView(title: "Emitted values (\(valuesPerSeconds) per sec.):")

// 5 Create another timeline viewto diplay delayed values
let delayedTimeline = TimelineView(title: "Delayed values (with a \(delayInSeconds)s delay):")

// 6 create simple SwiftUI vertical stackto displayboth timeline
let view = VStack(spacing: 50) {
    sourceTimeline
    delayedTimeline
}


// 7 Set up live view for this playground
PlaygroundPage.current.liveView = UIHostingController(rootView: view.frame(width: 375, height: 600))

sourcePublisher.displayEvents(in: sourceTimeline)
delayedPublisher.displayEvents(in: delayedTimeline)
//: [Next](@next)
/*:
 Copyright (c) 2020 Razeware LLC

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 distribute, sublicense, create a derivative work, and/or sell copies of the
 Software in any work that is designed, intended, or marketed for pedagogical or
 instructional purposes related to programming, coding, application development,
 or information technology.  Permission for such use, copying, modification,
 merger, publication, distribution, sublicensing, creation of derivative works,
 or sale is expressly withheld.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */

