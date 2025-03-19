import { DayInfo } from '../../model/CalendarModel'
import { CalendarConstants } from '../../utils/Constants'

@ComponentV2
export struct DayColumn {
  @Param @Require day: DayInfo
  private columnWidth: number = CalendarConstants.DAY_COLUMN_WIDTH
  private firstHour: number = CalendarConstants.DEFAULT_FIRST_HOUR

  build() {
    Stack({ alignContent: Alignment.TopStart }) {

    }.width(this.columnWidth).height('100%').backgroundColor(Color.Pink)
  }
}