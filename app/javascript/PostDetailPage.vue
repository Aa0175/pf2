<template>
<div>
  <organization-chart :datasource="ds"></organization-chart>
</div>
</template>

<script>
  import axios from 'axios';
  import OrganizationChart from 'vue-organization-chart'
  import 'vue-organization-chart/dist/orgchart1.css'

  export default {
    components: {
      OrganizationChart
    },
    data () {
      return {
        ds: {},     //ds == [{nodes中身},{nodes中身},.....]
      }
    },
    mounted () {
      axios
        .get(`/api/v1/posts/${this.$route.params.id}.json`)
        .then(response => (this.ds = response.data))
    }
  }
</script>


<style scoped>
</style>
