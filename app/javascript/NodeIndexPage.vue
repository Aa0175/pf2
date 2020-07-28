<template>
  <div>
    <div v-if="errors.length != 0">
      <ul v-for="e in errors" :key="e">
        <li><font color="red">{{ e }}</font></li>
      </ul>
    </div>
    <table>
      <tbody>
        <tr>
          <th>ID</th>
          <th>PostID</th>
          <th>Content</th>
          <th>ParentID</th>
          <th>actions</th>
        </tr>
        <tr v-for="n in nodes" :key="n.id">
          <td><router-link :to="{ name: 'NodeDetailPage', params: { id: n.id } }">{{ n.id }}</router-link></td>
          <td>{{ n.post_id }}</td>
          <td>{{ n.content }}</td>
          <td>{{ n.parent_id }}</td>
          <td>
            <button @click="deleteTarget = n.id; showModal = true">Delete</button>
          </td>
        </tr>
      </tbody>
    </table>
    <modal v-if="showModal" @cancel="showModal = false" @ok="deleteNode(); showModal = false;">
      <div slot="body">Are you sure?</div>
    </modal>
  </div>
</template>

<script>
import axios from 'axios';

import Modal from 'Modal.vue'

export default {
  components: {
    Modal
  },
  data: function () {
    return {
      nodes: [],
      showModal: false,
      deleteTarget: -1,
      errors: ''
    }
  },
  mounted () {
    axios
      .get('/api/v1/nodes.json')
      .then(response => (this.nodes = response.data))
      this.updateEmployees();
  },
  methods: {
    deleteNode: function() {
      if (this.deleteTarget <= 0) {
        console.warn('deleteTarget should be grater than zero.');
        return;
      }

      axios
        .delete(`/api/v1/nodes/${this.deleteTarget}`)
        .then(response => {
          this.deleteTarget = -1;
          this.updateNodes();
        })
        .catch(error => {
          console.error(error);
          if (error.response.data && error.response.data.errors) {
            this.errors = error.response.data.errors;
          }
        });
    },
    updateNodes: function() {
      axios
        .get('/api/v1/nodes.json')
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
