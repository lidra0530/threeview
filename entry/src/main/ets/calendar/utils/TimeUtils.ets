/**
 * 时间工具类
 * 处理时间相关的计算和格式化
 */

// 将时间字符串转换为小时数
export function timeToHours(timeString: string): number {
  const timeParts = timeString.split(':');
  const hours = Number(timeParts[0]);
  const minutes = Number(timeParts[1]);
  return hours + minutes / 60;
}

// 格式化小时数为时间字符串
export function hoursToTimeString(hours: number): string {
  const h = Math.floor(hours);
  const m = Math.round((hours - h) * 60);
  return `${h.toString().padStart(2, '0')}:${m.toString().padStart(2, '0')}`;
}

// 判断两个日期是否是同一天
export function isSameDay(date1: Date, date2: Date): boolean {
  return date1.getFullYear() === date2.getFullYear() &&
    date1.getMonth() === date2.getMonth() &&
    date1.getDate() === date2.getDate();
}

// 获取两个日期之间的天数差
export function daysBetween(startDate: Date, endDate: Date): number {
  const normalizeDate = (d: Date): number => {
    return new Date(d.getFullYear(), d.getMonth(), d.getDate()).getTime();
  };

  const dayTime = 24 * 60 * 60 * 1000;
  const diff = normalizeDate(endDate) - normalizeDate(startDate);
  return Math.round(diff / dayTime);
} 