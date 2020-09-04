<template>
<div class="ui one column stackable center aligned page grid">
  <div class="column fourteen wide">
    <div class="ui segment users_box">
      <h1>Q:{{ arrangeQ.content }}</h1>
<!-- 　
      1.選択肢ボタン(メソッドupdate())が押される
      2.メソッドでget&then
      問題は/api/v1/nodes/${this.$route.params.id}.jsonにどうやってパラメータを渡す？
      →v-on:click="someFunction(引数)"
        @click="someFunction(引数)"
        <div v-for="n in arrangeA" :key="n.id">
            <router-link class="ui segment attached button" :to="{ name: 'Q_and_A', params: { id: n.id } }" >
              A:{{ n.content }}
            </router-link>
            <div v-for="n in arrangeA" :key="n.id">
                <div class="ui segment" v-on:click="nextURL(2)">
                  A:{{ n.content }}
                </div>
-->
          <div v-for="n in arrangeA" :key="n.id">
            <div class="ui segment" v-on:click="nextURL()">
              A:{{ n.content }}
            </div>
      </div>
      <div class="ui segment">(Aが4以下の場合)回答を追加する</div>
    </div>
  </div>
</div>

</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      nodes: {},
    }
  },
  computed : {
    arrangeQ: function () {
      let question = [];
      question = this.nodes[0];
      return question;
    },
    arrangeA: function () {
      let answers = [];
      let i = 1;
      let n = 0;
      while (i < this.nodes.length) {
        answers[n] = this.nodes[i];
        i++;
        n++;
      }
      return answers;
    }
  },
  mounted () {
    axios
    .get(`/api/v1/nodes/${this.$route.params.id}.json`)
    .then(response => (this.nodes = response.data))
  },
  methods: {
    nextURL: function () {
      axios
      .get(`/api/v1/nodes/3.json`)
      .then(response => (this.nodes = response.data))
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
