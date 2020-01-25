//
//  TimeCountdown.swift
//  quiz-app
//
//  Created by Bruno Rocha on 25/01/20.
//  Copyright © 2020 Bruno Rocha. All rights reserved.
//

import Foundation

class TimeCountdown {
    enum State {
        case initial
        case running
        case paused
        case ended
    }

    var durationInSeconds: TimeInterval
    var currentTime: TimeInterval
    var timerDidUpdate: ((_ currentTime: TimeInterval) -> Void)?
    var timerDidEnd: (() -> Void)?

    private var state: State {
        didSet {
            switch state {
            case .paused, .ended:
                timer?.invalidate()

            case .initial:
                currentTime = durationInSeconds

            case .running:
                timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: self.timerDidUpdateBlock)
            }
        }
    }

    private var timer: Timer?

    init(durationInSeconds: TimeInterval) {
        self.durationInSeconds = durationInSeconds
        currentTime = durationInSeconds
        state = .initial
    }

    func start () {
        if (state == .initial) {
            state = .running
        }
    }

    func pause () {
        if (state == .running) {
            state = .paused
        }
    }

    func resume () {
        start()
    }

    func reset () {
        state = .initial
    }
    
    private func timerDidUpdateBlock(_ timer: Timer) {
        if (state == .running) {
            currentTime -= 1
            timerDidUpdate?(currentTime)

            if (currentTime == 0) {
                state = .ended
                timerDidEnd?()
            }
        }
    }
}
