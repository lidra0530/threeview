/**
 * 滚动控制器
 * 处理滑动相关的逻辑和状态管理
 */

import { CalendarConstants } from '../utils/Constants'
import { ScrollHelper, SpeedCalculator } from '../utils/ScrollUtils'

// 模块名称常量
const MODULE_NAME = 'ScrollController'

export class ScrollController extends ListScroller {
  static instance: ScrollController | null = null
  // 滚动相关的状态
  private contentWidth: number = 0
  private viewportWidth: number = 0
  private inAdjustOffset: boolean = false
  private speedCalculator: SpeedCalculator = new SpeedCalculator()
  // 列宽和间距
  private columnWidth: number = CalendarConstants.DAY_COLUMN_WIDTH
  private columnSpace: number = CalendarConstants.DAY_COLUMN_SPACE
  // 滚动回调
  onScrollCallback: (offset: number) => void = () => {
  }

  private get columnInterval(): number {
    return this.columnWidth + this.columnSpace
  }

  private constructor() {
    super()
  }

  static getInstance() {
    if (!ScrollController.instance) {
      ScrollController.instance = new ScrollController()
    }
    return ScrollController.instance
  }

  destroy() {
    ScrollController.instance = null
  }

  // 初始化
  init(totalDays: number, viewportWidth: number, initialDayIndex: number = -1): void {
    this.viewportWidth = viewportWidth
    this.contentWidth = (totalDays - 1) * this.columnInterval + this.columnWidth
  }

  // 更新偏移量
  setOffset(): void {
    if (this.inAdjustOffset) {
      return
    }
    this.speedCalculator.setOffset(this.currentOffset().xOffset)
  }

  // 根据速度和当前位置计算滚动目标位置
  calculateTargetOffset(): number {
    const speed = this.speedCalculator.getSpeed()

    const targetOffset = ScrollHelper.calculateTargetOffset(
      this.currentOffset().xOffset,
      speed,
      this.columnInterval,
      this.contentWidth - this.viewportWidth
    )

    return targetOffset
  }

  // 获取滚动曲线
  getScrollCurve(): ESObject {
    const speed = this.speedCalculator.getSpeed()
    return ScrollHelper.getScrollCurve(speed)
  }

  // 滚动到指定日期索引
  scrollToDay(dayIndex: number, animated: boolean = true): void {
    const targetOffset = dayIndex * this.columnInterval
    this.scrollToOffset(targetOffset, animated)
  }

  // 滚动到指定偏移量
  private scrollToOffset(offset: number, animated: boolean = true): void {
    this.inAdjustOffset = true

    const targetOffset = Math.max(0, Math.min(offset, this.contentWidth - this.viewportWidth))
    this.scrollTo({ xOffset: targetOffset, yOffset: 0, animation: animated })

    this.inAdjustOffset = false
  }
}