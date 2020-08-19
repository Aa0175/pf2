<template>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      posts: []
    }
  },
  mounted () {
    axios
      .get('/api/v1/posts.json')
      .then(response => (this.posts = response.data))
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
  width: 90%;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}
</style>
