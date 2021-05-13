基本用法

```vue
<template>
  <v2-nut-picker
    :list-data="listData"
    :default-value-data="defaultValue"
    @choose="choose"
  />
</template>

<script>
// import V2NutPicker from '@cromarmot/v2-nut-picker'
export default {
  // components: { V2NutPicker },
  data() {
    return {
      listData: [
        ['2020-01', '2020-02', '2020-03', '2020-04', '2020-05', '2020-06', '2020-07'],
        ['2020-01', '2020-02', '2020-03', '2020-04', '2020-05', '2020-06']
      ],
      defaultValue: [
        '2020-01',
        '2020-02'
      ]
    }
  },
  methods: {
    choose({ self, index, value, changeValueData }) {
      console.log(index, value, changeValueData)
      if (index === 0) {
        if (value > changeValueData[1]) {
          self.updateChooseValue(self, 1, value)
        }
      } else if (index === 1) {
        if (value < changeValueData[0]) {
          self.updateChooseValue(self, 0, value)
        }
      }
    }
  }
}
</script>
```
