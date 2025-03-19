import { DayInfo } from '../../model/CalendarModel'
import { ScheduleItem } from '../../model/ScheduleModel'
import { CalendarConstants } from '../../utils/Constants'
import { ScheduleCard } from './ScheduleCard'

@ComponentV2
export struct DayColumn {
  @Param @Require day: DayInfo
  @Param @Require schedules: ScheduleItem[]
  private columnWidth: number = CalendarConstants.DAY_COLUMN_WIDTH

  // 获取特定日期的日程
  private getSchedulesForDay(): ScheduleItem[] {
    if (!this.day || !this.schedules) {
      return []
    }
    return this.schedules.filter(schedule => schedule.isInDate(this.day.date))
  }

  build() {
    Stack({ alignContent: Alignment.TopStart }) {
      // 渲染当天所有日程
      ForEach(this.getSchedulesForDay(), (schedule: ScheduleItem) => {
        ScheduleCard({
          schedule: schedule,
          day: this.day
        })
      })
    }.width(this.columnWidth).height('100%')
  }
}