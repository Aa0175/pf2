<template>
<div class="ui one column stackable center aligned page grid">
  <div class="column fourteen wide">
    <div class="ui segment users_box">
      <h1>Q:{{ arrangeQ.content }}</h1>
      <div v-for="n in arrangeA" :key="n.id">
          <router-link class="ui segment attached button" :to="{ name: 'Q_and_A', params: { id: n.id } }" >
            A:{{ n.content }}
          </router-link>
      </div>
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
    // ,
    // nextURL: function () {
    //   return "location.href=\'/nodes/" + 選択肢nodeのid + "/#/nodes/" + 選択肢nodeのid'
    //
    //   location.href='/nodes/2/#/nodes/2'
    // }
  },
  mounted () {
    axios
    .get(`/api/v1/nodes?post_id=${this.$route.params.post_id}.json`)
    .then(response => (this.nodes = response.data))
  }
}
</script>

<style scoped>
</style>
