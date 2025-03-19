/**
 * 日程控制器
 * 处理日程数据的加载和管理
 */

import { ScheduleItem, ScheduleService } from '../model/ScheduleModel'

// 模块名称常量
const MODULE_NAME = 'ScheduleController'

export class ScheduleController {
  private static instance: ScheduleController | null = null
  private schedules: ScheduleItem[] = []
  private scheduleService: ScheduleService = new ScheduleService()
  private selectedScheduleId: string = ''
  private isLoading: boolean = false
  private onSchedulesChangeCallback: () => void = () => {
  }
  private onSelectedScheduleChangeCallback: (id: string) => void = () => {
  }

  private constructor() {
  }

  static getInstance(): ScheduleController {
    if (!ScheduleController.instance) {
      ScheduleController.instance = new ScheduleController()
    }
    return ScheduleController.instance
  }

  destroy() {
    ScheduleController.instance = null
  }

  // 获取所有日程
  getSchedules(): ScheduleItem[] {
    return this.schedules
  }

  // 获取选中的日程ID
  getSelectedScheduleId(): string {
    return this.selectedScheduleId
  }

  // 获取加载状态
  getIsLoading(): boolean {
    return this.isLoading
  }

  // 设置日程变化回调
  setOnSchedulesChangeCallback(callback: () => void): void {
    this.onSchedulesChangeCallback = callback
  }

  // 设置日程选中状态变化回调
  setOnSelectedScheduleChangeCallback(callback: (id: string) => void): void {
    this.onSelectedScheduleChangeCallback = callback
  }

  // 加载指定日期范围的日程
  async loadSchedules(startDate: Date, endDate: Date): Promise<void> {
    this.isLoading = true
    this.notifySchedulesChange()

    try {
      this.schedules = await this.scheduleService.getSchedulesInRange(startDate, endDate)
      this.notifySchedulesChange()
    } catch (error) {
      console.error('加载日程失败:', error)
    } finally {
      this.isLoading = false
      this.notifySchedulesChange()
    }
  }

  // 选中日程
  selectSchedule(scheduleId: string): void {
    if (this.selectedScheduleId !== scheduleId) {
      this.selectedScheduleId = scheduleId
      this.notifySelectedScheduleChange()
    }
  }

  // 取消选中日程
  clearSelection(): void {
    if (this.selectedScheduleId !== '') {
      this.selectedScheduleId = ''
      this.notifySelectedScheduleChange()
    }
  }

  // 获取特定日期的日程
  getSchedulesForDay(date: Date): ScheduleItem[] {
    const result = this.schedules.filter(schedule => schedule.isInDate(date))
    return result
  }

  // 通知日程数据变化
  private notifySchedulesChange(): void {
    this.onSchedulesChangeCallback()
  }

  // 通知选中日程变化
  private notifySelectedScheduleChange(): void {
    this.onSelectedScheduleChangeCallback(this.selectedScheduleId)
  }
}