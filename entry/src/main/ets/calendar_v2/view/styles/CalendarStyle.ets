/**
 * 日历样式定义
 * 统一管理日历相关组件的样式
 */

import { CalendarConstants } from '../../utils/Constants';

// 字体样式接口定义
interface TextStyleOptions {
  fontSize: number;
  fontWeight?: FontWeight;
  fontColor?: string;
  maxLines?: number;
  opacity?: number;
}

// 动画选项接口定义
interface AnimationOptions {
  duration: number;
  curve: Curve;
  delay: number;
}

// 字体样式
export class FontStyles {
  // 头部样式
  static readonly HEADER_WEEK_TEXT: TextStyleOptions = {
    fontSize: 14,
    fontWeight: FontWeight.Normal
  };
  static readonly HEADER_DAY_TEXT: TextStyleOptions = {
    fontSize: 20,
    fontWeight: FontWeight.Normal
  };
  static readonly HEADER_TODAY_TEXT: TextStyleOptions = {
    fontSize: 20,
    fontWeight: FontWeight.Bold,
    fontColor: CalendarConstants.TODAY_COLOR
  };
  // 时间线样式
  static readonly TIME_TEXT: TextStyleOptions = {
    fontSize: 12,
    fontColor: CalendarConstants.TIME_TEXT_COLOR
  };
  // 日程样式
  static readonly SCHEDULE_TITLE: TextStyleOptions = {
    fontSize: 14,
    fontColor: '#FFFFFF',
    maxLines: 1
  };
  static readonly SCHEDULE_TIME: TextStyleOptions = {
    fontSize: 12,
    fontColor: '#FFFFFF',
    opacity: 0.8
  };
}

// 布局样式
export class LayoutStyles {
  // 间距
  static readonly CARD_PADDING: number = 8;
  static readonly HEADER_MARGIN: number = 4;
  // 圆角
  static readonly CARD_RADIUS: number = 4;
  // 阴影
  static readonly CARD_ELEVATION: number = 2;
}

// 动画样式
export class AnimationStyles {
  // 透明度变化
  static readonly FADE_IN: AnimationOptions = {
    duration: 200,
    curve: Curve.EaseOut,
    delay: 0
  };
  static readonly FADE_OUT: AnimationOptions = {
    duration: 150,
    curve: Curve.EaseIn,
    delay: 0
  };
} 