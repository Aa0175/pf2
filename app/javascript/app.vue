<template>
  <div>
    <router-view></router-view>
  </div>
</template>

<script>
import Vue from 'vue'
import VueRouter from 'vue-router'

import NodeIndexPage from 'NodeIndexPage.vue'
import NodeDetailPage from 'NodeDetailPage.vue'
import NodeNewPage from 'NodeNewPage.vue'
import NodeEditPage from 'NodeEditPage.vue'
import PostDetailPage from "PostDetailPage.vue"

const router = new VueRouter({
  routes: [
    { path: '/',
      component: NodeIndexPage  },
    { path: '/nodes/:id(\\d+)',// :id は数値のみに制限する
      name: 'NodeDetailPage',
      component: NodeDetailPage  },
    { path: '/nodes/new',
      name: 'NodeNewPage',
      component: NodeNewPage     },
    { path: '/nodes/:id(\\d+)/edit',
      name: 'NodeEditPage',
      component: NodeEditPage   },
    { path: '/posts/:id(\\d+)',
      name: 'PostDetailPage',
      component: PostDetailPage   }
  ]
})

// ref. https://jp.vuejs.org/v2/guide/plugins.html#%E3%83%97%E3%83%A9%E3%82%B0%E3%82%A4%E3%83%B3%E3%81%AE%E4%BD%BF%E7%94%A8
Vue.use(VueRouter)

export default {
  router
}
</script>

<style scoped>
</style>
