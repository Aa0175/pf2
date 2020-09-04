import Vue from 'vue'
import App from '../app_voc.vue'

Vue.config.productionTip = false;
Vue.config.devtools = true;

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)

  console.log(app)
})
