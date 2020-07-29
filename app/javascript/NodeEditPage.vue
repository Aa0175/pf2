<template>
  <node-form-pane :errors="errors" :node="node" @submit="updateNode"></node-form-pane>
</template>

<script>
import axios from 'axios';

import NodeFormPane from 'NodeFormPane.vue';

export default {
  components: {
    NodeFormPane
  },
  data() {
    return {
      node: {},
      errors: ''
    }
  },
  mounted () {
    axios
      .get(`/api/v1/nodes/${this.$route.params.id}.json`)
      .then(response => (this.node = response.data))
  },
  methods: {
    updateNode: function() {
      axios
        .patch(`/api/v1/nodes/${this.node.id}`, this.node)
        .then(response => {
          this.$router.push({ name: 'NodeDetailPage', params: { id: this.node.id } });
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
