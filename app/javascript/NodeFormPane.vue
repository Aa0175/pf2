<template>
  <form @submit.prevent="$emit('submit')">
    <div v-if="errors.length != 0">
      <ul v-for="e in errors" :key="e">
        <li><font color="red">{{ e }}</font></li>
      </ul>
    </div>
    <div>
      <label>PostID</label>
      <input v-model="node.post_id" type="text">
    </div>
    <div>
      <label>Content</label>
      <input v-model="node.content" type="text">
    </div>
    <div>
      <label>ParentID</label>
      <input v-model="node.parent_id" type="text">
    </div>
    <button type="submit">Commit</button>
  </form>
</template>

<script>
export default {
  props: {
    node: {},
    errors: ''
  }
}
</script>

<style>
</style>
