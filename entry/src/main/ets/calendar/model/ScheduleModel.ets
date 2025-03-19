@ObservedV2
export class ScheduleItem {
  id: string
  title: string
  year: number
  startMonth: number
  startDay: number
  duration: number
  startTime: string
  endTime: string
  color: string
  private _startDate: Date | null = null // 缓存开始日期
  private _endDate: Date | null = null // 缓存结束日期

  constructor(id: string, title: string, year: number, startMonth: number, startDay: number, duration: number,
    startTime: string, endTime: string, color: string) {
    this.id = id
    this.title = title
    this.year = year
    this.startMonth = startMonth
    this.startDay = startDay
    this.duration = duration
    this.startTime = startTime
    this.endTime = endTime
    this.color = color
  }

  // 判断是否是跨天日程
  isMultiDay(): boolean {
    return this.duration > 1
  }

  // 获取开始日期（带缓存）
  getStartDate(): Date {
    if (!this._startDate) {
      this._startDate = new Date(this.year, this.startMonth - 1, this.startDay)
    }
    return this._startDate
  }

  // 获取结束日期（带缓存）
  getEndDate(): Date {
    if (!this._endDate) {
      const startDate = this.getStartDate()
      this._endDate = new Date(startDate)
      this._endDate.setDate(startDate.getDate() + this.duration - 1)
    }
    return this._endDate
  }

  // 判断日程是否在指定日期
  isInDate(date: Date): boolean {
    // 使用时间戳比较，只比较年月日
    const normalizeDate = (d: Date): number => {
      return new Date(d.getFullYear(), d.getMonth(), d.getDate()).getTime()
    }

    const targetTime = normalizeDate(date)
    const startTime = normalizeDate(this.getStartDate())
    const endTime = normalizeDate(this.getEndDate())

    return targetTime >= startTime && targetTime <= endTime
  }


  // 判断是否是日程的第一天
  isFirstDay(date: Date): boolean {
    const d1 = date
    const d2 = this.getStartDate()
    return d1.getFullYear() === d2.getFullYear() &&
      d1.getMonth() === d2.getMonth() &&
      d1.getDate() === d2.getDate()
  }

  // 计算日程在某个日期的可见天数
  getVisibleDaysFrom(date: Date): number {
    if (!this.isInDate(date)) {
      return 0
    }

    // 计算从当前日期到日程结束还有几天
    const normalizeDate = (d: Date): number => {
      return new Date(d.getFullYear(), d.getMonth(), d.getDate()).getTime()
    }

    const dayTime = 24 * 60 * 60 * 1000
    const diff = normalizeDate(this.getEndDate()) - normalizeDate(date)
    return Math.floor(diff / dayTime) + 1
  }

  // 获取日程持续时间（小时）
  getDurationHours(): number {
    const startHour = getTimeToHour(this.startTime)
    const endHour = getTimeToHour(this.endTime)
    return endHour - startHour
  }
}

// 辅助函数：将时间字符串转换为小时数
export function getTimeToHour(timeString: string): number {
  const timeParts = timeString.split(':')
  const hours = Number(timeParts[0])
  const minutes = Number(timeParts[1])
  return hours + minutes / 60
}

// 日程服务类
export class ScheduleService {
  // 获取指定日期范围内的日程
  getSchedulesInRange(startDate: Date, endDate: Date): Promise<ScheduleItem[]> {
    // 这里可以连接实际数据源
    // 目前使用模拟数据
    return new Promise((resolve) => {
      setTimeout(() => {
        resolve(this.getMockSchedules())
      }, 100)
    })
  }

  // 模拟数据生成
  private getMockSchedules(): ScheduleItem[] {
    const currentYear = new Date().getFullYear()
    const currentMonth = new Date().getMonth() + 1
    const currentDay = new Date().getDate()
    return [
      new ScheduleItem('1', '产品评审会议', currentYear, currentMonth, currentDay - 1, 1, '09:00', '10:30', '#8A2BE2'),
      new ScheduleItem('2', '团队周会', currentYear, currentMonth, currentDay - 1, 1, '14:00', '15:00', '#4169E1'),
      new ScheduleItem('3', '项目启动会', currentYear, currentMonth, currentDay, 2, '10:00', '11:30', '#3CB371'),
      new ScheduleItem('4', '用户调研总结', currentYear, currentMonth, currentDay, 1, '15:00', '16:00', '#FF7F50'),
      new ScheduleItem('5', '鸿蒙培训课程', currentYear, currentMonth, currentDay + 1, 3, '09:30', '11:30', '#1E90FF'),
      new ScheduleItem('6', '部门团建活动', currentYear, currentMonth, currentDay + 1, 1, '15:30', '17:00', '#FF69B4'),
      new ScheduleItem('7', '设计评审', currentYear, currentMonth, currentDay + 2, 1, '10:00', '11:00', '#32CD32'),
      new ScheduleItem('8', '代码审查', currentYear, currentMonth, currentDay + 2, 1, '14:00', '15:30', '#FF8C00'),
      new ScheduleItem('9', '年终总结大会', currentYear, currentMonth, currentDay + 3, 3, '09:00', '18:00',
        '#DC143C')
    ]
  }

  // 添加日程
  addSchedule(schedule: ScheduleItem): Promise<boolean> {
    // 实际实现中连接数据源
    return Promise.resolve(true)
  }

  // 更新日程
  updateSchedule(schedule: ScheduleItem): Promise<boolean> {
    // 实际实现中连接数据源
    return Promise.resolve(true)
  }

  // 删除日程
  deleteSchedule(scheduleId: string): Promise<boolean> {
    // 实际实现中连接数据源
    return Promise.resolve(true)
  }

  // 根据日期获取当天的日程
  getSchedulesForDay(date: Date, allSchedules: ScheduleItem[]): ScheduleItem[] {
    return allSchedules.filter(schedule => schedule.isInDate(date))
  }
}