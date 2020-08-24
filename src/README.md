Based on: https://github.com/jdf2e/nutui

修改了一点 typo

index 下标从 1 开始改为从 0 开始

考虑到 vue 的`$event` 只能把 emit 的首个参数处理掉，因此所有 emit 改为单个 emit 参数

去掉了没有必要的 把 index 向子组件传递再传回给父组件的动作

```js
<template>
<v2-nut-picker
  @choose="choose"
  :list-data="listData"
  :default-value-data="defaultValue"
></v2-nut-picker>
</template>

<script>
export default {
  data() {
    return {
      listData:[
        ['2020-01','2020-02','2020-03','2020-04','2020-05','2020-06','2020-07'],
        ['2020-01','2020-02','2020-03','2020-04','2020-05','2020-06'],
      ],
      defaultValue:[
        '2020-01',
        '2020-02',
      ]
    }
  },
  methods:{
    choose({self,index,value,changeValueData}){
      console.log(index,value,changeValueData);
        if(index === 0){
          if(value > changeValueData[1]){
            self.updateChooseValue(self, 1, value);
          }
        }else if(index === 1){
          if(value < changeValueData[0]){
            self.updateChooseValue(self, 0, value);
          }
        }
    }
  }
}
</script>
```
