//
//  WDEventsTests.swift
//  WorldDevEventTests
//
//  Created by Bogdan Sasko on 6/2/19.
//  Copyright © 2019 vinso. All rights reserved.
//

import XCTest

@testable import WorldDevEvent

class WDEventsTests: XCTestCase {
    let jsonString = """
            [{
            "id": 1,
            "type": "event",
            "title": "Madison Sqaure Garden 2",
            "shortDescription": "11.2.2019",
            "description": "When Google’s CEO Sundar Pichai was growing up in Chennai, south-east India, he had to make regular trips to the hospital to pick up his mother’s blood-test results. It took an hour and 20 minutes by bus, and when he got there he would have to stand and queue for an hour, often to be told the results weren’t ready. It took five years for his family to get their first rotary telephone, when Pichai was 12. It was a landmark moment. “It would take me 10 minutes to call the hospital, and maybe they’d tell me, ‘No, come back tomorrow’,” Pichai says. “We waited a long time to get a refrigerator, too, and I saw how my mom’s life changed: she didn’t need to cook every day, she could spend more time with us. So there is a side of me that has viscerally seen how technology can make a difference, and I still feel it. I feel the optimism and energy, and the moral imperative to accelerate that progress.” Now 45, Pichai is a tall, slight man whose voice is a soft harmony of Indian and American accents. Sitting in his office in a quiet corner of Google’s headquarters, in Mountain View, California, he speaks thoughtfully, often pausing to find the right phrase. The room houses a few pieces of designer furniture, and the requisite treadmill desk – the perfect metaphor for the pace Pichai has to keep up with. Yet his is a disarmingly calm presence, a world away from the prevailing stereotype of the macho-genius tech CEO; when Pichai got the job, one Google employee was quoted as saying: “All the assholes have left.”",
            "smallImage": "http://mama-studio.com/tt/event1.png",
            "bigImage": "http://mama-studio.com/tt/event11.png",
            "latitude": "40.817817",
            "longitude": "74.251631"
            },
            {
            "id": 2,
            "type": "event",
            "title": "Early Winter SHOW",
            "shortDescription": "21.3.2019",
            "description": "When Google’s CEO Sundar Pichai was growing up in Chennai, south-east India, he had to make regular trips to the hospital to pick up his mother’s blood-test results. It took an hour and 20 minutes by bus, and when he got there he would have to stand and queue for an hour, often to be told the results weren’t ready. It took five years for his family to get their first rotary telephone, when Pichai was 12. It was a landmark moment. “It would take me 10 minutes to call the hospital, and maybe they’d tell me, ‘No, come back tomorrow’,” Pichai says. “We waited a long time to get a refrigerator, too, and I saw how my mom’s life changed: she didn’t need to cook every day, she could spend more time with us. So there is a side of me that has viscerally seen how technology can make a difference, and I still feel it. I feel the optimism and energy, and the moral imperative to accelerate that progress.” Now 45, Pichai is a tall, slight man whose voice is a soft harmony of Indian and American accents. Sitting in his office in a quiet corner of Google’s headquarters, in Mountain View, California, he speaks thoughtfully, often pausing to find the right phrase. The room houses a few pieces of designer furniture, and the requisite treadmill desk – the perfect metaphor for the pace Pichai has to keep up with. Yet his is a disarmingly calm presence, a world away from the prevailing stereotype of the macho-genius tech CEO; when Pichai got the job, one Google employee was quoted as saying: “All the assholes have left.”",
            "smallImage": "http://mama-studio.com/tt/event2.png",
            "bigImage": "http://mama-studio.com/tt/event12.png",
            "latitude": "40.934116",
            "longitude": "-74.190519"
            },
            {
            "id": 20,
            "type": "shop",
            "title": "Illinois Spirit",
            "shortDescription": "1681 Orchard Dr, Lenoir, NC, 28645",
            "description": "When Google’s CEO Sundar Pichai was growing up in Chennai, south-east India, he had to make regular trips to the hospital to pick up his mother’s blood-test results. It took an hour and 20 minutes by bus, and when he got there he would have to stand and queue for an hour, often to be told the results weren’t ready. It took five years for his family to get their first rotary telephone, when Pichai was 12. It was a landmark moment. “It would take me 10 minutes to call the hospital, and maybe they’d tell me, ‘No, come back tomorrow’,” Pichai says. “We waited a long time to get a refrigerator, too, and I saw how my mom’s life changed: she didn’t need to cook every day, she could spend more time with us. So there is a side of me that has viscerally seen how technology can make a difference, and I still feel it. I feel the optimism and energy, and the moral imperative to accelerate that progress.” Now 45, Pichai is a tall, slight man whose voice is a soft harmony of Indian and American accents. Sitting in his office in a quiet corner of Google’s headquarters, in Mountain View, California, he speaks thoughtfully, often pausing to find the right phrase. The room houses a few pieces of designer furniture, and the requisite treadmill desk – the perfect metaphor for the pace Pichai has to keep up with. Yet his is a disarmingly calm presence, a world away from the prevailing stereotype of the macho-genius tech CEO; when Pichai got the job, one Google employee was quoted as saying: “All the assholes have left.”",
            "smallImage": "http://mama-studio.com/tt/shop5.png",
            "bigImage": "http://mama-studio.com/tt/event15.png",
            "latitude": "40.817817",
            "longitude": "74.251631"
            }]
            """
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testParseEvents() {
        // given
        guard let jsonAsData = jsonString.data(using: .utf8) else {
            fatalError("json string must be filled")
        }
        
        // when
        let events = WDEvents(from: jsonAsData)
        
        // then
        XCTAssertEqual(events.items.count, 3, "Count events should be equal 3")
    }
    
    func testGetShopEventShouldBeEqualOne() {
        // given
        guard let jsonAsData = jsonString.data(using: .utf8) else {
            fatalError("json string must be filled")
        }
        
        // when
        let events = WDEvents(from: jsonAsData)
        let shopEvents = events.get(by: .shop)
        
        // then
        XCTAssertEqual(shopEvents.count, 1, "Count shop events should be equal 1")
    }
    
    func testGetEventsShouldBeEqualTwo() {
        // given
        guard let jsonAsData = jsonString.data(using: .utf8) else {
            fatalError("json string must be filled")
        }
        
        // when
        let events = WDEvents(from: jsonAsData)
        let filteredEvents = events.get(by: .event)
        
        // then
        XCTAssertEqual(filteredEvents.count, 2, "Count events should be equal 2")
    }
}
