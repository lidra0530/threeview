import { ScheduleController } from '../../controller/ScheduleController'
import { DayInfo } from '../../model/CalendarModel'
import { ScheduleItem } from '../../model/ScheduleModel'
import { CalendarConstants } from '../../utils/Constants'
import { LayoutCalculator } from '../../utils/LayoutUtil'
import { FontStyles, LayoutStyles } from '../styles/CalendarStyle'

@ComponentV2
export struct ScheduleCard {
  @Param @Require schedule: ScheduleItem
  @Param @Require day: DayInfo
  @Local isSelected: boolean = false
  private firstHour: number = CalendarConstants.DEFAULT_FIRST_HOUR
  private scheduleController: ScheduleController = ScheduleController.getInstance()

  build() {
    Row() {
      // 关键点：只在日程第一天或非跨天日程显示内容
      if (this.schedule.isFirstDay(this.day.date) || !this.schedule.isMultiDay()) {
        Column() {
          Text(this.schedule.title)
            .fontSize(FontStyles.SCHEDULE_TITLE.fontSize)
            .fontColor(FontStyles.SCHEDULE_TITLE.fontColor)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
            .maxLines(1)

          Text(`${this.schedule.startTime}-${this.schedule.endTime}`)
            .fontSize(FontStyles.SCHEDULE_TIME.fontSize)
            .fontColor(FontStyles.SCHEDULE_TIME.fontColor)
            .opacity(FontStyles.SCHEDULE_TIME.opacity)
        }.padding(LayoutStyles.CARD_PADDING)
      }
    }
    .width(`${LayoutCalculator.getScheduleWidthPercent(this.schedule, this.day.date)}%`)
    .height(LayoutCalculator.getScheduleHeight(this.schedule))
    .backgroundColor(this.schedule.color)
    .opacity(this.isSelected ? 0.8 : 1)
    .borderRadius(LayoutStyles.CARD_RADIUS)
    .borderWidth(this.isSelected ? 2 : 0)
    .borderColor($r('sys.color.black'))
    .position({
      x: 0, // 关键点：固定位置在左侧
      y: LayoutCalculator.getScheduleTopPosition(this.schedule, this.firstHour)
    })
    .onClick(() => {
      this.onScheduleClick()
    })
  }

  // 日程点击事件
  onScheduleClick() {
    this.scheduleController?.selectSchedule(this.schedule.id)
  }
}