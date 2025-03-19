/**
 * 全局常量定义
 * 统一管理应用中使用的常量
 */

// 日历常量
export class CalendarConstants {
  // 布局相关
  static readonly TIME_COLUMN_WIDTH: number = 40 // 时间列宽度
  static readonly DAY_COLUMN_WIDTH: number = 120 // 日期列宽度
  static readonly DAY_COLUMN_SPACE: number = 4 // 日期列间距
  static readonly HOUR_HEIGHT: number = 60 // 每小时高度
  static readonly HEADER_HEIGHT: number = 60 // 头部高度

  // 时间范围
  static readonly DEFAULT_FIRST_HOUR: number = 8 // 默认开始小时
  static readonly DEFAULT_LAST_HOUR: number = 18 // 默认结束小时

  // 数据相关
  static readonly DEFAULT_DAYS_COUNT: number = 30 // 默认加载的天数
  static readonly VISIBLE_DAYS_COUNT: number = 4 // 可见的天数

  // 颜色
  static readonly TODAY_COLOR: string = '#007DFF' // 今天的高亮颜色
  static readonly NORMAL_TEXT_COLOR: string = '#333333' // 普通文本颜色
  static readonly BACKGROUND_COLOR: string = '#F5F5F5' // 背景色
  static readonly TIME_TEXT_COLOR: string = '#888888' // 时间文本颜色
  static readonly DIVIDER_COLOR: string = '#E0E0E0' // 分隔线颜色

  // 动画相关
  static readonly ANIMATION_DURATION: number = 300 // 动画持续时间(ms)
}