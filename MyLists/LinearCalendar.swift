//
//  LinearCalendar.swift
//  MyLists
//
//  Created by Hyunwoo Shin on 7/23/24.
//

import SwiftUI

struct LinearCalendar: View {
    @Binding var selectedDate: Date
    @State private var currentDate = Date()
    private let calendar = Calendar.current
    private var daysInWeek: [Date] {
        generateDaysInWeek(for: currentDate)
    }
    
    var body: some View {
        setHeader()
        Spacer()
        setWeekDaysHeader()
        setDaysScrollView()
    }
}

// MARK: - ViewBuilder
extension LinearCalendar {
    // 년, 월, 일 표기
    @ViewBuilder
    private func setHeader() -> some View {
        HStack {
            Button {
                withAnimation(.bouncy(duration: 0.5)) {
                    currentDate = calendar.date(byAdding: .weekOfYear, value: -1, to: currentDate) ?? currentDate
                }
                
            } label: {
                Image(systemName: WeekChangeButtonImageName.chevronLeft.rawValue)
                    .foregroundColor(.red)
                    .bold()
            }
            Spacer()
            Text(weekRangeString(for: currentDate))
                .font(Font.custom(FontName.saemaul.rawValue, size: 18))
            Spacer()
            Button {
                withAnimation(.bouncy(duration: 0.5)) {
                    currentDate = calendar.date(byAdding: .weekOfYear, value: 1, to: currentDate) ?? currentDate
                }
            } label: {
                Image(systemName: WeekChangeButtonImageName.chevronRight.rawValue)
                    .foregroundColor(.red)
                    .bold()
            }
        }
    }
    
    // 요일 표기
    @ViewBuilder
    private func setWeekDaysHeader() -> some View {
        let days = calendar.shortWeekdaySymbols
        HStack {
            ForEach(days, id: \.self) { day in
                Text(day)
                    .font(Font.custom(FontName.saemaul.rawValue, size: 17))
                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    // 날짜 표기
    @ViewBuilder
    private func setDaysScrollView() -> some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 9.5) {
                ForEach(daysInWeek, id: \.self) { date in
                    dayCell(for: date)
                }
            }
        }
    }
}

// MARK: - Function
extension LinearCalendar {
    // 한 주 표기 포맷 -> yyyy M.d
    private func weekRangeString(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy M.d"
        
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)) ?? date
        let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) ?? date
        
        return "\(formatter.string(from: startOfWeek)) - \(formatter.string(from: endOfWeek))"
    }
    
    // 날짜 한 칸
    private func dayCell(for date: Date) -> some View {
        let isSelected = calendar.isDate(date, inSameDayAs: selectedDate)
        let isToday = calendar.isDateInToday(date)
        
        return VStack {
            Text("\(calendar.component(.day, from: date))")
                .frame(width: 16)
                .font(Font.custom(FontName.saemaul.rawValue, size: 15))
                .padding()
                .background(isSelected ? Color.mint.opacity(0.3) : (isToday ? Color.red.opacity(0.3) : Color.clear))
                .cornerRadius(30)
        }
        .frame(maxWidth: .infinity)
        .onTapGesture {
            withAnimation(.smooth) {
                selectedDate = date
            }
        }
    }
    
    // 날짜 7개 생성
    private func generateDaysInWeek(for date: Date) -> [Date] {
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)) else {
            return []
        }
        
        return (0..<7).compactMap { dayOffset in
            calendar.date(byAdding: .day, value: dayOffset, to: startOfWeek)
        }
    }
}
//#Preview {
//    LinearCalendar()
//}
