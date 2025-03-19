/**
 * 三日视图主组件
 * 整合所有子组件，实现滑动和日程展示
 */

import { ScheduleController } from '../controller/ScheduleController'
import { ScrollController } from '../controller/ScrollController'
import { CalendarDataSource, DayInfo } from '../model/CalendarModel'
import { ScheduleItem } from '../model/ScheduleModel'
import { CalendarConstants } from '../utils/Constants'
import { CalendarHeaderItem } from './components/CalendarHeaderItem'
import { DayColumn } from './components/DayColumn'
import { TimelineBar } from './components/TimelineBar'

// 模块名称常量
const MODULE_NAME = 'ThreeDayView'

@ComponentV2
export struct ThreeDayCalendarView {
  // 状态变量
  @Local loading: boolean = false
  @Local schedules: ScheduleItem[] = []
  private dayDataSource: CalendarDataSource = new CalendarDataSource()
  // 控制器
  private scrollController: ScrollController = ScrollController.getInstance()
  private scheduleController: ScheduleController = ScheduleController.getInstance()
  // UI相关变量
  private totalDays: number = CalendarConstants.DEFAULT_DAYS_COUNT
  private timeWidth: number = CalendarConstants.TIME_COLUMN_WIDTH

  build() {
    Column() {
      // 标题栏
      Row() {
        Text('三日视图').fontSize(18).fontWeight(FontWeight.Bold)
      }.width('100%').height(56).padding({ left: 16, right: 16 })
      .backgroundColor($r('sys.color.white'))

      // 三日视图主体
      Stack() {
        // 时间背景线
        TimelineBar({
          firstHour: CalendarConstants.DEFAULT_FIRST_HOUR,
          lastHour: CalendarConstants.DEFAULT_LAST_HOUR
        })

        Row() {
          Blank().width(this.timeWidth)
          List({ space: CalendarConstants.DAY_COLUMN_SPACE, scroller: this.scrollController }) {
            LazyForEach(this.dayDataSource, (day: DayInfo) => {
              ListItem() {
                Column() {
                  CalendarHeaderItem({ day })
                  DayColumn({ day, schedules: this.schedules }).layoutWeight(1)
                }
              }
            })
          }
          .height('100%')
          .width('100%')
          .cachedCount(4)
          .layoutWeight(1)
          .listDirection(Axis.Horizontal)
          .edgeEffect(EdgeEffect.None)
          .scrollBar(BarState.Off)
          .onWillScroll(() => {
            this.scrollController.setOffset()
            this.scrollController.onScrollCallback(this.scrollController.currentOffset().xOffset)
          })
          .onTouch((e: TouchEvent) => {
            if (e.type === TouchType.Up) {
              // 计算目标位置并滚动
              const targetOffset = this.scrollController.calculateTargetOffset()
              this.scrollController.scrollTo({
                xOffset: targetOffset,
                yOffset: 0,
                animation: { curve: this.scrollController.getScrollCurve() }
              })
            }

            if (e.type === TouchType.Down) {
              this.scrollController.scrollBy(0, 0)
            }
          })
          .onAreaChange((_oldValue: Area, newValue: Area) => {
            // 初始化滚动控制器
            const width = newValue.width as number
            const todayIndex = this.dayDataSource.findTodayIndex()
            this.scrollController.init(this.totalDays, width, todayIndex)
            // 初始化日历
            this.initCalendar()
          })
        }.width('100%').height('100%')

        // 加载指示器
        if (this.loading) {
          Column() {
            LoadingProgress()
              .width(30)
              .height(30)
              .color($r('sys.color.brand'))
          }.width('100%')
          .height('100%')
          .backgroundColor('rgba(255, 255, 255, 0.7)')
          .justifyContent(FlexAlign.Center)
        }
      }.layoutWeight(1)
    }.width('100%')
    .height('100%')
    .backgroundColor(CalendarConstants.BACKGROUND_COLOR)
  }

  aboutToAppear(): void {
    // 初始化日期
    this.initData()

    // 设置回调
    this.scheduleController.setOnSchedulesChangeCallback(() => {
      this.schedules = this.scheduleController.getSchedules()
      this.loading = this.scheduleController.getIsLoading()
      console.info(MODULE_NAME, `日程数据更新，数量: ${this.schedules.length}, 加载状态: ${this.loading}`)
    })

    this.scheduleController.setOnSelectedScheduleChangeCallback((id: string) => {
      console.info(MODULE_NAME, `选中日程变化: ${id}`)
    })
  }

  aboutToDisappear(): void {
    this.scheduleController.destroy()
    this.scrollController.destroy()
  }

  // 初始化数据
  private initData() {
    // 初始化日期数据
    const today = new Date()
    this.dayDataSource.generateDays(today, this.totalDays)
  }

  // 初始化日历
  private async initCalendar() {
    // 滚动到今天
    const todayIndex = this.dayDataSource.findTodayIndex()
    this.scrollController.scrollToDay(todayIndex > 0 ? todayIndex - 1 : 0)

    // 加载日程数据
    await this.loadSchedules()
  }

  // 加载日程数据
  private async loadSchedules() {
    if (this.dayDataSource.totalCount() === 0) {
      console.info(MODULE_NAME, '没有日期数据，跳过日程加载')
      return
    }
    const length = this.dayDataSource.totalCount()
    const startDate = this.dayDataSource.getData(0).date
    const endDate = this.dayDataSource.getData(length - 1).date

    console.info(MODULE_NAME,
      `开始加载日程数据，日期范围: ${startDate.toLocaleDateString()} 至 ${endDate.toLocaleDateString()}`)


    await this.scheduleController.loadSchedules(startDate, endDate)

    console.info(MODULE_NAME, `日程数据加载完成，数量: ${this.schedules.length}`)
  }
}