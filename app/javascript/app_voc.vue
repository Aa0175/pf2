<template>
<div id="app">
  <p>{{ resultNum }}</p>
</div>
</template>

<script>
export default {
  data () {
  return{
    firstNum:3,
    secondNum:4
    }
  },
  computed: {
    // 算出 getter 関数
   resultNum: function () {
      // `this` は vm インスタンスを指します
      let a = {};
      a["id"] = this.firstNum;
      a["title"] = this.secondNum;
      // return this.firstNum * this.secondNum
      return a;
    }
  }
}
</script>

<style scoped>
</style>
