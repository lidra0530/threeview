/**
 * 日历数据模型
 * 处理日期相关的数据结构和业务逻辑
 */
import { BasicDataSource } from '../utils/BasicDataSource'

// 日期信息类
export class DayInfo {
  date: Date
  year: number
  month: number
  dayOfMonth: number
  dayOfWeek: string
  isToday: boolean

  constructor(date: Date) {
    this.date = date
    this.year = date.getFullYear()
    this.month = date.getMonth() + 1
    this.dayOfMonth = date.getDate()

    const weekdays = ['周日', '周一', '周二', '周三', '周四', '周五', '周六']
    this.dayOfWeek = weekdays[date.getDay()]

    const today = new Date()
    this.isToday = date.getFullYear() === today.getFullYear() &&
      date.getMonth() === today.getMonth() &&
      date.getDate() === today.getDate()
  }
}

// 日历数据管理类
export class CalendarDataSource extends BasicDataSource<DayInfo> {
  private _days: DayInfo[] = []

  constructor() {
    super()
  }

  public totalCount(): number {
    return this._days.length
  }

  public getData(index: number): DayInfo {
    return this._days[index]
  }

  public getDays(): DayInfo[] {
    return this._days
  }

  public pushData(data: DayInfo): void {
    this._days.push(data)
    this.notifyDataAdd(this._days.length - 1)
  }

  // 生成日期数据
  public generateDays(centerDate: Date, totalDays: number): void {
    const startDate = new Date(centerDate)
    startDate.setDate(centerDate.getDate() - Math.floor(totalDays / 2))

    this._days = []
    for (let i = 0; i < totalDays; i++) {
      const date = new Date(startDate)
      date.setDate(startDate.getDate() + i)
      this.pushData(new DayInfo(date))
    }
  }

  // 获取当前日期在数组中的索引
  public findTodayIndex(): number {
    return this._days.findIndex(day => day.isToday)
  }
}