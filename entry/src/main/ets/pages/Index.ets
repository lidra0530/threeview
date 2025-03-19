// import { ThreeDayCalendarView } from '../calendar/view/ThreeDayView';
import { ThreeDayCalendarView } from "../calendar_v2/Index"

@Entry
@Component
struct MyPage {
  build() {
    Column() {
      ThreeDayCalendarView()
        .width('100%')
        .height('100%')
    }
    .width('100%')
    .height('100%')
  }
}