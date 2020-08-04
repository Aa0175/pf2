<template>
  <div id="app">
    <vo-basic :data="ds" :pan="true" :zoom="true"></vo-basic>
  </div>
</template>

<script>
new Vue({
  el: '#app',
  data: {
    ds: {
      'name': 'HOME',
      'title': 'HOME',
      'children': [
        { 'name': 'ABOUT', 'title': 'ABOUT' },
        { 'name': 'BLOG', 'title': 'BLOG',
          'children': [
            { 'name': 'POST1', 'title': 'POST1' },
            { 'name': 'CATEGORY', 'title': 'CATEGORY',
              'children': [
                { 'name': 'Vue.js', 'title': 'Vue.js' },
                { 'name': 'Wordpress', 'title': 'Wordpress' }
              ]
            }
          ]
        },
        { 'name': 'CONTACT', 'title': 'CONTACT' },
        { 'name': 'WORK', 'title': 'WORK' }
      ]
    }
  }
});
</script>
