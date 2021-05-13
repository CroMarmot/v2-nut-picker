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
