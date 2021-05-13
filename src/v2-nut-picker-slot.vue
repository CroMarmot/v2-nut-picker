<template>
  <div class="v2-nut-picker-list">
    <div ref="roller" class="v2-nut-picker-roller">
      <div
        v-for="(item, index) in listData"
        :key="item.label || index"
        class="v2-nut-picker-roller-item"
        :class="{'v2-nut-picker-roller-item-hidden': isHidden(index)}"
        :style="setRollerStyle(index)"
      >
        {{ item.value || item }}
      </div>
    </div>
    <div class="v2-nut-picker-content">
      <div ref="list" class="v2-nut-picker-list-panel">
        <div
          v-for="(item, index) in listData"
          :key="item.label || index"
          class="v2-nut-picker-item"
        >
          {{ item.value || item }}
        </div>
        <div
          v-if="listData && listData.length === 1"
          class="v2-nut-picker-placeholder"
        ></div>
      </div>
    </div>
    <div class="v2-nut-picker-mask"></div>
    <div class="v2-nut-picker-indicator"></div>
  </div>
</template>
<script>
export default {
  name: 'V2NutPickerSlot',
  props: {
    listData: {
      type: Array,
      required: true
    },
    defaultValue: {
      type: String
    }
  },
  data() {
    return {
      touchParams: {
        startY: 0,
        endY: 0,
        startTime: 0,
        endTime: 0
      },
      currIndex: 0,
      transformY: 0,
      scrollDistance: 0,
      lineSpacing: 36,
      rotation: 20,
      timer: null
    }
  },
  watch: {
    defaultValue() {
      this.transformY = 0
      this.modifyStatus()
    }
  },
  mounted() {
    this.$nextTick(() => {
      this.modifyStatus(true)
      this.$el.addEventListener('touchstart', this.touchStart)
      this.$el.addEventListener('touchmove', this.touchMove)
      this.$el.addEventListener('touchend', this.touchEnd)
      this.$el.addEventListener('mousedown', this.mouseDown)
    })
  },
  beforeDestroy() {
    this.$el.removeEventListener('touchstart', this.touchStart)
    this.$el.removeEventListener('touchmove', this.touchMove)
    this.$el.removeEventListener('touchend', this.touchEnd)
    this.$el.removeEventListener('mousedown', this.mouseDown)
    clearTimeout(this.timer)
  },
  methods: {
    updateTransform(value) {
      if (value) {
        this.transformY = 0
        this.timer = setTimeout(() => {
          this.modifyStatus(null, value)
        }, 10)
      }
    },
    setRollerStyle(index) {
      return `transform: rotate3d(1, 0, 0, ${-this.rotation *
        (index + 1)}deg) translate3d(0px, 0px, 104px)`
    },
    isHidden(index) {
      if (index >= this.currIndex + 8 || index <= this.currIndex - 8) {
        return true
      } else {
        return false
      }
    },
    setTransform(translateY = 0, type, time = 1000, deg) {
      if (type === 'end') {
        this.$refs.list.style.webkitTransition = `transform ${time}ms cubic-bezier(0.19, 1, 0.22, 1)`
        this.$refs.roller.style.webkitTransition = `transform ${time}ms cubic-bezier(0.19, 1, 0.22, 1)`
      } else {
        this.$refs.list.style.webkitTransition = ''
        this.$refs.roller.style.webkitTransition = ''
      }
      this.$refs.list.style.webkitTransform = `translate3d(0, ${translateY}px, 0)`
      this.$refs.roller.style.webkitTransform = `rotate3d(1, 0, 0, ${deg})`
      this.scrollDistance = translateY
    },
    setMove(move, type, time) {
      let updateMove = move + this.transformY
      if (type === 'end') {
        // 限定滚动距离
        if (updateMove > 0) {
          updateMove = 0
        }
        if (updateMove < -(this.listData.length - 1) * this.lineSpacing) {
          updateMove = -(this.listData.length - 1) * this.lineSpacing
        }
        // 设置滚动距离为lineSpacing的倍数值
        const endMove =
          Math.round(updateMove / this.lineSpacing) * this.lineSpacing
        const deg = `${(Math.abs(Math.round(endMove / this.lineSpacing)) + 1) *
          this.rotation}deg`
        this.setTransform(endMove, type, time, deg)
        this.currIndex = Math.abs(Math.round(endMove / this.lineSpacing))
        this.timer = setTimeout(() => {
          this.setChooseValue(this.currIndex)
        }, time / 2)
      } else {
        let deg = '0deg'
        // 限定滚动距离
        const boundCnt = 3
        const upperBound = boundCnt * this.lineSpacing
        const lowerBound =
          (-boundCnt - (this.listData.length - 1)) * this.lineSpacing
        if (updateMove > upperBound) {
          updateMove = upperBound + Math.sqrt(updateMove - upperBound)
        }
        if (updateMove < lowerBound) {
          updateMove = lowerBound - Math.sqrt(lowerBound - updateMove)
        }
        if (updateMove < 0) {
          deg = `${(Math.abs(updateMove / this.lineSpacing) + 1) *
            this.rotation}deg`
        } else {
          deg = `${(-updateMove / this.lineSpacing + 1) * this.rotation}deg`
        }
        this.setTransform(updateMove, null, null, deg)
        this.currIndex = Math.abs(Math.round(updateMove / this.lineSpacing))
      }
    },
    setChooseValue(index) {
      // 范围保护
      // 因为上面有settimeout， 而触发其它列变化，时可能导致当前列的可选值变化， 所以这里需要保护
      if (index < 0 || index >= this.listData.length) {
        console.error(index)
      }
      if (index < 0) {
        index = 0
      } else if (index >= this.listData.length) {
        index = this.listData.length - 1
      }
      /**
       * 滚动后事件
       * @property {String} value - 选中的值
       * @property {Number} index - 选中的下标
       */
      this.$emit('chooseItem', {
        index,
        value: this.listData[index]
      })
    },
    touchStart(event) {
      event.preventDefault()
      const changedTouches = event.changedTouches[0]
      this.commonStart(changedTouches.pageY)
    },
    touchMove(event) {
      event.preventDefault()
      const changedTouches = event.changedTouches[0]
      this.commonMove(changedTouches.pageY)
    },
    touchEnd(event) {
      event.preventDefault()
      const changedTouches = event.changedTouches[0]
      this.commonEnd(changedTouches.pageY)
    },
    mouseDown(event) {
      event.preventDefault()
      this.commonStart(event.pageY)
      this.$el.addEventListener('mousemove', this.mouseMove)
      window.addEventListener('mouseup', this.mouseEnd)
    },
    mouseMove(event) {
      event.preventDefault()
      this.commonMove(event.pageY)
    },
    mouseEnd(event) {
      event.preventDefault()
      this.commonEnd(event.pageY)
      this.$el.removeEventListener('mousemove', this.mouseMove)
      window.removeEventListener('mouseup', this.mouseEnd)
    },
    commonStart(Y) {
      this.touchParams.startY = Y
      this.touchParams.startTime = event.timestamp || Date.now()
      this.transformY = this.scrollDistance
    },
    commonMove(Y) {
      this.touchParams.lastY = Y
      this.touchParams.lastTime = event.timestamp || Date.now()
      const move = this.touchParams.lastY - this.touchParams.startY
      this.setMove(move)
    },
    commonEnd(Y) {
      this.touchParams.lastY = Y
      this.touchParams.lastTime = event.timestamp || Date.now()
      let move = this.touchParams.lastY - this.touchParams.startY
      let moveTime = this.touchParams.lastTime - this.touchParams.startTime
      if (moveTime <= 300) {
        move = move * 2
        moveTime = moveTime + 1000
        this.setMove(move, 'end', moveTime)
      } else {
        this.setMove(move, 'end')
      }
    },
    modifyStatus(type, defaultValue) {
      defaultValue = defaultValue || this.defaultValue
      let index = -1
      if (defaultValue && defaultValue.value) {
        this.listData.some((item, idx) => {
          if (item.value === defaultValue.value) {
            index = idx
            return true
          }
        })
      } else {
        index = this.listData.indexOf(defaultValue)
      }
      if (index === -1) {
        process.env.NODE_ENV === 'development' &&
          console.warn('defaultValue', defaultValue, 'not found.')
      }
      this.currIndex = index === -1 ? 0 : index
      const move = this.currIndex * this.lineSpacing
      type && this.setChooseValue(this.currIndex)
      this.setMove(-move)
    }
  }
}
</script>
