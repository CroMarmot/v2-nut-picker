<template>
  <div slot="custom" class="v2-nut-picker" :class="customClassName || null">
    <div class="v2-nut-picker-panel">
      <template v-for="(item, index) of listData">
        <v2-nut-picker-slot
          :ref="`picker-slot-${index}`"
          :key="index"
          :default-value="chooseValueData[index]"
          :list-data="item"
          @chooseItem="chooseItem($event, index)"
        ></v2-nut-picker-slot>
      </template>
    </div>
  </div>
</template>
<script>
// https://github.com/jdf2e/nutui/tree/v2-dev/src/packages/picker

import V2NutPickerSlot from './v2-nut-picker-slot.vue'
const Picker = {
  name: 'V2NutPicker',
  components: {
    [V2NutPickerSlot.name]: V2NutPickerSlot
  },
  props: {
    customClassName: {
      type: String,
      default: null
    },
    listData: {
      type: Array,
      default: () => []
    },
    defaultValueData: {
      type: Array,
      default: () => []
    }
  },
  data() {
    return {
      chooseValueData: [],
      cacheValueData: []
    }
  },
  watch: {
    defaultValueData() {
      this.chooseValueData = [...this.defaultValueData]
      this.cacheValueData = [...this.defaultValueData]
    }
  },
  created() {
    if (this.defaultValueData && this.defaultValueData.length) {
      this.chooseValueData = [...this.defaultValueData]
    } else {
      this.chooseValueData = this.listData.map(item => item[0])
    }
  },
  methods: {
    updateChooseValue(self, index, value, notify = true) {
      self.cacheValueData.splice(index, 1, value)
      let ref = `picker-slot-${index}`
      self.$refs[ref] &&
        self.$refs[ref][0] &&
        self.$refs[ref][0].updateTransform(value)

      // 有改动就emit
      notify &&
        this.$emit('choose', {
          self,
          index,
          value,
          changeValueData: self.cacheValueData
        })
    },
    chooseItem({value}, index) {
      if (this.cacheValueData[index] !== value) {
        this.cacheValueData[index] = value
        /**
         * 滚动后事件
         * @property {Object} self - 自身实例
         * @property {Number} index - 本次变化的index
         * @property {String} value - 本次变化后该index上的值
         * @property {Object} changeValueData - 当前选中的所有列的值
         */
        this.$emit('choose', {
          self: this,
          index,
          value,
          changeValueData: this.cacheValueData
        })
      }
    }
  }
}

Picker.install = function(Vue) {
  Vue.component(Picker.name, Picker)
}

export default Picker
</script>

<style lang="less">
@import './v2-nut-picker.less';
</style>
