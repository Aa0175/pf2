<template>
  <dl>
    <dt>ID</dt>
    <dd>{{ node.id }}</dd>
    <dt>Content</dt>
    <dd>{{ node.content }}</dd>
    <dt>ParentID</dt>
    <dd>{{ node.parent_id }}</dd>
    <dt>Created Date</dt>
    <dd>{{ node.created_at }}</dd>
    <dt>Upadated Date</dt>
    <dd>{{ node.updated_at }}</dd>
  </dl>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      node: {}
    }
  },
  mounted () {
    axios
      .get(`/api/v1/nodes/${this.$route.params.id}.json`)
      .then(response => (this.node = response.data))
  }
}
</script>

<style scoped>
</style>
