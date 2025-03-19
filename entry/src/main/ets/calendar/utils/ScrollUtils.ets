import Curves from '@ohos.curves'

// 速度计算器类
export class SpeedCalculator {
  timestamp: number = 0
  offset: number = 0
  speed: number = 0

  // 记录滑动位置并计算速度
  setOffset(offset: number): void {
    const date = new Date()
    const currentTime = date.getTime()

    if (this.timestamp === 0) {
      this.timestamp = currentTime
      this.offset = offset
      return
    }

    if (this.timestamp !== currentTime) {
      this.speed = (offset - this.offset) / (currentTime - this.timestamp)
      this.timestamp = currentTime
      this.offset = offset
    }
  }

  // 获取当前滑动速度
  getSpeed(): number {
    return this.speed * 1000
  }

  // 重置计算器
  reset(): void {
    this.timestamp = 0
    this.offset = 0
    this.speed = 0
  }
}

// 滑动助手类
export class ScrollHelper {
  // 计算惯性滑动的目标位置
  static calculateTargetOffset(currentOffset: number, speed: number, itemWidth: number, maxOffset: number): number {
    // 根据速度和当前位置计算目标位置
    let target = Math.round((currentOffset + speed / 2.5) / itemWidth) * itemWidth
    // 确保不会超出边界
    return Math.max(Math.min(target, maxOffset), 0)
  }

  // 获取惯性滑动的曲线
  static getScrollCurve(velocity: number): Curves.ICurve {
    // 根据速度选择不同的弹性曲线
    const absVelocity = Math.abs(velocity)

    if (absVelocity > 1000) {
      // 高速滑动，使用较弱阻尼
      return Curves.springMotion(0.6, 1.1)
    } else if (absVelocity > 500) {
      // 中速滑动，使用适中阻尼
      return Curves.springMotion(0.8, 1.2)
    } else {
      // 低速滑动，使用较强阻尼
      return Curves.springMotion(0.9, 1.3)
    }
  }
}