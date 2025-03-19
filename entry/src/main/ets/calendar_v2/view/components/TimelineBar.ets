/**
 * 时间线组件
 * 显示小时刻度线
 */

import { CalendarConstants } from '../../utils/Constants';
import { FontStyles } from '../styles/CalendarStyle';

@Component
export struct TimelineBar {
  @Prop firstHour: number = CalendarConstants.DEFAULT_FIRST_HOUR;
  @Prop lastHour: number = CalendarConstants.DEFAULT_LAST_HOUR;
  private timeWidth: number = CalendarConstants.TIME_COLUMN_WIDTH;

  // 获取要显示的小时数组
  private getVisibleHours(): number[] {
    const hours: number[] = [];
    for (let i = this.firstHour; i <= this.lastHour; i++) {
      hours.push(i);
    }
    return hours;
  }

  build() {
    Column() {
      ForEach(this.getVisibleHours(), (hour: number) => {
        Row() {
          Text(`${hour}:00`)
            .fontSize(FontStyles.TIME_TEXT.fontSize)
            .fontColor(FontStyles.TIME_TEXT.fontColor)
            .width(this.timeWidth);

          Divider()
            .height(1)
            .color(CalendarConstants.DIVIDER_COLOR)
            .lineCap(LineCapStyle.Round);
        }
        .width('100%')
        .height(CalendarConstants.HOUR_HEIGHT);
      });
    }
    .width('100%')
    .height('100%')
    .padding({ top: CalendarConstants.HEADER_HEIGHT }) // 为顶部日期头部预留空间
    .justifyContent(FlexAlign.Start);
  }
} 