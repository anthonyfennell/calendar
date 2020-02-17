# Calendar
A calendar view to allow selection of a date.
```swift
let today = Date()
let minimumDate = today.dateAdding(days: -1)
let todayBackgroundColor = UIColor(white: 0.8, alpha: 0.7)
let colors = CalendarCellColor(text: .black, background: .white, selectedText: .white,
                               selectedBackground: .orange, todayBackground: todayBackgroundColor,
                               disabledText: .lightGray)
let view = CalendarViewFactory.makeCalendarView(with: today, selectedDate: today,
                                                minimumDate: minimumDate, colors: colors,
                                                delegate: self)
```

<img src="https://github.com/anthonyfennell/calendar/blob/master/calendar.png" width=400>
