<template>
  <node-form-pane :errors="errors" :node="node" @submit="createNode"></node-form-pane>
</template>

<script>
import axios from 'axios';

import NodeFormPane from 'NodeFormPane.vue'

export default {
  components: {
    NodeFormPane
  },
  data: function () {
    return {
      node: {
        post_id: '',
        content: '',
        parent_id: '',
      },
      errors: ''
    }
  },
  methods: {
    createNode: function() {
      axios
        .post('/api/v1/nodes', this.node)
        .then(response => {
          let n = response.data;
          this.$router.push({ name: 'NodeDetailPage', params: { id: n.id } });
        })
        .catch(error => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    }
  }
}
</script>

<style scoped>
</style>
