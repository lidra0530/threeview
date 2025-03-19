import { ScheduleItem } from '../model/ScheduleModel'
import { timeToHours } from './TimeUtils'

// 日程位置和尺寸计算
export class LayoutCalculator {
  // 计算日程在时间轴上的垂直位置
  static getScheduleTopPosition(schedule: ScheduleItem, firstHour: number): number {
    const startTimeParts = schedule.startTime.split(':')
    const hours = Number(startTimeParts[0])
    const minutes = Number(startTimeParts[1])
    const totalHours = hours + minutes / 60

    // 计算顶部位置，每小时60px
    return (totalHours - firstHour) * 60
  }

  // 计算日程的高度
  static getScheduleHeight(schedule: ScheduleItem): number {
    const startHour = timeToHours(schedule.startTime)
    const endHour = timeToHours(schedule.endTime)
    const durationHours = endHour - startHour

    // 计算高度，每小时60px
    return Math.max(durationHours * 60, 30) // 最小高度30px
  }

  // 计算跨天日程在特定日期的宽度占比
  static getScheduleWidthPercent(schedule: ScheduleItem, date: Date): number {
    if (schedule.duration === 1) {
      return 100 // 单天日程占满整列
    } else {
      // 获取这个日期开始后的可见天数
      const visibleDays = schedule.getVisibleDaysFrom(date)
      // 返回百分比宽度
      return 100 * visibleDays
    }
  }

  // 检测日程是否有重叠
  static hasOverlap(schedule1: ScheduleItem, schedule2: ScheduleItem, date: Date): boolean {
    // 如果不在同一天，则不重叠
    if (!schedule1.isInDate(date) || !schedule2.isInDate(date)) {
      return false
    }

    // 获取开始和结束时间
    const start1 = timeToHours(schedule1.startTime)
    const end1 = timeToHours(schedule1.endTime)
    const start2 = timeToHours(schedule2.startTime)
    const end2 = timeToHours(schedule2.endTime)

    // 检查时间段是否重叠
    return (start1 < end2) && (start2 < end1)
  }
}