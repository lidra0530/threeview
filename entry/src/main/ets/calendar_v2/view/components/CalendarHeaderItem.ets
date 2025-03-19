/**
 * 日期头部组件
 * 显示日期和星期信息
 */

import { DayInfo } from '../../model/CalendarModel'
import { CalendarConstants } from '../../utils/Constants'
import { FontStyles, LayoutStyles } from '../styles/CalendarStyle'

@Component
export struct CalendarHeaderItem {
  @Prop day: DayInfo // 要显示的所有日期
  private itemWidth: number = CalendarConstants.DAY_COLUMN_WIDTH

  build() {
    Column() {
      // 星期
      Text(this.day.dayOfWeek)
        .fontSize(FontStyles.HEADER_WEEK_TEXT.fontSize)
        .fontColor(this.day.isToday ? CalendarConstants.TODAY_COLOR : CalendarConstants.NORMAL_TEXT_COLOR)
        .margin({ bottom: LayoutStyles.HEADER_MARGIN })

      // 日期
      Text(this.day.dayOfMonth.toString())
        .fontSize(this.day.isToday ? FontStyles.HEADER_TODAY_TEXT.fontSize : FontStyles.HEADER_DAY_TEXT.fontSize)
        .fontWeight(this.day.isToday ? FontStyles.HEADER_TODAY_TEXT.fontWeight : FontStyles.HEADER_DAY_TEXT.fontWeight)
        .fontColor(this.day.isToday ? CalendarConstants.TODAY_COLOR : CalendarConstants.NORMAL_TEXT_COLOR)
    }
    .width(this.itemWidth)
    .height(CalendarConstants.HEADER_HEIGHT)
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .backgroundColor($r('sys.color.white'))
  }
}